
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeScreen extends StatefulWidget{

  const HomeScreen({super.key});

  @override
   createState() => _HomeScreen();
}
class _HomeScreen extends State<HomeScreen>{

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: _buildAppBar(),
    );
  }

  AppBar _buildAppBar(){
    return AppBar(
      elevation: 0,
      leading: IconButton(
        icon: SvgPicture.asset("assets/icons/menu.svg"),
        onPressed: (){},),
    );
  }
}