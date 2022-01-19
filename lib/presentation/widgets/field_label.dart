import 'package:flutter/material.dart';

class FieldLable extends StatelessWidget {
  final Color textColor;
  final String labelText;
  final String description;
  final double fontSize;
  final bool isMultiline;
  final Function onTap;
  final bool isReadOnly;
  final Function leadingAction;

  FieldLable({
    this.textColor,
    this.labelText,
    this.description,
    this.fontSize,
    this.leadingAction,
    this.isMultiline = false,
    this.onTap,
    this.isReadOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Material(
        child: Text(
      labelText,
      style: textTheme.subtitle1.copyWith(
          fontSize: 14,
          color: const Color(0xFF010035),
          fontWeight: FontWeight.w500),
    ));
  }
}
