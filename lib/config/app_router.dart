import 'package:flutter/material.dart';

import '../../views/pages/edit_profile/change_password_page.dart';
import '../../views/pages/edit_profile/edit_profile_page.dart';
import '../../views/pages/edit_profile/personal_information_page.dart';
import '../../views/pages/main_page.dart';
import '../../views/pages/product_detail_page.dart';
import '../../views/pages/sign_up/sign_up_page.dart';
import '../models/product_model.dart';
import '../views/pages/login/login_page.dart';

class AppRouter {
  static Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MainPage.route();

      case ProductDetailPage.routeName:
        return ProductDetailPage.route(product: settings.arguments as Product);

      case EditProfilePage.routeName:
        return EditProfilePage.route();

      case PersonalInformationPage.routeName:
        return PersonalInformationPage.route();

      case ChangePasswordPage.routeName:
        return ChangePasswordPage.route();

      case SignUpPage.routeName:
        return SignUpPage.route();

      case LoginPage.routeName:
        return LoginPage.route();

      default:
        return _errorRoute();
    }
  }

  static Route _errorRoute() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: '/error'),
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: const Center(
          child: Text('Something went wrong!'),
        ),
      ),
    );
  }
}
