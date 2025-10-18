import 'package:digifarm/activity_log/provider/activity_add_provider.dart';
import 'package:digifarm/flock/models/flock.dart';
import 'package:digifarm/flock/provider/flock_add_provider.dart';
import 'package:digifarm/flock/widget/lamb_selection_screen.dart';
import 'package:digifarm/livestock/models/lamb.dart';
import 'package:digifarm/livestock/widget/livestock_card.dart';
import 'package:digifarm/flock/provider/flock_lambs_provider.dart';
import 'package:digifarm/widgets/custom_button.dart';
import 'package:digifarm/widgets/custom_dropdown.dart';
import 'package:digifarm/widgets/custom_text_field.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FlockAddForm extends ConsumerStatefulWidget {
  const FlockAddForm({super.key,});

  @override
  ConsumerState<FlockAddForm> createState() => _FlockAddFormState();
}

class _FlockAddFormState extends ConsumerState<FlockAddForm> {
  final _formKey = GlobalKey<FormState>();
  var _autovalidate = AutovalidateMode.disabled;

  var _idKandang = '';
  TipeKandang _tipeKandang = TipeKandang.values.first;
  List<Lamb> _ternakDiisi = [];

  void _submitData() async {
    if (!_formKey.currentState!.validate()) {
      setState(() {
        _autovalidate = AutovalidateMode.onUserInteraction;
      });
      return;
    }

    _formKey.currentState!.save();

    await ref
        .read(flockAddProvider.notifier)
        .addFlock(
          id: _idKandang,
          tipeKandang: _tipeKandang,
          hewanTernak: _ternakDiisi,
        );

    if (mounted) Navigator.of(context).pop();
  }

  Future<void> _showLambSelectionScreen(List<Lamb> availableLambs) async {
    final result = await Navigator.of(context).push<List<Lamb>>(
      MaterialPageRoute(
        builder: (context) => LambSelectionScreen(
          availableLambs: availableLambs,
          initialSelection: _ternakDiisi,
        ),
      ),
    );

    if (result != null) {
      setState(() {
        _ternakDiisi = result;
      });
    }
  }

  void _removeLamb(String lambId) {
    setState(() {
      _ternakDiisi.removeWhere((lamb) => lamb.id == lambId);
    });
  }

  void _dummyOnShowSheet(BuildContext context, Lamb lamb) {
    //Dummy agar bisa mengakses card livestock
  }

  @override
  Widget build(BuildContext context) {
    final dombaTersedia = ref.watch(flockLambsProvider(null));
    final isLoading = ref.watch(activityAddProvider).isLoading;
    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;

    return Padding(
      padding: EdgeInsets.fromLTRB(16, 10, 16, keyboardSpace),
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
                      initValue: _idKandang,
                      title: 'ID Kandang',
                      maxLength: 6,
                      validator: (value) {
                        if (value == null || value.trim().length < 3) {
                          return '              ID Minimal 3 Karakter!';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _idKandang = value!.toUpperCase();
                      },
                    ),
                    const SizedBox(height: 10),
                    CustomDropdown(
                      value: _tipeKandang,
                      title: 'Tipe Kandang',
                      items: [
                        for (final tipe in TipeKandang.values)
                          DropdownMenuItem(
                            value: tipe,
                            child: Text(tipe.name.toTitleCaseWithSpaces()),
                          ),
                      ],
                      onChanged: (TipeKandang? value) {
                        setState(() {
                          _tipeKandang = value!;
                        });
                      },
                    ),
                    const SizedBox(height: 20),
                    Align(
                      alignment: Alignment.center,
                      child: dombaTersedia.when(
                        data: (dombaTersedia) => CustomButton(
                              onTap: () =>
                                  _showLambSelectionScreen(dombaTersedia),
                              isLoading: false,
                              size: const Size(140, 35),
                              color: const Color.fromARGB(255, 171, 215, 214),
                              text: 'Tambah Ternak',
                              fontSize: 12,
                            ), 
                        error: (error, stackTrace) => Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            CustomButton(
                                  onTap: () {},
                                  isLoading: true,
                                  size: const Size(140, 35),
                                  color: const Color.fromARGB(255, 171, 215, 214),
                                  text: 'Tambah Ternak',
                                  fontSize: 12,
                                ),
                            SizedBox(height: 10,),
                            Text(
                              'Error ${error.toString()}',
                              style: Theme.of(context).textTheme.titleLarge,)
                          ],
                        ), 
                        loading: () => CustomButton(
                              onTap: () {},
                              isLoading: true,
                              size: const Size(140, 35),
                              color: const Color.fromARGB(255, 171, 215, 214),
                              text: 'Tambah Ternak',
                              fontSize: 12,
                            ))   
                    ),
                    if (_ternakDiisi.isNotEmpty) ...[
                      const SizedBox(height: 10),
                      ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: _ternakDiisi.length,
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 10),
                        itemBuilder: (context, index) {
                          final lamb = _ternakDiisi[index];
                          return Stack(
                            children: [
                              LivestockCard(
                                lamb: lamb,
                                onShowSheet: _dummyOnShowSheet,
                              ),
                              Positioned(
                                right: 10,
                                top: 0,
                                bottom: 0,
                                child: Center(
                                  child: IconButton(
                                    icon: const Icon(
                                      Icons.close,
                                      color: Color.fromARGB(255, 242, 112, 98),
                                      size: 25,
                                    ),
                                    onPressed: () => _removeLamb(lamb.id),
                                    padding: const EdgeInsets.all(6),
                                    constraints: const BoxConstraints(),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                      const SizedBox(height: 20),
                    ],
                  ],
                ),
              ),
            ),
          ),
          SafeArea(
            minimum: const EdgeInsets.only(bottom: 10),
            child: CustomButton(
              onTap: () {
                _submitData();
              },
              isLoading: isLoading,
              color: const Color.fromARGB(255, 142, 200, 100),
            ),
          ),
        ],
      ),
    );
  }
}
