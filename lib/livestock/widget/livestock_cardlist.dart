import 'package:digifarm/livestock/provider/livestock_fetch_provider.dart';
import 'package:digifarm/livestock/models/lamb.dart';
import 'package:digifarm/livestock/provider/livestock_delete_provider.dart';
import 'package:digifarm/livestock/widget/livestock_card.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class LivestockCardList extends ConsumerWidget {
  const LivestockCardList({super.key, required this.onShowSheet});

  final void Function(BuildContext, Lamb) onShowSheet;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<Lamb> lambs = ref.watch(livestockFetchProvider).lambs;

    if (lambs.isEmpty) {
      return Center(
        child: Text(
          'Kamu Belum Memiliki Data.',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.black),
          maxLines: 2,
        ),
      );
    } else {
      return ListView.builder(
        itemCount: lambs.length,
        itemBuilder: (context, index) {
          final Lamb lamb = lambs[index];

          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 1),
            child: Slidable(
              key: ValueKey(lamb.id),
              endActionPane: ActionPane(
                motion: const ScrollMotion(),
                extentRatio: 0.2,
                children: [
                  SlidableAction(
                    onPressed: (context) async {
                      final lambsNotifier = ref.read(livestockDeleteProvider.notifier);
                      final scaffoldMessenger = ScaffoldMessenger.of(context);

                      try {
                        await lambsNotifier.deleteLamb(lamb.id);

                        scaffoldMessenger.clearSnackBars();
                        scaffoldMessenger.showSnackBar(
                        
                          SnackBar(
                            content: Text('Domba ID ${lamb.id} telah dihapus!'),
                          ),
                        );

                      ref.watch(livestockFetchProvider.notifier).refreshLambs();
                      } catch (error) {
                        // Tampilkan notifikasi error
                        scaffoldMessenger.showSnackBar(
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
              child: LivestockCard(
                lamb: lamb, 
                onShowSheet: onShowSheet,),
            ),
          );
        },
      );
    }
  }
}
