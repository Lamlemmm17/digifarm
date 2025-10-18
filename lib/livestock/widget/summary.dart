import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:digifarm/livestock/provider/livestock_fetch_provider.dart';

class Summary extends ConsumerWidget {
  const Summary({super.key, required this.index});

  final int index;

  @override
  Widget build(BuildContext context, WidgetRef ref ) {
    int total = 0;
    String description = 'Total';

    if (index == 0){
      total = ref.watch(femaleLambsProvider);
      description = 'Betina';
    }
    if (index == 1){
      total = ref.watch(totalLambsProvider);
      description = 'total';
    }
    if (index == 2){
      total = ref.watch(maleLambsProvider);
      description = 'Jantan';
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 110,
          height: 100,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey[400]!,
                blurRadius: 2,
                spreadRadius: 0.5,
              ),
            ],
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: const Color.fromARGB(255, 205, 214, 227),
              width: 2,
            ),
            color: Colors.white
          ),
          child: Text(
            total.toString(),
            textAlign: TextAlign.center,
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontSize: 70, color: Colors.black),
          ),
        ),
        SizedBox(height:10),
        Text(
          description,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: Colors.black,
          ),)
      ],
    );
  }
}
