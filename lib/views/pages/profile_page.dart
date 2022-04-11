import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../themes/constants.dart';
import '../../../themes/light_color.dart';
import '../../../themes/theme.dart';
import '../../../views/pages/edit_profile/edit_profile_page.dart';
import '../../../views/widgets/title_text.dart';
import '../../bloc/app/app_bloc.dart';
import '../../bloc/app/app_event.dart';
import '../../controller/user_repository.dart';
import '../widgets/profile_image.dart';
import '../widgets/profile_menu.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);
  static String routeName = '/profile-page';

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
        child: Column(
          children: [
            const SizedBox(
              height: kDefaultPadding,
            ),
            const ProfileImage(),
            // UserImage(context: context),
            const SizedBox(
              height: kDefaultPadding / 2,
            ),
            const GetUserName(),
            const GetEmail(),
            const SizedBox(
              height: kDefaultPadding,
            ),
            ProfileMenu(
              icon: Icons.account_circle,
              press: () {
                Navigator.of(context).pushNamed(EditProfilePage.routeName);
              },
              title: 'Edit Profile',
            ),
            const SizedBox(
              height: kDefaultPadding,
            ),
            ProfileMenu(
              icon: Icons.dark_mode,
              press: () {},
              title: 'Dark Mode',
            ),
            const SizedBox(
              height: kDefaultPadding,
            ),
            ProfileMenu(
              icon: Icons.notifications,
              press: () {},
              title: 'Notification',
            ),
            const SizedBox(
              height: kDefaultPadding,
            ),
            ProfileMenu(
              icon: Icons.settings,
              press: () {},
              title: 'Setting',
            ),
            const SizedBox(
              height: kDefaultPadding,
            ),
            ProfileMenu(
              icon: Icons.logout_sharp,
              press: () {
                context.read<AppBloc>().add(AppLogoutRequested());
              },
              title: 'Log Out',
            ),

            const SizedBox(
              height: kDefaultPadding,
            ),
          ],
        ),
      ),
    );
  }
}

class GetEmail extends StatelessWidget {
  const GetEmail({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
      future: UserRepository().getUserData(),
      builder: (BuildContext context, snapshot) {
        if (snapshot.hasError) {
          return const Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return const Text("Document does not exist");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          return TitleText(
            text: data['email'],
            fontSize: 14,
            fontWeight: FontWeight.normal,
          );
        }

        return const Text("loading");
      },
    );
  }
}

class GetUserName extends StatelessWidget {
  const GetUserName({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
      future: UserRepository().getUserData(),
      builder: (BuildContext context, snapshot) {
        if (snapshot.hasError) {
          return const Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return const Text("Document does not exist");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          return data['username'] != null
              ? Text(
                  data['username'],
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                )
              : const Text(
                  'Change User Name',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                );
        }

        return const Text("loading");
      },
    );
  }
}

class UserImage extends StatelessWidget {
  const UserImage({
    Key? key,
    required this.context,
  }) : super(key: key);

  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircleAvatar(
        backgroundColor: LightColor.kPrimaryLightColor,
        radius: AppTheme.fullWidth(context) / 7,
        child: const Icon(
          Icons.person,
          size: 60,
        ),
      ),
    );
  }
}
