import 'package:digifarm/flock/provider/flock_fetch_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FlockSummary extends ConsumerWidget {
  const FlockSummary({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final int totalFlock = ref.watch(totalFlockProvider);

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
            color: Colors.white,
          ),
          child: Text(
            totalFlock.toString(),
            textAlign: TextAlign.center,
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontSize: 70, color: Colors.black),
          ),
        ),
        SizedBox(height: 10),
        Text(
          'Total',
          style: Theme.of(
            context,
          ).textTheme.titleLarge?.copyWith(color: Colors.black),
        ),
      ],
    );
  }
}
