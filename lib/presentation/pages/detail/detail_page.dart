

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:plant_ui/constants.dart';
import 'package:plant_ui/model/plants.dart';
import 'package:plant_ui/routes.dart';

class DetailPage extends StatefulWidget{

  const DetailPage({super.key});

  @override
  createState() => _DetailPage();

}
class _DetailPage extends State<DetailPage>{
  late  DetailPageArguments args;
  Plant? plant;

  @override
  Widget build(BuildContext context) {
    args  = ModalRoute.of(context)?.settings.arguments as DetailPageArguments;
    plant = args.plant;

    Size size =  MediaQuery.of(context).size;
    return Scaffold(
     body: Stack(
       children: [
         Positioned(
           top: 50,
             left: 20,
             right: 20,
             child:Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [
                 GestureDetector(
                   onTap: (){
                     Navigator.pop(context);
                   },
                   child: Container(
                     height: 40,
                     width: 40,
                     decoration: BoxDecoration(
                       borderRadius: BorderRadius.circular(25),
                       color: Constants.primaryColor.withOpacity(.15)
                     ),
                     child: Icon(Icons.close,color: Constants.primaryColor,),
                   ),
                 ),
                 GestureDetector(
                   onTap: (){
                     // Navigator.pop(context);
                     debugPrint("favorite");
                   },
                   child: Container(
                     height: 40,
                     width: 40,
                     decoration: BoxDecoration(
                         borderRadius: BorderRadius.circular(25),
                         color: Constants.primaryColor.withOpacity(.15)
                     ),
                     child: Icon(Icons.favorite,color: Constants.primaryColor,),
                   ),
                 )
               ],
             )
         ),
         Positioned(
             top: 100,
             left: 20,
             right: 20,
             child: Container(
               width: size.width * .8,
               height: size.height * .8,
               padding: const EdgeInsets.all(20),
               child: Stack(
                 children: [
                   Positioned(
                       top: 10,
                       left: 0,
                       child: SizedBox(
                        height: 350,
                         child: Image.asset("assets/images/plant-one.png"),
                       )
                   ),
                   Positioned(
                       top: 10,
                       right: 0,
                       child: SizedBox(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            PlantFeature(title: "Size ",feature: "Small"),
                            PlantFeature(title: "Humidity ",feature: "Normal"),
                            PlantFeature(title: "Temperature ",feature: "12-16"),

                          ],
                        ),
                       )
                   ),
                 ],
               ),
             )
         ),
         Positioned(
             bottom: 0,
             left: 0,
             right: 0,
             child:Container(
               padding: const EdgeInsets.only(top: 80 , left: 30 , right: 30),
               height: size.height * .5,
               width: size.width,
               decoration: BoxDecoration(
                 color: Constants.primaryColor.withOpacity(.4),
                 borderRadius: const BorderRadius.only(
                   topLeft: Radius.circular(30),
                   topRight: Radius.circular(30)
                 )
               ),
               child:Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     crossAxisAlignment: CrossAxisAlignment.center,
                     children: [
                       Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                           Text("Data of plant",
                           style: TextStyle(
                             color: Constants.primaryColor,
                             fontWeight: FontWeight.bold,
                             fontSize: 30.0
                           ),),
                            SizedBox(
                             height: 10,
                             child: Text(r'$' + "plant data will come here ",
                               style: TextStyle(
                                 color: Constants.blackColor,
                                 fontSize: 24,
                                 fontWeight: FontWeight.bold
                               ),
                             ),
                           )
                         ],

                       )
                     ],
                   )
                 ],
               ) ,
             )
         )
       ],
     ),
    );
  }
}

class PlantFeature extends StatelessWidget {

  final String  feature;
  final String title;

   const PlantFeature({
    Key?  key, required this.feature, required this.title
  }) : super (key:key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
        style: TextStyle(
          color: Constants.blackColor,

        ),
        ),
        Text(feature,
        style: TextStyle(
          color: Constants.primaryColor,
          fontSize: 18.0,
          fontWeight: FontWeight.bold
        ),),
      ],
    );
  }
}