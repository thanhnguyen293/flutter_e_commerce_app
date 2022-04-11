import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/auth/login/login_cubit.dart';
import '../../../controller/auth_repository.dart';
import 'login_form.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  static const String routeName = '/login';

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => const LoginPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //     title: const Text(
      //   'Login',
      //   style: TextStyle(color: Colors.black),
      // )),
      body: BlocProvider(
        create: (_) => LoginCubit(context.read<AuthRepository>()),
        child: const LoginForm(),
      ),
    );
  }
}
