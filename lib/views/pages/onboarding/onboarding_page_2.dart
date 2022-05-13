import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app/themes/theme.dart';
import 'package:flutter_svg/svg.dart';

class Onboarding2 extends StatelessWidget {
  const Onboarding2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SizedBox(
      width: double.infinity,
      child: Stack(
        children: [
          SafeArea(
            child: Column(
              children: [
                Column(
                  children: [
                    SizedBox(height: size.height * 0.08),
                    SizedBox(
                      child: SvgPicture.asset(
                        'assets/icons/nike_logo.svg',
                        //fit: BoxFit.contain,
                        color: Colors.white,
                        width: AppTheme.fullWidth(context) * 0.44,
                        // height: 200,
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.06,
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: size.height * 0.4,
                      child: Stack(
                        children: [
                          Align(
                            alignment: Alignment.topCenter,
                            child: Text(
                              'NIKE',
                              style: TextStyle(
                                color: const Color(0x99FFFFFF),
                                fontFamily: 'SF Pro',
                                fontSize: size.width * 0.4,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                          Positioned(
                            top: size.height * 0.06,
                            left: size.width * 0.04,
                            width: size.width,
                            height: 334,
                            child: Transform.rotate(
                              angle: pi * (15 / 180),
                              child: Image.asset(
                                  'assets/images/jordan1_travis_scott.png'),
                            ),
                          )
                        ],
                      ),
                    ),
                    Text(
                      'THE BEST',
                      style: TextStyle(
                        color: const Color(0xFFFFFFFF),
                        fontFamily: 'SF Pro',
                        fontSize: size.width * 0.16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
