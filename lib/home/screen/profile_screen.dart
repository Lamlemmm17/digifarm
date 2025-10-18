import 'package:digifarm/auth/provider/login_provider.dart';
import 'package:digifarm/home/widget/profile_input.dart';
import 'package:digifarm/widgets/custom_button.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  final _nameController = TextEditingController();
  final _locationController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _nameController.dispose();
    _locationController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.fromLTRB(20, 0, 20, keyboardSpace + 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 50),
            Text(
              'My Profile',
              textAlign: TextAlign.start,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            SizedBox(height: 20),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  ProfileInput(
                    controller: _nameController,
                    label: 'Nama Peternakan',
                    hint: 'Masukkan nama peternakan anda',
                    validator: (value) =>
                        value!.isEmpty ? 'Nama Peternakan harus diisi' : null,
                  ),
                  SizedBox(height: 10),
                  ProfileInput(
                    controller: _locationController,
                    label: 'Lokasi Peternakan',
                    hint: 'Masukkan lokasi peternakan anda',
                    validator: (value) =>
                        value!.isEmpty ? 'Lokasi Peternakan harus diisi' : null,
                  ),
                  SizedBox(height: 10),
                  ProfileInput(
                    controller: _emailController,
                    read: true,
                    label: 'email',
                    hint: 'Masukkan alamat email anda',
                    validator: (value) =>
                        value!.isEmpty ? 'Harap login terlebih dahulu' : null,
                  ),
                  SizedBox(height: 10),
                  ProfileInput(
                    controller: _phoneController,
                    label: 'No. Handphone',
                    keyboard: TextInputType.phone,
                    hint: 'Masukkan No. Handphone anda',
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'No. Handphone harus diisi';
                      }
                      if (value.length < 10) {
                        return 'Minimal 10 digit nomor';
                      } else {
                        return null;
                      }
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 50),
            SafeArea(
              child: Center(
                child: CustomButton(
                  color: const Color.fromARGB(255, 242, 112, 98),
                  onTap: ref.read(loginProvider.notifier).signOut,
                  isLoading: false,
                  text: 'LOG OUT',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
