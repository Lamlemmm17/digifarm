import 'package:digifarm/livestock/models/lamb.dart';
import 'package:digifarm/livestock/widget/livestock_card.dart';
import 'package:digifarm/widgets/custom_button.dart';

import 'package:flutter/material.dart';

class LambSelectionScreen extends StatefulWidget {
  const LambSelectionScreen({
    super.key,
    required this.availableLambs,
    required this.initialSelection,
  });

  final List<Lamb> availableLambs;
  final List<Lamb> initialSelection;

  @override
  State<LambSelectionScreen> createState() => _LambSelectionScreenState();
}

class _LambSelectionScreenState extends State<LambSelectionScreen> {
  late List<Lamb> _selectedLambs;

  @override
  void initState() {
    super.initState();
    _selectedLambs = List.from(widget.initialSelection);
  }

  bool _isSelected(Lamb lamb) {
    return _selectedLambs.any((l) => l.id == lamb.id);
  }

  void _toggleSelection(Lamb lamb) {
    setState(() {
      if (_isSelected(lamb)) {
        _selectedLambs.removeWhere((l) => l.id == lamb.id);
      } else {
        _selectedLambs.add(lamb);
      }
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
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: const Color.fromARGB(69, 0, 0, 0),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Tersedia: ${widget.availableLambs.length} ternak',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.bold
                      ),
                ),
                Text(
                  'Dipilih: ${_selectedLambs.length}',
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: widget.availableLambs.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Tidak ada ternak tersedia',
                          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            color: Colors.black
                          )
                        ),
                      ],
                    ),
                  )
                : ListView.separated(
                    padding: const EdgeInsets.all(16),
                    itemCount: widget.availableLambs.length,
                    separatorBuilder: (context, index) => const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final lamb = widget.availableLambs[index];
                      final isSelected = _isSelected(lamb);
                      return Container(
                        decoration: BoxDecoration(
                          border: isSelected
                              ? Border.all(
                                  color: const Color.fromARGB(255, 142, 200, 100),
                                  width: 3,
                                )
                              : null,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: LivestockCard(
                          lamb: lamb,
                          onShowSheet: (context, l) => _toggleSelection(l),
                        ),
                      );
                    },
                  ),
          ),
          SafeArea(
            minimum: EdgeInsets.only(bottom: 10),
            child: CustomButton(
              onTap: () {
                Navigator.of(context).pop(_selectedLambs);
              },
              isLoading: false,
              size: const Size(200, 50),
              color: const Color.fromARGB(255, 142, 200, 100),
              text: 'Tambah Ternak (${_selectedLambs.length})',
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}