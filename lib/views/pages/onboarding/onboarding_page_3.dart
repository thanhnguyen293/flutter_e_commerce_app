import 'dart:math';

import 'package:flutter/material.dart';

class Onboarding3 extends StatelessWidget {
  const Onboarding3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      width: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Column(
            children: [
              SizedBox(
                height: size.height * 0.08,
              ),
              Stack(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        _NikeTextStroke(),
                        _NikeTextStroke(),
                        _NikeTextStroke(),
                      ],
                    ),
                  ),
                  Positioned(
                    top: size.height * 0.15,
                    // left: 5,

                    child: Transform.rotate(
                      angle: -pi * (32 / 180),
                      child: Image.asset(
                        'assets/images/air_max3.png',
                        width: size.width * 0.87,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _NikeTextStroke extends StatelessWidget {
  const _NikeTextStroke({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Text(
      'NIKE',
      style: TextStyle(
        height: 1.06,
        // color: Color(0xFFFFFFFF),
        fontFamily: 'SF Pro',
        fontSize: size.width * 0.36,
        fontWeight: FontWeight.w800,
        foreground: Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1
          ..color = const Color(0x4CFFFFFF),
      ),
    );
  }
}
