import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app/views/pages/edit_profile/change_password_page.dart';
import 'package:flutter_e_commerce_app/views/pages/edit_profile/personal_infomation_page.dart';
import 'package:flutter_e_commerce_app/views/pages/product_detail_page.dart';
import 'package:flutter_e_commerce_app/views/widgets/profile_menu.dart';

import '../../../themes/constants.dart';
import '../../../themes/light_color.dart';
import '../../../themes/theme.dart';
import '../../../views/widgets/title_text.dart';
import '../../widgets/profile_image.dart';

class EditProfilePage extends StatelessWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  static const String routeName = '/edit-profile';
  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => const EditProfilePage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const TitleText(
          text: 'My Account',
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
          child: Form(
            child: Column(
              children: [
                const SizedBox(
                  height: kDefaultPadding / 2,
                ),
                ProfileMenu(
                  title: 'Personal Information',
                  icon: Icons.person,
                  press: () {
                    Navigator.of(context)
                        .pushNamed(PersonalInformationPage.routeName);
                  },
                ),
                const SizedBox(
                  height: kDefaultPadding,
                ),
                ProfileMenu(
                  title: 'Change Password',
                  icon: Icons.key,
                  press: () {
                    Navigator.of(context)
                        .pushNamed(ChangePasswordPage.routeName);
                  },
                ),
                // const SizedBox(height: kDefaultPadding),
                // Container(
                //   width: AppTheme.fullWidth(context) * 0.5,
                //   decoration: BoxDecoration(
                //     color: LightColor.kPrimaryColor,
                //     borderRadius: BorderRadius.circular(kDefaultRadius / 2),
                //   ),
                //   child: TextButton(
                //     onPressed: () {},
                //     child: const TitleText(
                //       text: 'Submit',
                //       color: LightColor.bgColor,
                //       fontWeight: FontWeight.w500,
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ProfileEditField extends StatelessWidget {
  const ProfileEditField({
    Key? key,
    required this.icon,
    required this.hintText,
  }) : super(key: key);
  final IconData icon;
  final String hintText;
  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (value) {},
      decoration: AppTheme.inputDecoration.copyWith(
        prefixIcon: Icon(icon),
        //labelText: 'User Name Change',
        labelStyle: const TextStyle(color: Colors.green),
        fillColor: LightColor.kPrimaryColor,
        hintText: hintText,
      ),
    );
  }
}
