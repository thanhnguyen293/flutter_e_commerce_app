import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app/themes/light_color.dart';
import 'package:flutter_e_commerce_app/themes/theme.dart';
import 'package:flutter_e_commerce_app/views/pages/login/login_page.dart';
import 'package:flutter_svg/svg.dart';

import 'onboarding_page_1.dart';
import 'onboarding_page_2.dart';
import 'onboarding_page_3.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({Key? key}) : super(key: key);

  static const String routeName = '/onboarding';

  static Route route() {
    return MaterialPageRoute<void>(
      settings: const RouteSettings(name: routeName),
      builder: (_) => const OnboardingPage(),
    );
  }

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  late PageController _pageController;
  late int _pageIndex = 0;

  @override
  void initState() {
    _pageController = PageController(initialPage: 0, viewportFraction: 0.999);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> page = [
      const Onboarding1(),
      const Onboarding2(),
      const Onboarding3(),
    ];
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            decoration: const BoxDecoration(color: Colors.black),
            child: Column(
              children: [
                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: page.length,
                    onPageChanged: (value) {
                      setState(() {
                        _pageIndex = value;
                      });
                    },
                    itemBuilder: (ctx, index) {
                      return page[index];
                    },
                  ),
                ),
                _pageIndex != 2
                    ? Row(
                        children: [
                          const SizedBox(width: 36),
                          ...List.generate(
                            3,
                            (index) => Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: DotIndicator(
                                isActive: _pageIndex == index,
                              ),
                            ),
                          ),
                          const Spacer(),
                          _NextButton(pageController: _pageController),
                          const SizedBox(
                            width: 36,
                          )
                        ],
                      )
                    : SizedBox(),
                const SizedBox(
                  height: 60,
                ),
              ],
            ),
          ),
          _pageIndex == 2
              ? Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.5,
                    decoration: const BoxDecoration(
                      gradient: RadialGradient(
                        center: Alignment(0, 1.5), // near the top right
                        radius: 2.5,
                        colors: <Color>[
                          Color(0xffE65828), // yellow sun
                          Color.fromARGB(0, 0, 0, 0), // blue sky
                        ],
                        stops: <double>[0.15, 0.5],
                      ),
                    ),
                  ),
                )
              : const SizedBox(),
          _pageIndex == 2
              ? Align(
                  alignment: const Alignment(0, 0.9),
                  child: InkWell(
                    onTap: () => Navigator.of(context)
                        .pushReplacementNamed(LoginPage.routeName),
                    child: const Text(
                      'Get Started',
                      style: TextStyle(
                        fontFamily: 'SF Pro',
                        fontSize: 24,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),
                    ),
                  ),
                )
              : const SizedBox(),
          _pageIndex == 2
              ? Positioned(
                  bottom: MediaQuery.of(context).size.height * 0.25,
                  left: 0,
                  width: MediaQuery.of(context).size.width,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Text(
                      'BUY NOW',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                        fontSize: MediaQuery.of(context).size.width * 0.15,
                        fontFamily: 'SF Pro',
                      ),
                    ),
                  ),
                )
              : SizedBox(),
        ],
      ),
    );
  }
}

class DotIndicator extends StatelessWidget {
  const DotIndicator({
    Key? key,
    required this.isActive,
  }) : super(key: key);
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 17,
      height: 17,
      decoration: BoxDecoration(
        color: isActive ? Colors.white : Color(0xFF886D6D),
        borderRadius: BorderRadius.circular(17),
      ),
    );
  }
}

class _NextButton extends StatelessWidget {
  const _NextButton({
    Key? key,
    required PageController pageController,
  })  : _pageController = pageController,
        super(key: key);

  final PageController _pageController;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 80,
      height: 80,
      child: ElevatedButton(
        onPressed: () {
          _pageController.nextPage(
            duration: const Duration(milliseconds: 300),
            curve: Curves.ease,
          );
        },
        style: ElevatedButton.styleFrom(
          primary: LightColor.kPrimaryColor,
          shape: const CircleBorder(),
        ),
        child: SvgPicture.asset(
          'assets/icons/arrow_right.svg',
        ),
      ),
    );
  }
}
