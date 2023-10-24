

import 'package:flutter/material.dart';
import 'package:plant_ui/constants.dart';
import 'package:plant_ui/model/plants.dart';
import 'package:plant_ui/presentation/pages/detail/image_pages.dart';

import '../../../model/detail.dart';
import 'detail_page.dart';

class Test extends StatefulWidget{

  const Test({super.key});

  @override
  createState() => _Test();
}

class _Test extends State<Test>{
  late Plant plant;
  final PageController _pageController = PageController();
  double currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    plant = ModalRoute.of(context)!.settings.arguments as Plant;
    return Scaffold(
      body: _buildScreen(),
    );
  }

  @override
  void initState() {

    _pageController.addListener((){
      setState(() {
        currentIndex = _pageController.page!;
      });
    });
    super.initState();
  }
  Widget _buildScreen(){
    return Column(
      children: [
        _buildHeader(),
        const SizedBox(height: 20,),
        _buildCenter(),
        const SizedBox(height: 5,),
        Container(
          margin: const EdgeInsets.only(left: 20),
          child: Row(
            children:_buildIndicator(),
          ),
        ),
        const SizedBox(height: 10,),
        _buildBottom(),
      ],
    );
  }

  Widget _buildHeader(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildIconClose(Icons.close),
        _buildIconFavorite(Icons.favorite)
      ],
    );
  }
  Widget _buildCenter(){
    return AspectRatio(
      aspectRatio: 10/8,
      child: Row(
        children: [
          Expanded(
              flex: 2,
            child: _buildImagePager(),
          ),
          Expanded(
            child: _buildInfomation(),
          ),
        ],
      ),
    );
  }
  Widget _buildBottom(){
    return  Expanded(
      child: Container(
        padding: const EdgeInsets.only(left: 20,top: 30 ,right: 20),
      decoration: BoxDecoration(
        color: Constants.primaryColor.withOpacity(.5),
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(30),
          topLeft: Radius.circular(30)
        )
      ),
        child:  Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
         children: [
           Text(plant.commonName ,
           style: TextStyle(
             color: Constants.primaryColor.withOpacity(.9),
             fontWeight: FontWeight.bold,
             fontSize: 24
           ),),
           Row(
             mainAxisAlignment: MainAxisAlignment.spaceBetween,
             children: [
               Text(r'$'+ products[plant.id].price.toString(),
               style: const TextStyle(
                   color: Colors.black54,
                   fontSize: 22,
                   fontWeight: FontWeight.bold
               ),
               ),
               const SizedBox(height: 10,),
               Row(
                 children: [
                   Text(products[plant.id].rating.toString(),
                     style: TextStyle(
                         color: Constants.primaryColor,
                         fontSize: 22,
                         fontWeight: FontWeight.bold
                     ),),
                   Icon(Icons.star,color: Constants.primaryColor,)
                 ],
               ),
             ],
           ),
           const SizedBox(height: 20,),
           Expanded(
               child:Text(products[plant.id].description,
               textAlign: TextAlign.justify,
               style: TextStyle(
                 height: 1.5,
                 fontSize: 18,
                 color: Constants.blackColor.withOpacity(.7)
               ),
               )
           ),
         ], 
        ),
      ),
    );
  }
  Widget _buildImagePager(){
    return PageView(
      onPageChanged: (int page){
        setState(() {
          currentIndex = page as double;
        });
      },
      controller: _pageController,
      children: [
        ImagePages(image: plant.defaultImage.originalUrl),
        ImagePages(image: plant.defaultImage.regularUrl),
      ],
    );
  }
  Widget _buildInfomation(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PlantFeature(title: "Scientific Name",feature:plant.scientificName.first),
        const SizedBox(height: 10,),
        PlantFeature(title: "Watering ",feature: plant.watering),
        const SizedBox(height: 10,),
        PlantFeature(title: "Temperature ",feature: plant.sunlight.first),
      ],
    );
  }
  Widget _buildIconClose(IconData icon){

    return GestureDetector(
      onTap: (){
        Navigator.pop(context);
      },
      child: Container(
        height:40,
        width: 40,
        margin: const EdgeInsets.only(top: 40, left: 20, right: 20),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: Constants.primaryColor.withOpacity(.15)
        ),
        child:
        IconButton(onPressed: (){},
            icon: Icon(icon, color: Constants.primaryColor,)
        ),
      ),
    );
  }
  Widget _buildIconFavorite(IconData icon){

    return GestureDetector(
      onTap: (){
      },
      child: Container(
        height:40,
        width: 40,
        margin: const EdgeInsets.only(top: 40, left: 20, right: 20),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: Constants.primaryColor.withOpacity(.15)
        ),
        child:
        IconButton(onPressed: (){},
            icon: Icon(icon, color: Constants.primaryColor,)
        ),
      ),
    );
  }
  Widget _indicator(bool isActive) {
    return AnimatedContainer(duration: const Duration(milliseconds: 200),
      height: 10.0,
      width: isActive ? 20 : 8,
      margin: const EdgeInsets.only(right: 5.0),
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }
  List<Widget> _buildIndicator(){
    List<Widget> indicators = [];
    for(int i= 0; i<2; i++){
      if(currentIndex == i){
        indicators.add(_indicator(true));
      }else{
        indicators.add(_indicator(false));
      }
    }
    return indicators;
  }
  List<Product> products = [
    Product(29.99, 4.5, "High-quality product with exceptional features. "
        "Perfect for home or office use. Available in multiple colors."),
    Product(19.99, 4.2, "Affordable and durable choice for your needs. "
        "Designed for long-lasting performance. Comes with a warranty."),
    Product(49.99, 4.7, "Premium product with cutting-edge technology. "
        "Experience the future today. Unmatched performance and style."),
    Product(39.99, 4.6, "Elegant and stylish design that complements any decor. "
        "Advanced features for a superior user experience. A top choice for modern living."),
    Product(79.99, 4.9, "The ultimate product for your every need. "
        "Unparalleled quality, performance, and versatility. Make a statement with this product."),
    Product(34.99, 4.3, "A reliable choice for everyday use. "
        "Sleek and functional design for practicality and convenience. A trusted product for any home."),
    Product(15.99, 4.0, "Budget-friendly option that doesn't compromise on quality. "
        "Ideal for tight budgets and cost-conscious consumers."),
    Product(64.99, 4.5, "Versatile product designed for a wide range of applications. "
        "Engineered for efficiency and adaptability. A must-have for professionals."),
    Product(22.99, 4.1, "Stylish and innovative product for trendsetters. "
        "Offers both form and function, combining aesthetics and performance."),
    Product(99.99, 4.8, "The pinnacle of product excellence. "
        "Loaded with advanced features, unmatched in quality and performance."),
    Product(18.99, 3.6, "An affordable and reliable choice for daily use. "
        "Built to last and meets all your basic needs."),
    Product(45.99, 4.4, "A product that seamlessly integrates into your lifestyle. "
        "Highly adaptable and user-friendly for both beginners and experts."),
    Product(54.99, 4.3, "A premium product crafted with precision and elegance. "
        "A symbol of sophistication and unmatched quality."),
    Product(27.99, 3.9, "An ideal solution for those seeking a balance between quality and price. "
        "Well-suited for a variety of applications."),
    Product(37.99, 4.2, "An exceptional product for those who value performance and aesthetics. "
        "Balances functionality with an eye-catching design."),
    Product(16.99, 3.7, "A versatile product that adapts to your ever-changing needs. "
        "Simplify your life with this multi-purpose solution."),
    Product(58.99, 4.6, "A cutting-edge product that redefines industry standards. "
        "A remarkable combination of style, power, and durability."),
    Product(23.99, 3.8, "A dependable product that you can rely on day in and day out. "
        "Perfect for those who value consistency."),
    Product(31.99, 4.1, "A product that strikes the perfect balance between performance and affordability. "
        "Ideal for a wide range of applications."),
    Product(88.99, 4.7, "The epitome of luxury and innovation. "
        "Indulge in an exquisite experience with this high-end product."),
    Product(12.99, 3.3, "An entry-level product that offers great value for the price. "
        "A budget-friendly choice for beginners."),
  ];
}