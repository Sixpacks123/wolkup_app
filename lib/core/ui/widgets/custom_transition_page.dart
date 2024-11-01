import 'package:flutter/material.dart';

class CustomTransitionPage extends Page {
  final Widget child;

  CustomTransitionPage({
    required this.child,
    LocalKey? key,
    Duration transitionDuration = const Duration(milliseconds: 300),
    Duration reverseTransitionDuration = const Duration(milliseconds: 300),
  }) : super(key: key);

  @override
  Route createRoute(BuildContext context) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0); // Right
        const end = Offset.zero;
        const curve = Curves.easeInOut;

        final tween = Tween(begin: begin, end: end);
        final offsetAnimation = animation.drive(tween.chain(CurveTween(curve: curve)));

        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
    );
  }
}
