
import 'package:flutter/material.dart';
import 'package:plant_ui/constants.dart';
import 'package:plant_ui/presentation/create_page.dart';
import 'package:plant_ui/presentation/root_page.dart';

class OnBoardingScreen extends StatefulWidget{

  const OnBoardingScreen({super.key});

  @override
  createState() => _OnBoardingScreen();

}
class _OnBoardingScreen extends State<OnBoardingScreen>{

  final PageController _pageController = PageController();
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppbar(),
      body: _buildBody(),
    );
  }

  AppBar _buildAppbar(){
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      actions:  [
        Padding(
          padding: const EdgeInsets.only(right: 20, top: 20),
          child: InkWell(
            onTap: (){
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=> const RootPage()));
            },
            child:  const Text("Skip",
              key: Key("Skip"),
              style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16.0,
                  fontWeight: FontWeight.w400
              ),
            ),
          ),
        )
      ],
    );
  }
  Widget _buildBody(){
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        PageView(
          onPageChanged: (int page){
            setState(() {
              currentIndex = page;
            });
          },
          controller: _pageController,

          children: [
            CreatePage(image: "assets/images/plant-one.png",
                title: Constants.titleOne,
                description: Constants.descriptionOne),
            CreatePage(image: "assets/images/plant-two.png",
                title: Constants.titleTwo,
                description: Constants.descriptionTwo),
            CreatePage(image: "assets/images/plant-three.png",
                title: Constants.titleThree,
                description: Constants.descriptionThree)
          ],
        ),
        Positioned(
            bottom: 80,
            left: 30,
            child: Row(
              children:
              _buildIndicator(),
            )
        ),
        Positioned(
            bottom: 40,
            right: 20,
            child: Container(
              padding:const EdgeInsets.all(4),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Constants.primaryColor,
              ),
              child: IconButton(
                key: const Key("Next"),
                      onPressed: () {
                        setState(() {
                          if(currentIndex < 2){
                            currentIndex ++;
                            if(currentIndex < 3){
                              _pageController.nextPage(
                                  duration: const Duration(milliseconds: 200),
                                  curve: Curves.easeIn);
                            }
                          }else
                          {
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=> const RootPage()));
                          }
                        });
                      },
                      icon: const Icon(
                        Icons.arrow_forward_ios,
                        size : 24,
                        color: Colors.white,)
              ),
            )
        )
      ],
    );
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(duration: const Duration(milliseconds: 300),
      height: 10.0,
      width: isActive ? 20 : 8,
      margin: const EdgeInsets.only(right: 5.0),
      decoration: BoxDecoration(
        color: Constants.primaryColor,
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }
  List<Widget> _buildIndicator(){
    List<Widget> indicators = [];
    for(int i= 0; i<3; i++){
      if(currentIndex == i){
        indicators.add(_indicator(true));
      }else{
        indicators.add(_indicator(false));
      }
    }
    return indicators;
  }
}
