import 'package:digifarm/livestock/models/lamb.dart';
import 'package:digifarm/livestock/provider/livestock_add_provider.dart';
import 'package:digifarm/livestock/provider/livestock_fetch_provider.dart';
import 'package:digifarm/widgets/custom_button.dart';
import 'package:digifarm/widgets/custom_dropdown.dart';
import 'package:digifarm/widgets/custom_text_field.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

final formatter = DateFormat('dd MMM yyyy');

class LivestockAddForm extends ConsumerStatefulWidget {
  const LivestockAddForm({super.key});

  @override
  ConsumerState<LivestockAddForm> createState() => _LivestockAddFormState();
}

class _LivestockAddFormState extends ConsumerState<LivestockAddForm> {
  final _formKey = GlobalKey<FormState>();
  var _autovalidate = AutovalidateMode.disabled;

  var _ttlController = TextEditingController();

  var _idDomba = '';
  Tipe _tipeDomba = Tipe.values.first;
  Gender _kelaminDomba = Gender.values.first;
  var _beratDomba = '';
  Breed _bangsaDomba = Breed.values.first;
  DateTime _tanggalLahir = DateTime.now();
  StatusKesehatan _statusKesehatan = StatusKesehatan.values.first;

  Set<String> _existingIds = {};

  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 15, now.month, now.day);

    final pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: firstDate,
      lastDate: now,
    );

    if (pickedDate != null) {
      setState(() {
        _tanggalLahir = pickedDate;
        _ttlController = TextEditingController(
          text: formatter.format(_tanggalLahir),
        );
      });
    }
  }

  //submit data
  void _submitData() async {
    if (!_formKey.currentState!.validate()) {
      setState(() {
        _autovalidate = AutovalidateMode.onUserInteraction;
      });
      return;
    }

    _formKey.currentState!.save();

    await ref
        .read(livestockAddProvider.notifier)
        .addLamb(
          id: _idDomba,
          tipe: _tipeDomba,
          kelamin: _kelaminDomba,
          berat: _beratDomba,
          bangsa: _bangsaDomba,
          tanggalLahir: _tanggalLahir,
          statusKesehatan: _statusKesehatan,
        );

    if (mounted) Navigator.of(context).pop();
  }

  @override
  void initState() {
    super.initState();
    _ttlController = TextEditingController(
      text: formatter.format(_tanggalLahir),
    );
    Future.microtask(() {
      final lambsState = ref.read(livestockFetchProvider);
      setState(() {
        _existingIds = lambsState.lambs
            .map((lamb) => lamb.id.toUpperCase())
            .toSet();
      });
    });
  }

  @override
  void dispose() {
    _ttlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final addLambState = ref.watch(livestockAddProvider);
    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;

    return Padding(
      padding: EdgeInsets.fromLTRB(16, 10, 10, keyboardSpace),
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                autovalidateMode: _autovalidate,
                child: Column(
                  children: [
                    CustomTextField(
                      initValue: _idDomba,
                      maxLength: 6,
                      title: 'ID Domba',
                      validator: (value) {
                        if (value == null || value.trim().length < 3) {
                          return '                       ID Minimal 3 Karakter!';
                        }
                        if (_existingIds.contains(value.toUpperCase())) {
                          return '                       ID Sudah Digunakan!';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _idDomba = value!.toUpperCase();
                      },
                    ),
                    SizedBox(height: 10),
                    CustomDropdown<Tipe>(
                      title: 'Tipe Domba',
                      value: _tipeDomba,
                      items: [
                        for (final tipe in Tipe.values)
                          DropdownMenuItem(
                            value: tipe,
                            child: Text(tipe.name.toTitleCaseWithSpaces()),
                          ),
                      ],
                      onChanged: (Tipe? value) {
                        setState(() {
                          _tipeDomba = value!;
                        });
                      },
                    ),
                    SizedBox(height: 10),
                    CustomDropdown<Gender>(
                      title: 'Kelamin',
                      value: _kelaminDomba,
                      items: [
                        for (final kelamin in Gender.values)
                          DropdownMenuItem(
                            value: kelamin,
                            child: Text(kelamin.name.toTitleCaseWithSpaces()),
                          ),
                      ],
                      onChanged: (Gender? value) {
                        setState(() {
                          _kelaminDomba = value!;
                        });
                      },
                    ),
                    SizedBox(height: 10),
                    CustomTextField(
                      initValue: _beratDomba,
                      maxLength: 5,
                      keyboard: TextInputType.numberWithOptions(),
                      title: 'Berat',
                      prefixText: 'Kg ',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Berat tidak boleh kosong';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _beratDomba = value!;
                      },
                    ),
                    SizedBox(height: 10),
                    CustomDropdown<Breed>(
                      title: 'Bangsa / Ras',
                      value: _bangsaDomba,
                      items: [
                        for (final bangsa in Breed.values)
                          DropdownMenuItem(
                            value: bangsa,
                            child: Text(bangsa.name.toTitleCaseWithSpaces()),
                          ),
                      ],
                      onChanged: (Breed? value) {
                        setState(() {
                          _bangsaDomba = value!;
                        });
                      },
                    ),
                    SizedBox(height: 10),
                    CustomTextField(
                      controller: _ttlController,
                      onTap: _presentDatePicker,
                      suffixIcon: Icons.calendar_month_sharp,
                      readOnly: true,
                      title: 'Tanggal Lahir',
                    ),
                    SizedBox(height: 10),
                    CustomDropdown<StatusKesehatan>(
                      title: 'Kesehatan',
                      value: _statusKesehatan,
                      items: [
                        for (final status in StatusKesehatan.values)
                          DropdownMenuItem(
                            value: status,
                            child: Text(status.name.toTitleCaseWithSpaces()),
                          ),
                      ],
                      onChanged: (StatusKesehatan? value) {
                        setState(() {
                          _statusKesehatan = value!;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          SafeArea(
            minimum: EdgeInsets.only(bottom: 10),
            child: CustomButton(
              onTap: _submitData,
              isLoading: addLambState.isLoading,
            ),
          ),
        ],
      ),
    );
  }
}
