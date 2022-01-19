// ignore_for_file: avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String labelText;
  final List<String> autofillHint;
  final TextInputType textInputType;
  final bool isMultiline;
  final List<TextInputFormatter> inputFormatters;
  final Icon leadingIcon;
  final Function onTap;
  final bool isReadOnly;

  AppTextField({
    @required this.controller,
    @required this.hintText,
    this.labelText,
    this.autofillHint,
    this.textInputType = TextInputType.text,
    this.isMultiline = false,
    this.inputFormatters,
    this.leadingIcon,
    this.onTap,
    this.isReadOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    TextTheme theme = Theme.of(context).textTheme;
    return Material(
      child: Container(
        height: 60,
        child: TextFormField(
          onTap: onTap,
          autofillHints: autofillHint,
          style: theme.bodyText1.copyWith(fontSize: 16),
          controller: controller,
          cursorColor: const Color(0xFF010035),
          keyboardType: TextInputType.emailAddress,
          maxLines: isMultiline ? 8 : 1,
          validator: (value) {
            if (value.isEmpty) {
              return "Field cannot be left empty";
            }
            return null;
          },
          readOnly: isReadOnly,
          inputFormatters: inputFormatters,
          decoration: InputDecoration(
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Color(0xFF010035)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Color(0xFF010035)),
            ),
            contentPadding: const EdgeInsets.symmetric(
              vertical: 25.0,
              horizontal: 10.0,
            ),
            // hintText: hintText,
            hintStyle: theme.bodyText1.copyWith(
              fontSize: 16,
              color: const Color(0xFF010035),
            ),
            border: InputBorder.none,
            labelText: hintText,
            labelStyle: theme.bodyText1.copyWith(
              fontSize: 12,
              color: const Color(0xFF010035),
            ),
            filled: true,
            fillColor: const Color(0xFFf4f4f4),
          ),
        ),
      ),
    );
  }
}
