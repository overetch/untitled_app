import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/core/common/validators.dart';
import 'package:untitled/core/di/di_container.dart';
import 'package:untitled/feature/auth/presentation/bloc/auth_bloc.dart';
import 'package:untitled/presentation/widgets/custom_text_form_field.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(
        userSignUp: DIContainer().get(),
        userLogin: DIContainer().get(),
        userLogout: DIContainer().get(),
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
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                ),
              );
            }
            if(state is AuthSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Registered successfully!'),
                ),
              );
              Navigator.of(context).pop();
            }
          },
          builder: (context, state) {
            return Form(
              key: _formKey,
              child: Column(
                children: [
                  CustomTextFormField(
                    enabled: state is! AuthLoading,
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    labelText: 'Email',
                    hintText: 'Enter your email',
                    validator: Validators.validateEmail,
                  ),
                  const SizedBox(height: 16),
                  CustomTextFormField(
                    enabled: state is! AuthLoading,
                    controller: _nameController,
                    keyboardType: TextInputType.name,
                    labelText: 'Name',
                    hintText: 'Enter your name',
                    validator: (value) =>
                        Validators.validateLength(value, 3, 18),
                  ),
                  const SizedBox(height: 16),
                  CustomTextFormField(
                    enabled: state is! AuthLoading,
                    controller: _pwdController,
                    obscureText: true,
                    labelText: 'Password',
                    hintText: 'Enter your password',
                    validator: Validators.validatePassword,
                  ),
                  const SizedBox(height: 32),
                  CustomTextFormField(
                    enabled: state is! AuthLoading,
                    controller: _pwdConfirmController,
                    obscureText: true,
                    labelText: 'Confirm password',
                    hintText: 'Confirm your password',
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
