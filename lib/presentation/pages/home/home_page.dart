

import 'package:cached_network_image/cached_network_image.dart';
import 'package:estado/state/observer.dart';
import 'package:estado/state/state.dart';

import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:plant_ui/constants.dart';

import 'package:plant_ui/model/plants.dart';
import 'package:plant_ui/presentation/pages/detail/detail_page.dart';
import 'package:plant_ui/presentation/pages/home/view_model.dart';

import '../../../model/detail.dart';

class HomePage extends StatefulWidget{

  const HomePage({super.key , required this.viewModel});

  final PlantViewModel viewModel;

  @override
  createState()=> _HomePage(viewModel : viewModel);
}
class _HomePage extends State<HomePage>
    implements EventObserver {

   final PlantViewModel viewModel;
  _HomePage({required this.viewModel});

  bool _isLoading = true;
  final ScrollController _controller = ScrollController();
  bool closeTopContainer = false;

  List<Plant> plantList = [];
  List<Plant> filterList = [];

  int selectedIndex = 0;

  //Plants category
  List<String> plantTypes = [
    'Recommended',
    'Indoor',
    'Outdoor',
    'Garden',
    'Supplement',
  ];

  @override
  void initState() {
    super.initState();

     viewModel.subscribe(this);
     viewModel.loadPlants();
    _controller.addListener(() {
      setState(() {
        closeTopContainer = _controller.offset > 50;
      });
    });
  }

  @override
  void deactivate() {
    super.deactivate();
     viewModel.unsubscribe(this);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment : CrossAxisAlignment.start,
          children: [
             _buildHeader(size),
            const SizedBox(height: 10,),
            _buildCenterList(size),

            AnimatedOpacity(
              duration: const Duration(seconds: 100),
              opacity: closeTopContainer ? 0.0 : 1.0,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 1000),
                alignment: Alignment.center,
                height: closeTopContainer? 0 : size.height * .30,
                child: SizedBox(
                  child: ListView.builder(
                    itemCount: filterList.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder:(BuildContext context , int index){
                      return GestureDetector(
                        onTap: (){
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder:(context) => const DetailPage(),
                                  settings: RouteSettings(
                                  arguments: filterList[index]
                                )
                              )
                          );
                        },
                        child: Container(
                          width: 180,
                          margin:const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: const BorderRadius.all(Radius.circular(20)),
                              boxShadow: [
                                BoxShadow(
                                  color: Constants.primaryColor,
                                  blurRadius: 5.0,
                                )
                              ],
                          ),
                          child: Stack(
                            children: [
                              Positioned(
                                left: 0,
                                  right: 0,
                                  top: 0,
                                  bottom: 40,
                                  child:
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8.0),
                                    child: CachedNetworkImage(
                                      key: UniqueKey(),
                                      imageUrl: filterList[index].defaultImage.originalUrl,
                                      width: double.infinity,
                                      cacheManager: DefaultCacheManager(),
                                      fit: BoxFit.cover,
                                      placeholder: (context, url) => const SizedBox(
                                        height: 30,
                                        width: 30,
                                        child: Center(
                                          child: CircularProgressIndicator(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      errorWidget: (context, url , error)=> Container(
                                        color: Colors.black12,
                                        child: const Icon(Icons.error, color: Color(0xff296e48)),
                                      ),
                                    ),
                                  ),
                              ),
                              Positioned(
                                  top: 5,
                                  right: 5,
                                  child: Container(
                                    height: 50,
                                    width: 50,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    child: IconButton(
                                      onPressed: (){
                                        setState(() {
                                          // bool isFavorited = toggleIsFavorated(plantList[index].isFavorated);
                                          // plantList[index].isFavorated = isFavorited;
                                        });
                                      },
                                      icon:  Icon(Icons.favorite_border , color: Constants.primaryColor,),
                                      iconSize: 30,
                                    ),
                                  )
                              ),
                              Positioned(
                                  left: 20,
                                  bottom: 10,
                                  right: 70,
                                  child:Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(filterList[index].commonName,
                                        // textAlign: TextAlign.justify,
                                        style: TextStyle(
                                          color: Constants.primaryColor,
                                          fontSize: 14,
                                          fontWeight: FontWeight.normal
                                        ),
                                      ),
                                    ],
                                  )
                              ),
                              Positioned(
                                  bottom: 5,
                                  right: 10,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 10 , vertical: 2),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Text(r'$'+ products[index].price.toString(),
                                    style: TextStyle(
                                      color: Constants.primaryColor,
                                      fontSize: 16
                                    ),
                                    ),
                                  ),
                              ),
                            ],
                          ),
                        ),
                      );
                      }
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10,),
            _buildNewPantText(),
            _buildNewPlantList(size)
          ],
        ),
      ),
    );
  }
  Widget _buildHeader(Size size){

    return Container(
      padding: const EdgeInsets.only(top: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _isLoading == true ?
          CircularProgressIndicator(
            color: Constants.primaryColor,
          ):
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            width: size.width * .9,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                      color: Constants.primaryColor,
                      blurRadius: 8.0
                  ),
                ]
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.search , color: Colors.grey,
                ),
                Expanded(
                    child: TextField(
                      onChanged: (query){
                        _searchPlant(query);
                      },
                      showCursor: false,
                      cursorColor: Constants.primaryColor,
                      decoration: const InputDecoration(
                          hintText: "Search Plant",
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none
                      ),
                    )
                ),
                const Icon(
                  Icons.mic ,
                  color:  Colors.grey,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  Widget _buildCenterList(Size size){
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      height: 50.0,
      width: size.width,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: plantTypes.length,
          itemBuilder: (BuildContext context , int index){
            return Padding(padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: (){
                  setState(() {
                    selectedIndex = index;
                    // print(plantTypes[index]);
                  });
                },
                child:
                Container(
                  padding: const EdgeInsets.all(5.0),
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: Constants.primaryColor
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    plantTypes[index],
                    style:TextStyle(
                        fontSize: 16.0,
                        fontWeight: selectedIndex == index ? FontWeight.bold: FontWeight.w300,
                        color: selectedIndex == index ? Constants.primaryColor : Constants.blackColor
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }
  Widget _buildNewPantText(){
    return Container(
      padding: const EdgeInsets.only(left: 16 , bottom: 10 , top: 10),
      child: const Text("New Plants" ,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18.0,
        ),
      ),
    );
  }

  Widget _buildNewPlantList(Size size){
    return Expanded(
        child: ListView.builder(
            controller: _controller,
            itemCount: plantList.length,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (BuildContext context , int index){
              return GestureDetector(
                onTap: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder:(context) => const DetailPage(),
                          settings: RouteSettings(
                              arguments: filterList[index]
                          )
                      )
                  );
                },
                child: Container(
                  height: 80.0,
                  padding: const EdgeInsets.only(left: 5 , top: 5),
                  margin: const EdgeInsets.only(bottom: 5, top: 5),
                  width: size.width,
                  decoration: BoxDecoration(
                      color: Constants.primaryColor.withOpacity(.1),
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Container(
                            width: 60.0,
                            height: 60.0,
                            decoration: BoxDecoration(
                              color: Constants.primaryColor.withOpacity(.8),
                              shape: BoxShape.circle,
                            ),
                          ),
                          Positioned.fill(
                            child: SizedBox(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: CachedNetworkImage(
                                    key: UniqueKey(),
                                    imageUrl: plantList[index].defaultImage.originalUrl,
                                    cacheManager: DefaultCacheManager(),
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) =>
                                    const SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: Center(
                                        child: CircularProgressIndicator(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    errorWidget: (context, url , error)=> Container(
                                      color: Colors.black12,
                                      child: const Icon(Icons.error, color: Color(0xff296e48)),
                                    )
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 5,
                            left: 80,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(plantList[index].commonName,
                                    style: TextStyle(
                                      fontSize:16,
                                      fontWeight: FontWeight.normal,
                                      color: Constants.blackColor,
                                    )
                                ),
                                const Text(""),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.only(right: 10),
                        child: Text(r'$'+ products[index].price.toString(),
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0,
                              color: Constants.primaryColor
                          ),),
                      )
                    ],
                  ),
                ),
              );
            })
    );
  }
  void  _searchPlant(String query){
    List<Plant> result = [];
    if(query.isEmpty){
      //
      result = plantList;
    }else
    {
      result = plantList.where((plant) => plant.commonName.toLowerCase().startsWith(query)).toList();
      if(result.isEmpty){
        result = plantList.where((plant) => plant.scientificName.first.toLowerCase().startsWith(query)).toList();
      }
    }
    setState(() {
      filterList = result;
    });
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
    Product(14.99, 2.3, "An entry-level product that offers great value for the price. "
        "A budget-friendly choice for beginners."),
    Product(11.99, 23.3, "An entry-level product that offers great value for the price. "
        "A budget-friendly choice for beginners."),
    Product(2.99, 13.3, "An entry-level product that offers great value for the price. "
        "A budget-friendly choice for beginners."),
    Product(27.99, 3.6, "An ideal solution for those seeking a balance between quality and price. "
        "Well-suited for a variety of applications."),
    Product(28.99, 3.7, "An ideal solution for those seeking a balance between quality and price. "
        "Well-suited for a variety of applications."),
    Product(17.99, 3.8, "An ideal solution for those seeking a balance between quality and price. "
        "Well-suited for a variety of applications."),
    Product(37.99, 3.9, "An ideal solution for those seeking a balance between quality and price. "
        "Well-suited for a variety of applications."),
    Product(1.99, 4.5, "High-quality product with exceptional features. "
        "Perfect for home or office use. Available in multiple colors."),
    Product(19.99, 4.2, "Affordable and durable choice for your needs. "
        "Designed for long-lasting performance. Comes with a warranty."),
    Product(49.99, 4.7, "Premium product with cutting-edge technology. "
        "Experience the future today. Unmatched performance and style."),
    Product(32.99, 4.6, "Elegant and stylish design that complements any decor. "
        "Advanced features for a superior user experience. A top choice for modern living."),
    Product(79.99, 4.9, "The ultimate product for your every need. "
        "Unparalleled quality, performance, and versatility. Make a statement with this product."),
    Product(34.99, 4.3, "A reliable choice for everyday use. "
        "Sleek and functional design for practicality and convenience. A trusted product for any home."),
  ];

  @override
  void cleanUp() {

  }

  @override
  void notify(ViewEvent? event) {

    if (event is LoadingEvent) {
      setState(() {
        _isLoading = event.isLoading;
      });
    } else if (event is PlantListstate) {
      setState(() {
        plantList = event.plantsList;
        filterList = event.plantsList;
      });
    }
  }

  @override
  Map<String, Function> getHandleStateFunctions() {
    // TODO: implement getHandleStateFunctions
    throw UnimplementedError();
  }
}