import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AnimatedSlideUp extends StatefulWidget {
  const AnimatedSlideUp({Key? key}) : super(key: key);

  @override
  State<AnimatedSlideUp> createState() => _AnimatedSlideUpState();
}

class _AnimatedSlideUpState extends State<AnimatedSlideUp>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _position;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    _position = Tween<double>(begin: 10, end: 30).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0, 1),
      ),
    )..addListener(
        () {
          setState(() {});
        },
      );
    _controller.repeat();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: const Alignment(0, 0.8),
      child: Padding(
        padding: EdgeInsets.only(bottom: _position.value),
        child: SvgPicture.asset('assets/icons/arrow_up.svg'),
      ),
    );
  }
}
