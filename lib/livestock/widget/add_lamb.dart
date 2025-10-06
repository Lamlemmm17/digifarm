import 'package:digifarm/livestock/widget/custom_button.dart';
import 'package:digifarm/livestock/widget/custom_field.dart';
import 'package:flutter/material.dart';

class AddLamb extends StatefulWidget {
  const AddLamb({super.key});

  @override
  State<AddLamb> createState() => _AddLambState();
}

class _AddLambState extends State<AddLamb> {
  final _formKey = GlobalKey<FormState>();

  final _idController = TextEditingController();
  final _tipeController = TextEditingController();
  final _kelaminController = TextEditingController();
  final _beratController = TextEditingController();
  final _bangsaController = TextEditingController();
  final _tanggalLahirController = TextEditingController();
  final _umurController = TextEditingController();
  final _kesehatanController = TextEditingController();

  @override
  void dispose() {
    _idController.dispose();
    _tipeController.dispose();
    _kelaminController.dispose();
    _beratController.dispose();
    _bangsaController.dispose();
    _tanggalLahirController.dispose();
    _umurController.dispose();
    _kesehatanController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16,  10, 10, 40),
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  children: [
                    CustomField(
                      controller: _idController,
                      keyboard: TextInputType.text,
                      title: 'ID Domba',
                    ), // pake 13 character supaya panjangnya sama semua
                    SizedBox(height:  10,),
                    CustomField(
                      controller: _tipeController,
                      keyboard: TextInputType.text,
                      title: 'Tipe Domba',
                    ),
                     SizedBox(height:  10,),
                    CustomField(
                      controller: _kelaminController,
                      keyboard: TextInputType.text,
                      title: 'Jenis Kelamin',
                    ),
                     SizedBox(height:  10,),
                    CustomField(
                      controller: _beratController,
                      keyboard: TextInputType.text,
                      title: 'Berat',
                    ),
                     SizedBox(height:  10,),
                    CustomField(
                      controller: _bangsaController,
                      keyboard: TextInputType.text,
                      title: 'Bangsa',
                    ),
                     SizedBox(height:  10,),
                    CustomField(
                      controller: _tanggalLahirController,
                      keyboard: TextInputType.text,
                      title: 'Tanggal Lahir',
                    ),
                     SizedBox(height:  10,),
                    CustomField(
                      controller: _umurController,
                      keyboard: TextInputType.text,
                      title: 'Umur',
                    ),
                     SizedBox(height:  10,),
                    CustomField(
                      controller: _kesehatanController,
                      keyboard: TextInputType.text,
                      title: 'Kesehatan',
                    ),
                  ],
                ),
              ),
            ),
          ),
          CustomButton(onTap: () {} )
        ],
      ),
    );
  }
}
