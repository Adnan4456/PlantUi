


import 'model/plants.dart';

class NavigationRoutes {
  static const String home = '/home';
  static const String detail = '/detail';
}


class DetailPageArguments{

  Plant plant;
  DetailPageArguments(this.plant);
}