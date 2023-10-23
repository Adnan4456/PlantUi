

import 'package:cached_network_image/cached_network_image.dart';
import 'package:estado/state/observer.dart';
import 'package:estado/state/utils/LoadingState.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:plant_ui/constants.dart';
import 'package:plant_ui/factory/plant_factory.dart';
import 'package:plant_ui/model/plants.dart';
import 'package:plant_ui/presentation/pages/detail/detail_page.dart';
import 'package:plant_ui/presentation/pages/home/view_model.dart';

// import '../../../model/plants.dart';
import '../../../routes.dart';

class HomePage extends StatefulWidget{

  const HomePage({super.key});

  @override
  createState()=> _HomePage();

}
class _HomePage extends State<HomePage>
    with ViewModelObserver
    implements StateObserver {

  bool _isLoading = true;

  List<Plant> plantList = [];
  List<Plant> filterList = [];

  final PlantViewModel _viewModel = PlantViewModel(
    PlantFactory().getRepository(),
  );

  @override
  void initState() {
    super.initState();
    _viewModel.subscribe(this);
    _viewModel.loadPlants();
  }

  @override
  void deactivate() {
    super.deactivate();
    _viewModel.unsubscribe(this);
  }
  @override
  Widget build(BuildContext context) {
    int selectedIndex = 0;
    Size size = MediaQuery.of(context).size;

    //Plants category
    List<String> plantTypes = [
      'Recommended',
      'Indoor',
      'Outdoor',
      'Garden',
      'Supplement',
    ];

    //Toggle Favorite button
    // bool toggleIsFavorated(bool isFavorited) {
    //   return !isFavorited;
    // }

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment : CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.only(top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _isLoading == true ?
                    const CircularProgressIndicator():
                  Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    width: size.width * .9,
                    decoration: BoxDecoration(
                      color: Constants.primaryColor.withOpacity(.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.search , color: Colors.black54.withOpacity(.6),
                        ),
                         Expanded(
                            child: TextField(
                              onChanged: (query){
                                _searchPlant(query);
                              },
                              showCursor: false,
                              decoration: const InputDecoration(
                                hintText: "Search Plant",
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none
                              ),
                            )
                        ),
                        Icon(
                          Icons.mic ,
                          color:  Colors.black54.withOpacity(.6),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
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
                          });
                        },
                        child: Text(
                          plantTypes[index],
                          style:TextStyle(
                            fontSize: 16.0,
                            fontWeight: selectedIndex == index ? FontWeight.bold: FontWeight.w300,
                            color: selectedIndex == index ? Constants.primaryColor : Constants.blackColor
                          ),
                        ),
                      ),
                    );
                  }),
            ),
            SizedBox(
              height: size.height * .3,
              child: ListView.builder(
                // itemCount: plantList.length,
                itemCount: filterList.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder:(BuildContext context , int index){
                  return GestureDetector(
                    onTap: (){
                      // Navigator.push(context,PageTransition(
                      //     child: const DetailPage(),
                      //     type: PageTransitionType.bottomToTop),
                      // );
                      print(filterList[index].scientificName);
                      Navigator.pushNamed(context, NavigationRoutes.detail,
                          arguments:DetailPageArguments(filterList[index]));
                    },
                    child: Container(
                      width: 200,
                      margin:const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        color: Constants.primaryColor.withOpacity(.8),
                        borderRadius: BorderRadius.circular(20)
                      ),
                      child: Stack(
                        children: [
                          Positioned(
                            left: 0,
                              right: 0,
                              top: 0,
                              bottom: 0,
                              child:
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: CachedNetworkImage(
                                  key: UniqueKey(),
                                  imageUrl: filterList[index].defaultImage.originalUrl,
                                  width: double.infinity,
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
                              top: 10,
                              right: 20,
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
                                  icon: const Icon(Icons.favorite),
                                  iconSize: 30,
                                ),
                              )
                          ),
                          Positioned(
                              left: 20,
                              bottom: 15,
                              child:Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(filterList[index].scientificName.first,
                                    style:const TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold
                                    ),
                                  ),

                                  // Text(plantList[index].price.toString(),
                                  //   style:const TextStyle(
                                  //     color: Colors.white70,
                                  //     fontSize: 15,
                                  //     fontWeight: FontWeight.bold
                                  //   ),
                                  // ),
                                ],
                              )
                          ),
                          Positioned(
                              bottom: 15,
                              right: 20,
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10 , vertical: 2),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(r'$'+ filterList[index].price.toString(),
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
            Container(
              padding: const EdgeInsets.only(left: 16 , bottom: 20 , top: 20),
              child: const Text("New Plants" ,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              height: size.height * .5,
              child: ListView.builder(
                itemCount: plantList.length,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (BuildContext context , int index){
                  return GestureDetector(
                    onTap: (){
                      // Navigator.push(context,PageTransition(child: const DetailPage(), type: PageTransitionType.bottomToTop));
                      print(filterList[index].scientificName);
                      Navigator.pushNamed(context, "/DetailPage",
                          arguments:DetailPageArguments(filterList[index]));
                    },
                    child: Container(
                      height: 80.0,
                      padding: const EdgeInsets.only(left: 10 , top: 10),
                      margin: const EdgeInsets.only(bottom: 10, top: 10),
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
                            child: Text(r'$'+ plantList[index].price.toString(),
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
              }),
            )
          ],
        ),
      ),
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
  @override
  Map<String, Function> getHandleStateFunctions() {
    return {
      LoadingState.name : (state){
        setState(() {
          _isLoading = state.isLoading;
        });
      },
      PlantListstate.tag: (state){
        setState(() {
          plantList  = state.plantsList;
          filterList = state.plantsList;
        });
      }
    };
  }
}