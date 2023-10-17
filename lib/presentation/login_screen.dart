
import 'package:flutter/material.dart';
import 'package:plant_ui/constants.dart';

class LoginScreen  extends StatelessWidget{

  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
        backgroundColor: Constants.primaryColor,
      ),
    );
  }
}