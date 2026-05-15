import 'package:flutter/material.dart';

class AuthDividerWithLabel extends StatelessWidget {
  const AuthDividerWithLabel({super.key, required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme.labelMedium;
    return Row(
      children: [
        const Expanded(child: Divider(height: 1)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Text(label, style: style),
        ),
        const Expanded(child: Divider(height: 1)),
      ],
    );
  }
}
