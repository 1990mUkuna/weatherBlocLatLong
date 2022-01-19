// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

class AppPrimaryButton extends StatelessWidget {
  final Function onPressed;
  final String label;
  final Widget child;
  final bool isLarge;

  AppPrimaryButton({
    @required this.onPressed,
    this.child,
    this.label = "",
    this.isLarge = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: isLarge ? 300 : 150,
      height: 60,
      child: RaisedButton(
        color: const Color(0xFF010035),
        onPressed: onPressed,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: child ??
            Text(
              label,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
      ),
    );
  }
}
