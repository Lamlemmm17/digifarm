import 'package:digifarm/activity_log/model/activity_log.dart';
import 'package:digifarm/activity_log/provider/activity_update_provider.dart';
import 'package:digifarm/livestock/models/lamb.dart';
import 'package:digifarm/widgets/custom_button.dart';
import 'package:digifarm/widgets/custom_dropdown.dart';
import 'package:digifarm/widgets/custom_text_field.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ActivityDetailForm extends ConsumerStatefulWidget {
  const ActivityDetailForm({super.key, required this.data});

  final ActivityLog data;

  @override
  ConsumerState<ActivityDetailForm> createState() => _ActivityDetailFormState();
}

class _ActivityDetailFormState extends ConsumerState<ActivityDetailForm> {
  final _formKey = GlobalKey<FormState>();

  var _autoValidateMode = AutovalidateMode.disabled;

  late String _id;
  late String _judul;
  late TipeKegiatan _tipeKegiatan;
  late String _isiCatatan;
  late DateTime _waktu;

  @override
  void initState() {
    final ActivityLog initData = widget.data;
    _id = initData.id!;
    _judul = initData.judul;
    _tipeKegiatan = initData.tipeKegiatan;
    _isiCatatan = initData.isiCatatan;
    _waktu = initData.waktu;
    super.initState();
  }

  void _submitData() async {
    if (!_formKey.currentState!.validate()) {
      setState(() {
        _autoValidateMode = AutovalidateMode.onUserInteraction;
      });
      return;
    }
    _formKey.currentState!.save();

    await ref
        .read(activityUpdateProvider.notifier)
        .addActivity(
          id: _id,
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
    final addState = ref.watch(activityUpdateProvider);

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
              text: 'SAVE',
            ),
          ),
        ],
      ),
    );
  }
}
