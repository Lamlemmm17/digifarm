import 'package:digifarm/home/widget/menu_button.dart';
import 'package:flutter/material.dart';

class MenuScreen extends StatelessWidget {
  
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 50),
            Text(
              'Selamat Datang!',
              textAlign: TextAlign.start,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Text(
              'Manajemen Peternakan apa yang ingin anda lakukan hari ini?',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.start,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            SizedBox(height: 20),
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  MenuButton(
                    iconBgColor: const Color.fromARGB(255, 203, 231, 184),
                    menuIcon: Image.asset('assets/images/lamb.png'),
                    title: 'Livestock Data',
                    description:
                        'Pada menu ini anda dapat mengelola data hewan ternak anda!',
                  ),
                  SizedBox(height: 15),
                  MenuButton(
                    iconBgColor: const Color.fromARGB(255, 247, 183, 178),
                    menuIcon: Image.asset('assets/images/notes.png'),
                    title: 'Activity Log',
                    description:
                        'Pada menu ini anda dapat mengelola catatan aktivitas anda!',
                  ),
                  SizedBox(height: 15),
                  MenuButton(
                    iconBgColor: const Color.fromARGB(255, 167, 213, 212),
                    menuIcon: Image.asset('assets/images/fence.png'),
                    title: 'Flock Data',
                    description:
                        'Pada menu ini anda dapat mengelola data kandang anda!',
                  ),
                
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
