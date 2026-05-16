import 'package:flutter/material.dart';

/// Shown for driver routes that are not implemented yet.
class PlaceholderScreen extends StatelessWidget {
  const PlaceholderScreen({super.key, required this.routeLabel});

  final String routeLabel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Coming soon')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Text(
            'Route "$routeLabel" is not implemented yet.',
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
