import 'package:flutter/material.dart';
import 'package:untitled/core/theme/theme.dart';
import 'package:untitled/feature/auth/presentation/widgets/login_animation_controller.dart';

import '../widgets/login_teddy.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
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

  @override
  void dispose() {
    _emailFocusNode.removeListener(focusNodeListener);
    _pwdFocusNode.removeListener(focusNodeListener);
    _emailController.removeListener(emailLengthListener);
    super.dispose();
  }

  void focusNodeListener() {
    animationController.setIsHandsUp(_pwdFocusNode.hasFocus);
    animationController.setPeeking(!_emailFocusNode.hasFocus);
  }

  void emailLengthListener() {
    animationController.setNumLook(_emailController.text.length);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: localKey,
      child: Scaffold(
        backgroundColor: context.color(Palette.authBg),
        body: SafeArea(
          child: Stack(
            children: [
              Positioned(left: 0, right: 0, child: teddy()),
              body(),
            ],
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 32),
                    TextFormField(
                      controller: _emailController,
                      focusNode: _emailFocusNode,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _pwdController,
                      focusNode: _pwdFocusNode,
                      obscureText: true,
                    ),
                    const SizedBox(height: 16),
                    StatefulBuilder(
                      builder: (ctx, setState) {
                        return CheckboxListTile(
                          value: showPassword,
                          onChanged: (value) {
                            setState(() {
                              showPassword = !showPassword;
                            });
                            animationController.setPeeking(showPassword);
                          },
                          fillColor: WidgetStatePropertyAll(Colors.red),
                          title: Text('Show password'),
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
              },
              child: Text('Continue'),
            ),
          ],
        ),
      ),
    );
  }
}
