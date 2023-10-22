

import 'package:plant_ui/data/network/network_client.dart';

class NetworkFactory{

  static NetworkFactory? _instance;

  NetworkFactory._internal();

  static NetworkFactory getInstance(){
    return _instance?? NetworkFactory._internal();
  }
  NetworkClient getNetworkClient(){
  return NetworkClient();
  }
}