import 'package:flutter/material.dart';

class UnfocusWidget extends StatelessWidget {
  const UnfocusWidget({
    required this.child,
    super.key,
  });

  final Widget child;

  static void unfocus(BuildContext context) {
    FocusScope.of(context).unfocus();
    FocusManager.instance.primaryFocus?.unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => unfocus(context),
      behavior: HitTestBehavior.translucent,
      child: child,
    );
  }
}
