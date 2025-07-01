import 'package:flutter/cupertino.dart';
  import 'package:flutter/material.dart';

  class RememberForgotWidget extends StatelessWidget {
    final bool rememberMe;
    final ValueChanged<bool> onRememberChanged;
    final VoidCallback onForgotPassword; // Callback for "Forgot password?"

    const RememberForgotWidget({
      Key? key,
      required this.rememberMe,
      required this.onRememberChanged,
      required this.onForgotPassword, // Required callback
    }) : super(key: key);

    @override
    Widget build(BuildContext context) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Remember me
          Row(
            children: [
              SizedBox(
                width: 24,
                height: 24,
                child: Checkbox(
                  value: rememberMe,
                  onChanged: (value) => onRememberChanged(value ?? false),
                  activeColor: Colors.purple,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              const Text(
                'Remember me',
                style: TextStyle(fontSize: 14, color: Colors.black87),
              ),
            ],
          ),
          // Forgot password
          GestureDetector(
            onTap: onForgotPassword, // Trigger the callback
            child: const Text(
              'Forgot password?',
              style: TextStyle(
                fontSize: 14,
                color: Colors.black87,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      );
    }
  }