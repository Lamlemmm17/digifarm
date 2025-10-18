import 'package:digifarm/activity_log/model/activity_log.dart';
import 'package:digifarm/activity_log/provider/activity_add_provider.dart';
import 'package:digifarm/livestock/models/lamb.dart';
import 'package:digifarm/widgets/custom_button.dart';
import 'package:digifarm/widgets/custom_dropdown.dart';
import 'package:digifarm/widgets/custom_text_field.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ActivityAddForm extends ConsumerStatefulWidget {
  const ActivityAddForm({super.key});

  @override
  ConsumerState<ActivityAddForm> createState() => _ActivityAddFormState();
}

class _ActivityAddFormState extends ConsumerState<ActivityAddForm> {
  final _formKey = GlobalKey<FormState>();

  var _autoValidateMode = AutovalidateMode.disabled;

  var _judul = '';
  var _tipeKegiatan = TipeKegiatan.values.first;
  var _isiCatatan = '';
  DateTime _waktu = DateTime.now();

  void _submitData() async {
    if (!_formKey.currentState!.validate()) {
      setState(() {
        _autoValidateMode = AutovalidateMode.onUserInteraction;
      });
      return;
    }
    _formKey.currentState!.save();

    setState(() {
      _waktu = DateTime.now();
    });

    await ref
        .read(activityAddProvider.notifier)
        .addActivity(
          judul: _judul,
          isiCatatan: _isiCatatan,
          tipeKegiatan: _tipeKegiatan,
          waktu: _waktu,
        );

    if (mounted) Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;
    final addState = ref.watch(activityAddProvider);

    return Padding(
      padding: EdgeInsets.fromLTRB(16, 10, 10, keyboardSpace),
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                autovalidateMode: _autoValidateMode,
                child: Column(
                  children: [
                    CustomTextField(
                      title: 'Judul',
                      initValue: _judul,
                      maxLength: 30,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return '               Judul tidak boleh kosong';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _judul = value!;
                      },
                    ),
                    const SizedBox(height: 10),
                    CustomDropdown(
                      value: _tipeKegiatan,
                      title: 'Tipe Kegiatan',
                      items: [
                        for (final tipe in TipeKegiatan.values)
                          DropdownMenuItem(
                            value: tipe,
                            child: Text(tipe.name.toTitleCaseWithSpaces()),
                          ),
                      ],
                      onChanged: (TipeKegiatan? value) {
                        setState(() {
                          _tipeKegiatan = value!;
                        });
                      },
                    ),
                    const SizedBox(height: 10),
                    CustomTextField(
                      title: 'Keterangan',
                      initValue: _isiCatatan,
                      maxLine: 8,
                      onSaved: (value) {
                        _isiCatatan = value!;
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
                      isLoading: addState.isLoading,
                    ),
          ),
        ],
      ),
    );
  }
}
