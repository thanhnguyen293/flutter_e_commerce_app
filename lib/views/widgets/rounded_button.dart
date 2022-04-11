import 'package:flutter/material.dart';

import '../../themes/constants.dart';
import '../../themes/light_color.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton({
    required this.child,
    Key? key,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: kDefaultPadding / 2),
      padding: const EdgeInsets.symmetric(
          horizontal: kDefaultPadding, vertical: kDefaultPadding / 4),
      width: size.width * 0.85,
      decoration: BoxDecoration(
        color: LightColor.kPrimaryColor,
        borderRadius: BorderRadius.circular(30),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: child,
      ),
    );
  }
}
