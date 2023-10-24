
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../../constants.dart';
import '../forget_password/forget_password_screen.dart';
import '../root_page.dart';

class LoginScreen extends StatefulWidget{
  const LoginScreen({super.key});

  @override
  createState() => _LoginScreen();
}
class _LoginScreen extends State<LoginScreen>{

  TextEditingController passWordController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  late bool _passwordVisible;

  @override
  void initState() {
    _passwordVisible = false;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child:
          _buildBody(context)),
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
          const SizedBox(height: 10,),
          _buildUserNameTextField(),
          const SizedBox(height: 10,),
          getPasswordEdit(),
          const SizedBox(
            height: 10,
          ),
          _buildSingInButton(),
          const SizedBox(
            height: 10,
          ),
          _buildForgetPasswordText(),
          const SizedBox(height: 10,),
          const Row(
            children: [
              Expanded(child: Divider()),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Text('OR'),
              ),
              Expanded(child: Divider()),
            ],
          ),
          const SizedBox(height: 20,),
          _buildGoogleButton()
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
      keyboardType: TextInputType.emailAddress,
      style: TextStyle(
          color: Constants.blackColor
      ),

      decoration: InputDecoration(
        hintText: "Enter email",
        fillColor: Colors.white,
        filled: true,
        focusedBorder:OutlineInputBorder(
          borderRadius:BorderRadius.circular(5.0),
          borderSide:  BorderSide(
            color: Constants.primaryColor,
            width: 2.0,
          )
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide: BorderSide(
            color: Constants.primaryColor.withOpacity(.8),
          )
        ),
      ),
      cursorColor: Constants.blackColor.withOpacity(.5),
    );
  }
  Widget getPasswordEdit(){
    return   TextFormField(
      keyboardType: TextInputType.text,
      controller: passWordController,
      obscureText: !_passwordVisible,
      decoration: InputDecoration(
        hintText: 'Password',
        fillColor: Colors.white,
        filled: true,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide:  BorderSide(
            color: Constants.primaryColor,
            width: 2.0,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide: BorderSide(
            color: Constants.primaryColor.withOpacity(.8),
          ),
        ),
        // prefix: Icon(Icons.lock,color: Constants.primaryColor,),
        suffixIcon: IconButton(
          icon: Icon(
            // Based on passwordVisible state choose the icon
            _passwordVisible
                ? Icons.visibility
                : Icons.visibility_off,
            color: Constants.primaryColor,
            // color: Theme.of(context).primaryColor,
          ),
          onPressed: () {
            // Update the state i.e. toogle the state of passwordVisible variable
            setState(() {
              _passwordVisible = !_passwordVisible;
            });
          },
        ),
      ),
    );
  }
  Widget _buildSingInButton(){
    Size size  = MediaQuery.of(context).size;
    return   GestureDetector(
      onTap: () {
        Navigator.pushReplacement(
            context,
            PageTransition(
                child: const RootPage(),
                type: PageTransitionType.bottomToTop));
      },

      child: Container(
        width: size.width,
        decoration: BoxDecoration(
          color: Constants.primaryColor,
          borderRadius: BorderRadius.circular(10),
        ),
        padding:
        const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: const Center(
          child: Text(
            'Sign In',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.0,
            ),
          ),
        ),
      ),
    );
  }
  Widget _buildForgetPasswordText(){
    return    GestureDetector(
      onTap: () {
        Navigator.pushReplacement(
            context,
            PageTransition(
                child: const ForgetPasswordScreen(),
                type: PageTransitionType.bottomToTop));
      },
      child: Center(
        child: Text.rich(
          TextSpan(children: [
            TextSpan(
              text: 'Forgot Password? ',
              style: TextStyle(
                color: Constants.blackColor,
              ),
            ),
            TextSpan(
              text: 'Reset Here',
              style: TextStyle(
                color: Constants.primaryColor,
              ),
            ),
          ]),
        ),
      ),
    );
  }
  Widget _buildGoogleButton(){
    Size size  = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      decoration: BoxDecoration(
          border: Border.all(color: Constants.primaryColor),
          borderRadius: BorderRadius.circular(10)),
      padding:
      const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(
            height: 30,
            child: Image.asset('assets/images/google.png'),
          ),
          Text(
            'Sign In with Google',
            style: TextStyle(
              color: Constants.blackColor,
              fontSize: 18.0,
            ),
          ),
        ],
      ),
    );
  }

}