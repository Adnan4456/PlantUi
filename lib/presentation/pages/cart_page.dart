

import 'package:flutter/material.dart';

class CartPage extends StatefulWidget{

  const CartPage({super.key});

  @override
  createState() => _CartPage();
}
class _CartPage extends State<CartPage>{
  @override
  Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: const Text("Cart "),
    ),
  );
  }

}