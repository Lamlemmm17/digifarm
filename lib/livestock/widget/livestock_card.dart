import 'package:flutter/material.dart';

import 'package:digifarm/livestock/models/lamb.dart';

class LivestockCard extends StatelessWidget {
  const LivestockCard({super.key, required this.lamb, required this.onShowSheet});

  final Lamb lamb;
  final void Function(BuildContext, Lamb) onShowSheet;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onShowSheet(context, lamb);
      },
      child: Container(
        padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: const Color.fromARGB(60, 0, 0, 0),
              blurRadius: 3,
              spreadRadius: 0,
              offset: Offset(0, 6),
            ),
          ],
        ),
        height: 70,
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 55,
              width: 55,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 203, 231, 184),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Image.asset('assets/images/lamb.png'),
            ),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    lamb.id,
                    textAlign: TextAlign.start,
                    maxLines: 1,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Text(
                    '${lamb.displayGender}, ${lamb.displayUmur}, ${lamb.displayKesehatan}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontSize: 14,
                      wordSpacing: 0.01,
                    ),
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
