import 'package:digifarm/activity_log/widget/activity_add_form.dart';
import 'package:digifarm/activity_log/widget/activity_cardlist.dart';
import 'package:digifarm/activity_log/widget/activity_detail_form.dart';
import 'package:digifarm/activity_log/model/activity_log.dart';
import 'package:digifarm/widgets/custom_button.dart';

import 'package:flutter/material.dart';

class ActivityScreen extends StatefulWidget {
  const ActivityScreen({super.key});

  @override
  State<ActivityScreen> createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen> {

  void _showAddActivitySheet (BuildContext context) async {
    await showModalBottomSheet(
      showDragHandle: true,
      enableDrag: true,
      barrierColor: Color.fromARGB(100, 0, 0, 0),
      isScrollControlled: true,
      isDismissible: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
      ),
      context: context, 
      builder: (context){
        return FractionallySizedBox(heightFactor: 0.6, child: ActivityAddForm());
      });
  }

  void _showDetailActivitySheet (BuildContext context, ActivityLog data) async {
    await showModalBottomSheet(
      showDragHandle: true,
      enableDrag: true,
      barrierColor: Color.fromARGB(100, 0, 0, 0),
      isScrollControlled: true,
      isDismissible: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
      ),
      context: context, 
      builder: (context){
        return FractionallySizedBox(heightFactor: 0.6, child: ActivityDetailForm(data: data,));
      });
  }

  @override
  Widget build(BuildContext context) {
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
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    'List Data',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Spacer(),
                  IconButton(
                    onPressed: () {},
                    icon: Image.asset('assets/images/filter.png'),
                  ),
                ],
              ),
              Expanded(child: ActivityCardlist(onShowSheet: _showDetailActivitySheet,)),
              Center(child: CustomButton(isLoading: false, onTap: () {
                _showAddActivitySheet(context);
                
              })),
            ],
          ),
        ),
      ),
    );
  }
}
