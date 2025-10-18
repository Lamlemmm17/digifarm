import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    this.initValue,
    this.controller,
    required this.title,
    this.maxLength,     
    this.validator,     
    this.onTap,         
    this.readOnly = false, 
    this.suffixIcon,    
    this.onSaved,     
    this.prefixText, 
    this.maxLine = 1, 
    this.keyboard,
  }) : assert(controller == null || initValue == null);

  final String? initValue;
  final TextEditingController? controller;
  final String title;
  final int? maxLength; // Menerima null
  final String? Function(String?)? validator;
  final void Function()? onTap;
  final bool readOnly;
  final IconData? suffixIcon;
  final void Function(String?)? onSaved;
  final String? prefixText;
  final int? maxLine;
  final TextInputType? keyboard;

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
              height: maxLine == 1 ? 25 : 175,
              child: TextFormField(
                onTap: onTap,
                readOnly: readOnly,
                onSaved: onSaved,
                controller: controller,
                keyboardType: keyboard,
                initialValue: controller == null ? initValue : null,
                maxLength: maxLength,
                maxLines: maxLine,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontFamily: 'OpenSans',
                  fontSize: 13,
                ),
                decoration: InputDecoration(
                  prefixText: prefixText ,
                  suffixIcon: suffixIcon != null ? Icon(suffixIcon, size: 20, color: const Color.fromARGB(130, 0, 0, 0)) : null,
                  suffixIconConstraints: const BoxConstraints(minWidth: 30, minHeight: 20),
                  counterText: '', 
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color.fromARGB(130, 97, 167, 18),
                      width: 1,
                    ),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color.fromARGB(130, 97, 167, 18),
                      width: 1,
                    ),
                  ),
                  isDense: false, 
                  contentPadding: const EdgeInsets.fromLTRB(5, 10, 5, 0),
                ),
                validator: validator,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
