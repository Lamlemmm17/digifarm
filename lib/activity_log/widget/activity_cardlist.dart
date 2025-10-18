import 'package:digifarm/activity_log/model/activity_log.dart';
import 'package:digifarm/activity_log/provider/activity_delete_provider.dart';
import 'package:digifarm/activity_log/provider/activity_fetch_provider.dart';
import 'package:digifarm/activity_log/widget/activity_card.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ActivityCardlist extends ConsumerWidget {
  const ActivityCardlist({super.key, required this.onShowSheet});

  final void Function(BuildContext, ActivityLog) onShowSheet;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncValue = ref.watch(activityFetchProvider);

    return asyncValue.when(
      data: (activityList) {
        if (activityList.isEmpty) {
          return Center(
            child: Text(
              'Kamu belum memiliki catatan',
              maxLines: 2,
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(color: Colors.black),
            ),
          );
        }
        return ListView.builder(
          itemCount: activityList.length,
          itemBuilder: (context, index) {
            final aktivitas = activityList[index];

            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              child: Slidable(
                key: ValueKey(aktivitas.id),
                endActionPane: ActionPane(
                  motion: const ScrollMotion(),
                  extentRatio: 0.2,
                  children: [
                    SlidableAction(
                      onPressed: (context) async {
                        final messenger = ScaffoldMessenger.of(context);
                        final deleteNotifier = ref.read(
                          activityDeleteProvider.notifier,
                        );
                        try {
                          deleteNotifier.deleteActivity(
                            aktivitas.id!,
                          );
                          messenger.clearSnackBars();
                          messenger.showSnackBar(
                            SnackBar(
                              content: Text('Aktivitas berhasil dihapus!'),
                            ),
                          );
                        } catch (error) {
                          messenger.showSnackBar(
                            SnackBar(content: Text('Gagal menghapus: $error')),
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
                child: ActivityCard(activity: activityList[index], onShowSheet: onShowSheet,),
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
