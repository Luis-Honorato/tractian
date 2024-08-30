import 'package:flutter/material.dart';

class ErrorPage extends StatelessWidget {
  final String message;
  final Function onTap;
  const ErrorPage({
    super.key,
    required this.message,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GestureDetector(
          onTap: () => onTap.call(),
          child: Text(message),
        ),
      ),
    );
  }
}
