import 'package:flutter/material.dart';

class ActionFab extends StatefulWidget {
  const ActionFab({super.key});

  @override
  State<ActionFab> createState() => _ActionFabState();
}

class _ActionFabState extends State<ActionFab>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _mainFabOpacity;
  late Animation<double> _actionsPosition;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _mainFabOpacity = CurvedAnimation(
      parent: _animationController,
      curve: Curves.bounceInOut,
    );
    _actionsPosition = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
      reverseCurve: Curves.easeIn
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: TapRegion(
        onTapOutside: (_) {
          _animationController.reverse();
        },
        child: Stack(
          alignment: Alignment.bottomRight,
          clipBehavior: Clip.none,
          children: [
            AnimatedBuilder(
              animation: _actionsPosition,
              builder: (context, child) {
                return Opacity(
                  opacity: _mainFabOpacity.value,
                  child: Transform.translate(
                    offset: Offset(
                      -100 * _actionsPosition.value,
                      -100 * _actionsPosition.value,
                    ),
                    child: child,
                  ),
                );
              },
              child: FloatingActionButton(
                onPressed: () {},
                child: Icon(Icons.add),
              ),
            ),

            AnimatedBuilder(
              animation: _mainFabOpacity,
              builder: (context, child) {
                return Opacity(opacity: 1 - _mainFabOpacity.value, child: child);
              },
              child: FloatingActionButton(
                onPressed: () {
                  if (_animationController.isDismissed) {
                    _animationController.forward();
                  } else {
                    _animationController.reverse();
                  }
                },
                child: Icon(Icons.menu),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
