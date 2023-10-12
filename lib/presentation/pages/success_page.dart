import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SuccessPage extends StatelessWidget {
  static String routePath = '/success';

  const SuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.check_circle_outline,
            color: Colors.black,
            size: 100,
          ),
          const SizedBox(height: 20),
          const Text(
            'Payment Successful',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          FilledButton(
            onPressed: () => context.pop(),
            style: FilledButton.styleFrom(
              backgroundColor: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text('Back to Home'),
          ),
        ],
      )),
    );
  }
}
