import 'package:digifarm/livestock/models/lamb.dart';
import 'package:digifarm/livestock/widget/livestock_cardlist.dart';
import 'package:digifarm/livestock/widget/livestock_detail_form.dart';
import 'package:digifarm/livestock/widget/summary_bar.dart';
import 'package:digifarm/livestock/widget/livestock_add_form.dart';
import 'package:digifarm/livestock/provider/livestock_fetch_provider.dart';
import 'package:digifarm/widgets/custom_button.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// ✅ Ubah dari StatelessWidget jadi ConsumerStatefulWidget
class LivestockScreen extends ConsumerStatefulWidget {
  const LivestockScreen({super.key});

  @override
  ConsumerState<LivestockScreen> createState() => _LivestockScreenState();
}

class _LivestockScreenState extends ConsumerState<LivestockScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(livestockFetchProvider.notifier).fetchLambs();
    });
  }

  void _showLivestockDetailForm(BuildContext context, Lamb lamb) {
     showModalBottomSheet(
      showDragHandle: true,
      enableDrag: true,
      barrierColor: const Color.fromARGB(100, 0, 0, 0),
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
      ),
      builder: (BuildContext context) {
        return FractionallySizedBox(
          heightFactor: 0.65,
          child: LivestockDetailForm(lamb: lamb),
        );
      },
    );
  }

  void _showAddSheet(BuildContext context) async {
    await showModalBottomSheet(
      showDragHandle: true,
      enableDrag: true,
      barrierColor: const Color.fromARGB(100, 0, 0, 0),
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
      ),
      builder: (BuildContext context) {
        return FractionallySizedBox(
          heightFactor: 0.6,
          child: const LivestockAddForm(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final lambsState = ref.watch(livestockFetchProvider);

    Widget content = LivestockCardList(onShowSheet: _showLivestockDetailForm);

    if (lambsState.isLoading) {
      content = Center(
        child: const SizedBox(
          height: 40,
          width: 40,
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 100,
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Image.asset('assets/images/logo.png'),
        scrolledUnderElevation: 0,
      ),
      body: SafeArea(
        bottom: true,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
          child: Column(
            children: [
              SizedBox(
                width: screenWidth,
                height: 160,
                child: const SummaryBar(),
              ),
              Row(
                children: [
                  Text(
                    'List Data',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () {},
                    icon: Image.asset('assets/images/filter.png'),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Expanded(child: content),
              Center(
                child: CustomButton(
                  isLoading: false,
                  onTap: () {
                    _showAddSheet(context);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
