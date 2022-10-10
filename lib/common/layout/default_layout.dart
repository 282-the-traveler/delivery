import 'package:flutter/material.dart';

class DefaultLayout extends StatelessWidget {
  Color? backgroundColor;
  final Widget child;

  DefaultLayout({Key? key, this.backgroundColor, required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor ?? Colors.white,
      body: child,
    );
  }
}
