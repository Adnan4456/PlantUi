

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ImagePages extends StatelessWidget{

  final String image;

  const ImagePages({super.key , required this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 10,right: 10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: CachedNetworkImage(
          key: UniqueKey(),
          fit: BoxFit.cover,
          imageUrl: image,
          placeholder: (context , url) =>
           const SizedBox(
             height: 20,
               width: 20,
             child: Center(
               child: CircularProgressIndicator(
                 color: Colors.green,
               ),
             ),
           ),
          errorWidget: (context , url, error) =>
               Container(
                color: Colors.black12,
                child: const Icon(Icons.error, color: Color(0xff296e48)),
              )
        ),
      ),
    );
  }
}