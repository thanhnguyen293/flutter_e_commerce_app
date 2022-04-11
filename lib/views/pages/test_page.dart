import 'package:flutter/material.dart';

class TestPage extends StatelessWidget {
  static const String routeName = '/test-screen';

  const TestPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('testScreen')),
    );
  }
}
