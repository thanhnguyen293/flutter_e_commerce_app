import 'dart:math';

import 'package:flutter/material.dart';

import '../../../themes/theme.dart';

class Onboarding1 extends StatelessWidget {
  const Onboarding1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Onboarding1Background(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 36),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: AppTheme.fullHeight(context) * 0.3,
            ),
            const Content(),
          ],
        ),
      ),
    );
  }
}

class Onboarding1Background extends StatelessWidget {
  const Onboarding1Background({
    Key? key,
    required this.child,
  }) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final sizeWidth = AppTheme.fullWidth(context);
    return SizedBox(
      width: double.infinity,
      child: Stack(
        children: [
          Positioned(
            left: -sizeWidth * 0.55 / 2 + sizeWidth * 0.55 / 4,
            top: -sizeWidth * 0.71 / 2 + sizeWidth * 0.71 / 4,
            width: sizeWidth * 0.55,
            height: sizeWidth * 0.71,
            child: Transform.rotate(
              angle: -pi * (43 / 180),
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFB49CBD),
                  borderRadius: BorderRadius.circular(40),
                ),
              ),
            ),
          ),
          Positioned(
            left: -sizeWidth * 0.55 / 2 + sizeWidth * 0.55 / 4,
            top: -sizeWidth * 0.71 / 2 + sizeWidth * 0.71 / 4,
            width: sizeWidth * 0.65,
            height: sizeWidth * 0.71,
            child: Transform.rotate(
              angle: -pi * (43 / 180),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 15, bottom: 20),
                  child: Image.asset(
                    'assets/images/nike-air-max.png',
                    width: sizeWidth * 0.65,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            right: -sizeWidth * 0.17,
            top: sizeWidth * 0.2,
            width: sizeWidth * 0.53,
            height: sizeWidth * 0.4,
            child: Transform.rotate(
              angle: pi * (-30 / 180),
              child: Container(
                // width: 169,
                // height: 220,
                decoration: BoxDecoration(
                  color: const Color(0xFFECF683),
                  borderRadius: BorderRadius.circular(40),
                ),
              ),
            ),
          ),
          Positioned(
            right: -sizeWidth * 0.17,
            top: sizeWidth * 0.2,
            width: sizeWidth * 0.53,
            height: sizeWidth * 0.4,
            child: Transform.rotate(
              angle: pi * (-30 / 180),
              child: Image.asset(
                'assets/images/nike_air_max2.png',
                width: 220,
                fit: BoxFit.cover,
              ),
            ),
          ),
          child,
        ],
      ),
    );
  }
}

class Content extends StatelessWidget {
  const Content({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'The',
          style: TextStyle(
            // color: Color(0xFFFFFFFF),
            fontFamily: 'SF Pro',
            fontSize: 68,
            fontWeight: FontWeight.w600,
            foreground: Paint()
              ..style = PaintingStyle.stroke
              ..strokeWidth = 1
              ..color = Colors.white,
          ),
        ),
        const Text(
          'Awesome',
          style: TextStyle(
            color: Color(0xFFFFFFFF),
            fontFamily: 'SF Pro',
            fontSize: 68,
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          'Branded',
          style: TextStyle(
            // color: Color(0xFFFFFFFF),
            fontFamily: 'SF Pro',
            fontSize: 68,
            fontWeight: FontWeight.w600,
            foreground: Paint()
              ..style = PaintingStyle.stroke
              ..strokeWidth = 1
              ..color = Colors.white,
          ),
        ),
        const Text(
          'Shoes',
          style: TextStyle(
            color: Color(0xFFFFFFFF),
            fontFamily: 'SF Pro',
            fontSize: 68,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
