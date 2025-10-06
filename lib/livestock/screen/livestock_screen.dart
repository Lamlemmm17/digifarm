import 'package:digifarm/livestock/widget/custom_button.dart';
import 'package:digifarm/livestock/widget/list_data.dart';
import 'package:digifarm/livestock/widget/summary_bar.dart';
import 'package:digifarm/livestock/widget/add_lamb.dart';

import 'package:flutter/material.dart';

class LivestockScreen extends StatelessWidget {
  const LivestockScreen({super.key});

  void _showAddSheet(BuildContext context) {
    showModalBottomSheet(
      showDragHandle: true,
      enableDrag: true,
      barrierColor: const Color.fromARGB(100, 0, 0, 0),
      context: context,
      isScrollControlled: true, 
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20.0),
        ),
      ),
      builder: (BuildContext context) {
        // Konten yang dipanggil dari file baru
        return FractionallySizedBox(
          heightFactor: 0.65,
          child: const AddLamb()); 
      },
    );
  }

  @override
  Widget build(BuildContext context) {

    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 100,
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Image.asset('assets/images/logo.png'),
        scrolledUnderElevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(20, 10, 20, 40),
        child: Column(
          children: [
            SizedBox(
              width: screenWidth,
              height: 160,
              child: SummaryBar(),
            ),
            Row(
              children: [
                Text(
                  'List Data',
                  style: Theme.of(context).textTheme.titleMedium,),
                Spacer(),
                IconButton(onPressed: () {}, icon: Image.asset('assets/images/filter.png'))
              ],
              
            ),
            SizedBox(height: 15,),
            Expanded(child: ListData()),
            Center(child: CustomButton(onTap: () {
              _showAddSheet(context);
            },))
          ],
        ),),
    );
  }
}
