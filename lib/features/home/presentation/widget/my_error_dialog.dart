import 'package:flutter/material.dart';

class MyErrorDialog extends StatelessWidget {
  const MyErrorDialog({super.key, required this.icon, required this.content});
  final IconData icon;
  final String content;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      icon: Icon(
        icon,
        color: Theme.of(context).colorScheme.error,
      ),
      title: const Text('حالة البيانات'),
      content: Text(content.toString()),
      actions: <Widget>[
        Center(
          child: TextButton(
              child: const Text('موافق'),
              onPressed: () => {
                    Navigator.of(context).pop(),
                  }),
        ),
      ],
    );
  }
}
