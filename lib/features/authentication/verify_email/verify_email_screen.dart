import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/verify_email_cubit.dart';
import '../cubit/verify_email_state.dart';
import '../services/verify_email_service.dart';

class VerifyEmailScreen extends StatefulWidget {
  final String token;

  const VerifyEmailScreen({Key? key, required this.token}) : super(key: key);

  @override
  State<VerifyEmailScreen> createState() => _VerifyEmailScreenState();
}

class _VerifyEmailScreenState extends State<VerifyEmailScreen> {
  @override
  void initState() {
    super.initState();
    context.read<VerifyEmailCubit>().verifyEmail(widget.token);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<VerifyEmailCubit, VerifyEmailState>(
        listener: (context, state) {
          if (state is VerifyEmailSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Email verified successfully!')),
            );
            // Navigate to login screen or home screen
            Navigator.of(context).pushReplacementNamed('/login');
          } else if (state is VerifyEmailError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        child: BlocBuilder<VerifyEmailCubit, VerifyEmailState>(
          builder: (context, state) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (state is VerifyEmailLoading)
                    const CircularProgressIndicator()
                  else if (state is VerifyEmailSuccess)
                    const Icon(Icons.check_circle, color: Colors.green, size: 48)
                  else if (state is VerifyEmailError)
                    const Icon(Icons.error, color: Colors.red, size: 48),
                  const SizedBox(height: 16),
                  Text(
                    state is VerifyEmailLoading
                        ? 'Verifying your email...'
                        : state is VerifyEmailSuccess
                            ? 'Email verified successfully!'
                            : state is VerifyEmailError
                                ? 'Failed to verify email'
                                : 'Verifying email...',
                    style: const TextStyle(fontSize: 18),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
} 