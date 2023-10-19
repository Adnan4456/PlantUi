

import 'package:flutter/material.dart';

class FavoritePage extends StatefulWidget{

  const FavoritePage({super.key});

  @override
  createState() => _FavoritePage();

}
class _FavoritePage extends State<FavoritePage>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("Favorite ")),
      ),
    );
  }

}