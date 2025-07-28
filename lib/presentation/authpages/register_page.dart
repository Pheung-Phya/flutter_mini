import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_mini/bloc/auth/auth_bloc.dart';
import 'package:flutter_mini/data/models/user/register_request.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final nameCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();
  final confirmCtrl = TextEditingController();
  bool isLoading = false;

  void submit() {
    if (!_formKey.currentState!.validate()) return;

    context.read<AuthBloc>().add(
      RegisterRequested(
        RegisterRequest(
          name: nameCtrl.text.trim(),
          email: emailCtrl.text.trim(),
          password: passwordCtrl.text.trim(),
          passwordConfirmation: confirmCtrl.text.trim(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Register")),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          setState(() => isLoading = state is AuthLoading);

          if (state is RegisterSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("OTP sent! Please verify.")),
            );
            Navigator.pushReplacementNamed(
              context,
              '/otp',
              arguments: {
                'name': nameCtrl.text.trim(),
                'email': emailCtrl.text.trim(),
                'password': passwordCtrl.text.trim(),
                'passwordConfirmation': confirmCtrl.text.trim(),
              },
            );
          } else if (state is RegisterFailure) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: ListView(
                children: [
                  TextFormField(
                    controller: nameCtrl,
                    decoration: const InputDecoration(labelText: "Name"),
                    validator: (v) => v!.isEmpty ? "Enter your name" : null,
                  ),
                  TextFormField(
                    controller: emailCtrl,
                    decoration: const InputDecoration(labelText: "Email"),
                    validator:
                        (v) =>
                            v != null && v.contains('@')
                                ? null
                                : "Invalid email",
                  ),
                  TextFormField(
                    controller: passwordCtrl,
                    obscureText: true,
                    decoration: const InputDecoration(labelText: "Password"),
                    validator:
                        (v) =>
                            v != null && v.length >= 6
                                ? null
                                : "Min 6 characters",
                  ),
                  TextFormField(
                    controller: confirmCtrl,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: "Confirm Password",
                    ),
                    validator:
                        (v) =>
                            v == passwordCtrl.text
                                ? null
                                : "Passwords don't match",
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: isLoading ? null : submit,
                    child:
                        isLoading
                            ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              ),
                            )
                            : const Text("Register & Send OTP"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        '/otp',
                        arguments: {
                          'name': nameCtrl.text.trim(),
                          'email': emailCtrl.text.trim(),
                          'password': passwordCtrl.text.trim(),
                          'passwordConfirmation': confirmCtrl.text.trim(),
                        },
                      );
                    },
                    child: Text('next'),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    nameCtrl.dispose();
    emailCtrl.dispose();
    passwordCtrl.dispose();
    confirmCtrl.dispose();
    super.dispose();
  }
}
