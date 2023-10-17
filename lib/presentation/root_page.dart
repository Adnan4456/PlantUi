

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:plant_ui/constants.dart';
import 'package:plant_ui/presentation/login_screen.dart';
import 'package:plant_ui/presentation/pages/cart_page.dart';
import 'package:plant_ui/presentation/pages/favorite_page.dart';
import 'package:plant_ui/presentation/pages/home_page.dart';
import 'package:plant_ui/presentation/pages/profile_page.dart';

class RootPage extends StatefulWidget{

  RootPage({super.key});

  @override
   createState()=> _RootPage();
}

class _RootPage extends State<RootPage>{

  int _bottomNavIndex = 0;

  //list of pages
  List<Widget> pages = const [
    HomePage(),
    FavoritePage(),
    CartPage(),
    ProfilePage(),
  ];

  //list of pages icons
  List<IconData> iconList = const [
    Icons.home,
    Icons.favorite,
    Icons.shopping_cart,
    Icons.person
  ];

  //list of pages titles
  List<String> titleList = const [
    "Home",
    "Favorite",
    "Cart",
    "Profile",
  ];


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar:_buildAppBar(),
      body: _buildBody(),
      floatingActionButton: _actionButton(),
    );
  }

  AppBar _buildAppBar(){
    return AppBar(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(titleList[_bottomNavIndex],
            style: TextStyle(
              color: Constants.blackColor,
              fontWeight: FontWeight.w500,
              fontSize: 24,
            ),
          ),
          Icon(Icons.notifications, color: Constants.blackColor,size: 30.0,),
        ],
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      elevation: 0.0,
    );
  }

  IndexedStack _buildBody(){
    return IndexedStack(
      index: _bottomNavIndex,
      children: pages
    );
  }

  FloatingActionButton _actionButton(){
    return FloatingActionButton(
      onPressed: () {
      Navigator.push(context, PageTransition(child: const LoginScreen() , type: PageTransitionType.bottomToTop));
      },
      child: Image.asset("assets/images/code-scan.png" , height: 30.0,),
    );
  }
}