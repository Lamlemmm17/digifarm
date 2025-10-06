import 'package:flutter/material.dart';

class CustomField extends StatelessWidget {
  const CustomField({
    super.key,
    required this.controller,
    required this.keyboard,
    required this.title,
  });

  final TextEditingController controller;
  final TextInputType keyboard;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
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
          SizedBox(width: 10),
          Expanded(
            child: SizedBox(
              height: 25,
              child: TextFormField(
                keyboardType: keyboard,
                controller: controller,
                maxLines: 1,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontFamily: 'OpenSans',
                  fontSize: 13,
                ),
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: const Color.fromARGB(130, 97, 167, 18),
                      width: 1
                    ),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: const Color.fromARGB(130, 97, 167, 18),
                    ),
                  ),
                  isDense: false,
                  contentPadding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
