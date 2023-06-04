import 'package:axlerate/src/features/authentication/presentation/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TestHome extends ConsumerWidget {
  const TestHome({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.blue.shade100,
      body: Center(
        child: GestureDetector(
          onTap: () async {
            await ref.read(authStateProvider.notifier).logout();
          },
          child: const Text(
            'Welcome to Dashboard',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
