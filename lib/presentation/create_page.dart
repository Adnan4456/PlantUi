
import 'package:flutter/material.dart';
import 'package:plant_ui/constants.dart';


class CreatePage extends StatelessWidget{

  final String image;
  final String title;
  final String description;

  const CreatePage({
    super.key  , required this.image ,required this.title ,required this.description
  });

  @override
  Widget build(BuildContext context) {
    return   Container(
      padding: const EdgeInsets.only(left: 50 , right: 50 , bottom :80),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 350,child: Image.asset(image),
          ),
          const SizedBox(height: 20,),
          Text(title,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Constants.primaryColor,
                fontSize: 30,
                fontWeight: FontWeight.bold
            ),
          ),
          const SizedBox(height: 20,),
          Text(description,
            textAlign: TextAlign.center,
            style: const TextStyle(
                color: Colors.grey,
                fontSize: 20,
                fontWeight: FontWeight.w400
            ),
          ),
          const SizedBox(height: 20,),

        ],
      ),
    );
  }
}