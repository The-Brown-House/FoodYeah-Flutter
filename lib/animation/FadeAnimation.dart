import 'package:flutter/material.dart';

class FadeAnimation extends StatefulWidget {
  final Widget child;
  final int duration;
  FadeAnimation(this.child, this.duration);

  @override
  _FadeAnimationState createState() => _FadeAnimationState();
}

class _FadeAnimationState extends State<FadeAnimation>
    with TickerProviderStateMixin {
  AnimationController? controller;
  Animation<double>? animation;
  Animation<Offset>? animation2;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: widget.duration));
    animation = Tween<double>(begin: 0.0, end: 1.0).animate(controller!);
    animation2 = Tween<Offset>(begin: Offset(0, -1), end: Offset(0, 0))
        .animate(controller!);
    controller!.forward();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: animation2!,
      child: FadeTransition(
        opacity: animation!,
        child: widget.child,
      ),
    );
  }
}
