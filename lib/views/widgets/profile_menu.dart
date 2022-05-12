import 'package:flutter/material.dart';

import '../../views/widgets/title_text.dart';
import '../../themes/constants.dart';
import '../../themes/light_color.dart';

class ProfileMenu extends StatelessWidget {
  const ProfileMenu({
    Key? key,
    required this.title,
    required this.icon,
    required this.press,
    this.iconColor = LightColor.kPrimaryColor,
    this.iconBgColor = LightColor.bgColor,
  }) : super(key: key);

  final String title;
  final icon;
  final Color iconColor;
  final Color iconBgColor;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: LightColor.kPrimaryLightColor,
      borderRadius: BorderRadius.circular(kDefaultRadius / 2),
      child: InkWell(
        onTap: press,
        borderRadius: BorderRadius.circular(kDefaultRadius / 2),
        child: Container(
          //width: AppTheme.fullWidth(context) * 0.85,
          padding: const EdgeInsets.symmetric(
              horizontal: kDefaultPadding, vertical: kDefaultPadding / 2),
          // decoration: BoxDecoration(
          //   borderRadius: BorderRadius.circular(kDefaultRadius / 2),
          // ),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: iconBgColor,
                child: Icon(
                  icon,
                  color: iconColor,
                ),
              ),
              const SizedBox(
                width: kDefaultPadding,
              ),
              Expanded(
                child: TitleText(
                  text: title,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const Icon(
                Icons.arrow_forward_ios,
                size: 22,
              )
            ],
          ),
        ),
      ),
    );
  }
}
