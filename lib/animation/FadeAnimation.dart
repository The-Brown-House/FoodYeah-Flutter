import 'package:flutter/material.dart';

class FadeAnimation extends StatefulWidget {
  final Widget child;
  final int duration;
  final int type;
  FadeAnimation(this.child, this.duration, this.type);

  @override
  _FadeAnimationState createState() => _FadeAnimationState();
}

class _FadeAnimationState extends State<FadeAnimation>
    with TickerProviderStateMixin {
  AnimationController? controller;
  Animation<double>? animation;
  Animation<Offset>? animation2;
  double animateYDirection = 0;
  @override
  void initState() {
    //de arriba para abajo
    if (widget.type == 1) {
      animateYDirection = -1;
    }
    //De abajo para arriba
    else {
      animateYDirection = 1;
    }

    super.initState();
    controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: widget.duration));
    animation = Tween<double>(begin: 0.0, end: 1.0).animate(controller!);
    animation2 =
        Tween<Offset>(begin: Offset(0, animateYDirection), end: Offset(0, 0))
            .animate(controller!);
    controller!.forward();
  }

  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
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
