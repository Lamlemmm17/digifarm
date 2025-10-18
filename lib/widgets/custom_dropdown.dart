import 'package:flutter/material.dart';

class CustomDropdown<T> extends StatelessWidget {

  const CustomDropdown({
    super.key,
    required this.value, 
    required this.title,
    required this.items, 
    required this.onChanged, 
  });

  final T value;
  final String title;
  final List<DropdownMenuItem<T>> items;
  final void Function(T?) onChanged;


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              title,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontFamily: 'OpenSans',
                fontSize: 13,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: SizedBox( 
              height: 25,    
              child: DropdownButtonFormField<T>(
                initialValue: value, 
                items: items,
                onChanged: onChanged,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: const Color.fromARGB(130, 97, 167, 18),
                      width: 1,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Color.fromARGB(130, 97, 167, 18),
                      width: 1, 
                    ),
                  ),
                  isDense: true, 
                  contentPadding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                  suffixIcon: const Icon(
                    Icons.arrow_drop_down,
                    size: 27.0, 
                  ),
                  suffixIconConstraints: const BoxConstraints(
                    minWidth: 20, 
                    minHeight: 20,
                  ),
                ),
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontFamily: 'OpenSans',
                  fontSize: 13,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}