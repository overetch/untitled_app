import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/core/common/validators.dart';
import 'package:untitled/core/di/di_container.dart';
import 'package:untitled/feature/auth/presentation/bloc/auth_bloc.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(
        userSignUp: DIContainer().get(),
        userLogin: DIContainer().get(),
      ),
      child: const _SignUpScreen(),
    );
  }
}

class _SignUpScreen extends StatefulWidget {
  const _SignUpScreen({super.key});

  @override
  State<_SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<_SignUpScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _pwdController = TextEditingController();
  final TextEditingController _pwdConfirmController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _pwdController.dispose();
    _pwdConfirmController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sign Up')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthFailure) {
              print('error: ${state.message}');
            }
            print('state: $state');
          },
          builder: (context, state) {
            return Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      hintText: 'Enter your email',
                      prefixIcon: Icon(Icons.email),
                    ),
                    validator: Validators.validateEmail,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _nameController,
                    keyboardType: TextInputType.name,
                    decoration: const InputDecoration(
                      labelText: 'Name',
                      hintText: 'Enter your name',
                      prefixIcon: Icon(Icons.email),
                    ),
                    validator: (value) =>
                        Validators.validateLength(value, 3, 18),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _pwdController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'Password',
                      hintText: 'Enter your password',
                      prefixIcon: Icon(Icons.lock),
                    ),
                    validator: Validators.validatePassword,
                  ),
                  const SizedBox(height: 32),
                  TextFormField(
                    controller: _pwdConfirmController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'Confirm password',
                      hintText: 'Confirm your password',
                      prefixIcon: Icon(Icons.lock),
                    ),
                    validator: (value) {
                      return Validators.validateConfirmPassword(
                        value,
                        _pwdController.text,
                      );
                    },
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        context.read<AuthBloc>().add(
                          AuthSignUp(
                            password: _pwdController.text.trim(),
                            email: _emailController.text.trim(),
                            name: 'name',
                          ),
                        );
                      }
                    },
                    child: const Text('SignUp'),
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
