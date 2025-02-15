import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Image.asset("assets/logo.jpeg"),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            context.go("/home");
          },
          child: Icon(Icons.arrow_circle_right),
        ),
      ),
    );
  }
}
