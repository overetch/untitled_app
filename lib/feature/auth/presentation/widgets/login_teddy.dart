import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

import 'login_animation_controller.dart';

class LoginTeddy extends StatefulWidget {
  const LoginTeddy({required this.onInit, super.key});

  final ValueChanged<LoginAnimationController> onInit;

  @override
  State<LoginTeddy> createState() => _LoginTeddyState();
}

class _LoginTeddyState extends State<LoginTeddy> {
  late final fileLoader = LocalAssetLoader(path: 'assets/rive/teddy_auth.riv');
  late final LoginAnimationController animationController;

  @override
  Widget build(BuildContext context) {
    return RiveAnimation.asset(
      artboard: 'Teddy',
      onInit: (art) {
        final controller = StateMachineController(art.stateMachines.first);
        controller.stateMachine.inputs.forEach((inputs) {
          print('input: ${inputs.name}');
        });
        art.addController(controller);
        animationController = LoginAnimationController(controller);
        widget.onInit(animationController);
      },
      'assets/rive/teddy_auth.riv',
    );
  }
}
