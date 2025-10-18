import 'package:digifarm/flock/models/flock.dart';

import 'package:flutter/material.dart';

class FlockCard extends StatelessWidget{
  const FlockCard ({super.key, required this.flock, required this.onShowSheet});

  final Flock flock;
  final void Function(BuildContext, Flock) onShowSheet;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onShowSheet(context, flock);
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
                color: const Color.fromARGB(255, 167, 213, 212),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Image.asset('assets/images/fence.png'),
            ),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    flock.id,
                    textAlign: TextAlign.start,
                    maxLines: 1,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Text(
                    '${flock.displayTipeKandang}, ${flock.hewanTernak.length} Domba',
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