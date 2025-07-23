import 'package:cellula_task/core/styles/app_text_styels.dart';
import 'package:flutter/material.dart';

class ErrorWithRetry extends StatelessWidget {
  final double height;
  final String errorMessage;
  final VoidCallback onPressed;

  const ErrorWithRetry({
    super.key,
    required this.height,
    required this.errorMessage,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            errorMessage,
            textAlign: TextAlign.center,
            style: AppTextStyles.headerStyle,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: onPressed,
            child: const Text('Try Again'),
          ),
        ],
      ),
    );
  }
}
