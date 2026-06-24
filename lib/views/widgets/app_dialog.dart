import 'package:flutter/material.dart';

class AppDialog extends StatelessWidget {
  final String title;
  final String message;
  final String buttonLabel;

  const AppDialog({
    super.key,
    required this.title,
    required this.message,
    this.buttonLabel = 'OK',
  });

  static Future<void> show(
    BuildContext context, {
    required String title,
    required String message,
    String buttonLabel = 'OK',
  }) {
    return showDialog(
      context: context,
      builder: (ctx) => AppDialog(
        title: title,
        message: message,
        buttonLabel: buttonLabel,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 17),
      ),
      content: Text(message),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(buttonLabel),
        ),
      ],
    );
  }
}
