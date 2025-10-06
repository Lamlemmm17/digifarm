import 'package:digifarm/livestock/provider/lambs_provider.dart';
import 'package:digifarm/livestock/models/lamb.dart';
import 'package:digifarm/livestock/widget/lamb_item.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ListData extends ConsumerWidget {
  const ListData({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<Lamb> lambs = ref.watch(lambsProvider);

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
                  onPressed: (context) {},
                  backgroundColor: const Color.fromARGB(255, 242, 112, 98),
                  foregroundColor: Colors.white,
                  icon: Icons.delete,
                  label: 'Hapus',
                ),
              ],
            ),
            child: LambItem(lamb: lamb),
          ),
        );
      },
    );
  }
}
