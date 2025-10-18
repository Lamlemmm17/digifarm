import 'package:digifarm/flock/models/flock.dart';
import 'package:digifarm/flock/widget/flock_add_form.dart';
import 'package:digifarm/flock/widget/flock_cardlist.dart';
import 'package:digifarm/flock/widget/flock_detail_form.dart';
import 'package:digifarm/flock/widget/flock_summary.dart';
import 'package:digifarm/widgets/custom_button.dart';

import 'package:flutter/material.dart';

class FlockScreen extends StatefulWidget {
  const FlockScreen({super.key});

  @override
  State<FlockScreen> createState() => _FlockScreenState();
}

class _FlockScreenState extends State<FlockScreen> {

  void _showFlockDetailForm(BuildContext context, Flock flock) async {
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
          heightFactor: 0.65,
          child: FlockDetailForm(flock),
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
          child: const FlockAddForm(),
        );
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
      body: SafeArea(
        bottom: true,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
          child: Column(
            children: [
              SizedBox(
                width: screenWidth,
                height: 160,
                child: FlockSummary(),
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
              Expanded(child: FlockCardlist(onShowSheet: _showFlockDetailForm,)),
              Center(child: CustomButton(
              onTap: () {
                _showAddSheet(context);
              },
              isLoading: false,
              color: const Color.fromARGB(255, 142, 200, 100),
            ),)
            ],
          ),
        ),
      ),
    );
  }
}
