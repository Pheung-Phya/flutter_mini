import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_mini/bloc/auth/auth_bloc.dart';

class OtpScreen extends StatefulWidget {
  final String email;
  final String name;
  final String password;
  final String passwordConfirmation;
  const OtpScreen({
    super.key,
    required this.email,
    required this.name,
    required this.password,
    required this.passwordConfirmation,
  });

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final _otpController = TextEditingController();
  bool isLoading = false;

  void submit() {
    if (_otpController.text.length != 6) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Enter 6-digit OTP code")));
      return;
    }

    context.read<AuthBloc>().add(
      OtpVerifyRequested(
        email: widget.email,
        name: widget.name,
        password: widget.password,
        passwordConfirmation: widget.passwordConfirmation,
        otpCode: _otpController.text.trim(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Verify OTP")),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is OtpVerificationSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Email verified successfully!")),
            );
            Navigator.popUntil(context, (route) => route.isFirst);
          } else if (state is OtpVerificationFailure) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.error)));
          }
          if (state is OtpVerificationLoading) {
            setState(() => isLoading = true);
          } else {
            setState(() => isLoading = false);
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Text("Enter the 6-digit OTP sent to ${widget.email}"),
                TextField(
                  controller: _otpController,
                  keyboardType: TextInputType.number,
                  maxLength: 6,
                  decoration: const InputDecoration(hintText: 'OTP Code'),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: isLoading ? null : submit,
                  child:
                      isLoading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text("Verify OTP"),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
