import 'package:digifarm/flock/models/flock.dart';
import 'package:digifarm/flock/provider/flock_delete_provider.dart';
import 'package:digifarm/flock/provider/flock_fetch_provider.dart';
import 'package:digifarm/flock/widget/flock_card.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class FlockCardlist extends ConsumerWidget {
  const FlockCardlist({super.key, required this.onShowSheet});

  final void Function(BuildContext, Flock) onShowSheet;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncValue = ref.watch(flockFetchProvider);

    return asyncValue.when(
      data: (flockList) {
        if (flockList.isEmpty) {
          return Center(
            child: Text(
              'Kamu belum memiliki flock',
              maxLines: 2,
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(color: Colors.black),
            ),
          );
        }
        return ListView.builder(
          itemCount: flockList.length,
          itemBuilder: (context, index) {
            final flock = flockList[index];

            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 1),
              child: Slidable(
                key: ValueKey(flock.id),
                endActionPane: ActionPane(
                  motion: const ScrollMotion(),
                  extentRatio: 0.2,
                  children: [
                    SlidableAction(
                      onPressed: (context) async {
                        final messenger = ScaffoldMessenger.of(context);
                        final notifier = ref.watch(
                          flockDeleteProvider.notifier,
                        );
                        try {
                          notifier.deleteFlock(flock.id);
                          messenger.clearSnackBars();
                          messenger.showSnackBar(
                            SnackBar(
                              content: Text('Berhasil Menghapus Kandang!'),
                            ),
                          );
                        } catch (error) {
                          messenger.showSnackBar(
                            SnackBar(
                              content: Text('Gagal Menghapus, error: $error'),
                            ),
                          );
                        }
                      },
                      backgroundColor: const Color.fromARGB(255, 242, 112, 98),
                      foregroundColor: Colors.white,
                      icon: Icons.delete,
                      label: 'Hapus',
                    ),
                  ],
                ),
                child: FlockCard(flock: flock, onShowSheet: onShowSheet,),
              ),
            );
          },
        );
      },
      error: (error, stackTrace) {
        return Text(
          'Error: $error',
          maxLines: 2,
          style: Theme.of(
            context,
          ).textTheme.titleLarge?.copyWith(color: Colors.black),
        );
      },
      loading: () => const Center(
        child: SizedBox(
          height: 40,
          width: 40,
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
