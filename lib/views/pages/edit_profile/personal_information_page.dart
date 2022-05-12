import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app/themes/constants.dart';
import 'package:flutter_e_commerce_app/themes/light_color.dart';
import 'package:flutter_e_commerce_app/themes/theme.dart';
import 'package:flutter_e_commerce_app/views/widgets/profile_image.dart';
import 'package:flutter_e_commerce_app/views/widgets/title_text.dart';

class PersonalInformationPage extends StatelessWidget {
  const PersonalInformationPage({Key? key}) : super(key: key);

  static const String routeName = '/personal-information-page';
  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => const PersonalInformationPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const TitleText(text: 'Personal Information'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: SizedBox(
                height: 120,
                width: 120,
                child: Stack(
                  children: [
                    const ProfileImage(),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: SizedBox(
                        width: 36,
                        height: 36,
                        child: TextButton(
                          onPressed: () {},
                          style: TextButton.styleFrom(
                            shape: const CircleBorder(),
                            backgroundColor: LightColor.kPrimaryColor,
                          ),
                          child: const Icon(
                            Icons.edit,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: kDefaultPadding,
            ),
            const TitleText(
              text: 'Full Name',
              fontWeight: FontWeight.w700,
            ),
            const SizedBox(height: kDefaultPadding / 2),
            TextField(
              onChanged: (value) {},
              decoration: AppTheme.inputDecoration.copyWith(
                  hintText: 'Full Name',
                  labelStyle: const TextStyle(
                      fontSize: 18, color: LightColor.subTitleTextColor)
                  //hintText: 'Full Name',
                  ),
            ),
            const SizedBox(height: kDefaultPadding),
            const TitleText(
              text: 'Email',
              fontWeight: FontWeight.w700,
            ),
            const SizedBox(height: kDefaultPadding / 2),
            TextField(
              decoration: AppTheme.inputDecoration.copyWith(
                  hintText: 'Email',
                  labelStyle: const TextStyle(
                      fontSize: 18, color: LightColor.subTitleTextColor)
                  //hintText: 'Full Name',
                  ),
            ),
            const SizedBox(height: kDefaultPadding),
            SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: () {},
                style: AppTheme.textButtonStyle,
                child: SizedBox(
                  width: AppTheme.fullWidth(context) * 0.3,
                  child: const Center(
                    child: TitleText(
                      text: 'Save',
                      fontWeight: FontWeight.w600,
                      color: LightColor.bgColor,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: kDefaultPadding / 2,
            ),
            TextButton(
              onPressed: () {},
              style: AppTheme.textButtonStyle.copyWith(
                  backgroundColor: MaterialStateProperty.all(LightColor.grey)),
              child: const Center(
                child: TitleText(
                  text: 'Cancel',
                  fontWeight: FontWeight.w600,
                  color: LightColor.bgColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
