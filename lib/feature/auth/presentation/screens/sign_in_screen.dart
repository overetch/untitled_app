import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:untitled/core/common/validators.dart';
import 'package:untitled/core/common/widgets/unfocus_widget.dart';
import 'package:untitled/core/di/di_container.dart';
import 'package:untitled/core/theme/theme.dart';
import 'package:untitled/feature/auth/presentation/bloc/auth_bloc.dart';
import 'package:untitled/feature/auth/presentation/widgets/login_animation_controller.dart';
import 'package:untitled/feature/auth/presentation/widgets/login_teddy.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(
        userSignUp: DIContainer().get(),
        userLogin: DIContainer().get(),
      ),
      child: const _SignInScreen(),
    );
  }
}

class _SignInScreen extends StatefulWidget {
  const _SignInScreen({super.key});

  @override
  State<_SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<_SignInScreen> {
  late final LoginAnimationController animationController;

  final GlobalKey<FormState> localKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pwdController = TextEditingController();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _pwdFocusNode = FocusNode();
  bool showPassword = false;

  @override
  void initState() {
    _emailController.addListener(emailLengthListener);
    _emailFocusNode.addListener(focusNodeListener);
    _pwdFocusNode.addListener(focusNodeListener);
    super.initState();
  }

  void focusNodeListener() {
    animationController.setIsHandsUp(_pwdFocusNode.hasFocus);
    animationController.setIsChecking(
      _pwdFocusNode.hasFocus || _emailFocusNode.hasFocus,
    );
  }

  void emailLengthListener() {
    animationController.setNumLook(_emailController.text.length, true);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: localKey,
      child: Scaffold(
        backgroundColor: context.color(Palette.authBg),
        body: UnfocusWidget(
          child: SafeArea(
            child: Stack(
              children: [
                Positioned(left: 0, right: 0, child: teddy()),
                body(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget teddy() {
    return SizedBox(
      width: 200,
      height: 200,
      child: LoginTeddy(
        onInit: (controller) {
          animationController = controller;
        },
      ),
    );
  }

  Widget body() {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthFailure) {
          print('error: ${state.message}');
        }
        print('state: $state');
        if (state is AuthSuccess) {

        }
      },
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  'Welcome to Untitled!',
                  style: context.text(Texts.bodyLargeMedium),
                ),
                const SizedBox(height: 180),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: [
                        const SizedBox(height: 32),
                        TextFormField(
                          decoration: const InputDecoration(hintText: 'Email'),
                          controller: _emailController,
                          focusNode: _emailFocusNode,
                          validator: Validators.validateEmail,
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          decoration: const InputDecoration(
                            hintText: 'password',
                          ),
                          controller: _pwdController,
                          focusNode: _pwdFocusNode,
                          obscureText: true,
                          validator: Validators.validatePassword,
                        ),
                        const SizedBox(height: 16),
                        StatefulBuilder(
                          builder: (ctx, setState) {
                            return CheckboxListTile(
                              contentPadding: EdgeInsets.zero,
                              value: showPassword,
                              onChanged: (value) {
                                setState(() {
                                  showPassword = !showPassword;
                                });
                                animationController.setPeeking(showPassword);
                              },
                              title: const Text('Peeking the password'),
                            );
                          },
                        ),
                        const SizedBox(height: 32),
                      ],
                    ),
                  ),
                ),
                // const SizedBox(height: 32),
                ElevatedButton(
                  onPressed: () {
                    context.go('/signUp');
                  },
                  child: const Text('SignUp'),
                ),
                const SizedBox(height: 32),
                ElevatedButton(
                  onPressed: () {
                    context.read<AuthBloc>().add(
                      AuthLogin(
                        password: _pwdController.text.trim(),
                        email: _emailController.text.trim(),
                      ),
                    );
                  },
                  child: const Text('Login'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _emailFocusNode.removeListener(focusNodeListener);
    _pwdFocusNode.removeListener(focusNodeListener);
    _emailController.removeListener(emailLengthListener);
    super.dispose();
  }
}
