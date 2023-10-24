
import 'package:flutter/material.dart';
import 'package:plant_ui/constants.dart';

class SignUpScreen extends StatefulWidget{

  const SignUpScreen({super.key});

  @override
  createState() => _SignUpScreen();

}
class _SignUpScreen extends State<SignUpScreen>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal:20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildImage(context),
          _buildText(),
          const SizedBox(height: 30,),
          _buildUserNameTextField(),
          const SizedBox(height: 10,),
          _buildPasswordTextField()
        ],
      ),
    );
  }
  
  Widget _buildImage(BuildContext context) {
    return Image.asset("assets/images/signin.png");
  }
  Widget _buildText(){
    return const Text("Sing In",
    style: TextStyle(
      fontSize: 30.0,
      fontWeight: FontWeight.w700
    ),
    );
  }
  Widget _buildUserNameTextField(){
    return TextField(
      style: TextStyle(
        color: Constants.blackColor
      ),
      decoration: InputDecoration(
        border: InputBorder.none,
        prefix: Icon(Icons.person ,
        color: Constants.blackColor.withOpacity(.3),
        ),
        hintText: "Enter Username",
      ),
      cursorColor: Constants.blackColor.withOpacity(.5),
    );
  }
  Widget _buildPasswordTextField(){
    return TextField(
      style: TextStyle(
          color: Constants.blackColor
      ),
      decoration: InputDecoration(
        border: InputBorder.none,
        prefix: Icon(Icons.person ,
          color: Constants.blackColor.withOpacity(.3),
        ),
        hintText: "Enter Password",
      ),
      cursorColor: Constants.blackColor.withOpacity(.5),

    );
  }
}