// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_local_variable

import 'package:flutter/material.dart';

class InputText extends StatelessWidget {
  InputText(
      {super.key,
      this.isDescription = true,
      this.maxLine = 1,
      required this.hintText,
      required this.labelText,
      this.descriptionText = '',
      this.controller,
      this.onChanged,
      this.validator});
  final bool isDescription;
  final int maxLine;
  final String hintText;
  final String labelText;
  final String descriptionText;
  final TextEditingController? controller;
  void Function(String)? onChanged;
  String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          labelText,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 13,
            color: Colors.black54.withOpacity(0.75),
          ),
        ),
        SizedBox(
          height: 4,
        ),
        SizedBox(
          height: maxLine > 1 ? maxLine * 24.0 : null,
          child: TextFormField(
            controller: controller,
            onChanged: onChanged,
            validator: validator,
            minLines: maxLine,
            maxLines: null,
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 11.5,
                color: Colors.black12.withOpacity(0.25),
              ),
              contentPadding: EdgeInsets.fromLTRB(14.0, 10.0, 12.0, 15.0),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
                borderSide: BorderSide(
                    color: const Color.fromARGB(255, 39, 39, 39), width: 1.5),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
                borderSide: BorderSide(
                    color: const Color.fromARGB(255, 213, 97, 2), width: 2.0),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 4,
        ),
        Text(
          descriptionText,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 11.5,
            color: Colors.black45,
          ),
        ),
        SizedBox(
          height: 4,
        ),
      ],
    );
  }
}
