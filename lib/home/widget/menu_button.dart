import 'package:digifarm/activity_log/screen/activity_screen.dart';
import 'package:digifarm/flock/screen/flock_screen.dart';
import 'package:digifarm/livestock/screen/livestock_screen.dart';
import 'package:flutter/material.dart';

class MenuButton extends StatelessWidget {
  const MenuButton({
    super.key,
    required this.iconBgColor,
    required this.menuIcon,
    required this.title,
    required this.description,
  });

  final Image menuIcon;
  final Color iconBgColor;
  final String title;
  final String description;

  void _onSelectMenu(BuildContext context) {
    if (title == 'Livestock Data') {
      Navigator.of(
        context,
      ).push(MaterialPageRoute(builder: (context) => LivestockScreen()));
    }
    if (title == 'Activity Log') {
      Navigator.of(
        context,
      ).push(MaterialPageRoute(builder: (context) => ActivityScreen()));
    }
    if (title == 'Flock Data') {
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => FlockScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        _onSelectMenu(context);
      },
      
      child: Container(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.black26),
          boxShadow: [
            BoxShadow(
              color: const Color.fromARGB(31, 0, 0, 0),
              blurRadius: 10,
              spreadRadius: 1,
            ),
          ],
        ),
        height: 100,
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                color: iconBgColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: menuIcon,
            ),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    textAlign: TextAlign.start,
                    maxLines: 1,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Text(
                    description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios_rounded),
          ],
        ),
      ),
    );
  }
}
