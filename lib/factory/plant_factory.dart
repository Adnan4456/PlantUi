

import 'package:plant_ui/data/plant_repository_iml.dart';
import 'package:plant_ui/domain/plant_repository.dart';
import 'package:plant_ui/factory/network_factory.dart';

class PlantFactory{

  PlantFactory._privateConstructor();

  static final PlantFactory _instance = PlantFactory._privateConstructor();

  factory PlantFactory(){
    return _instance;
  }

  PlantRepository? _plantRepository;

  PlantRepository getRepository(){
    _plantRepository ??=
        PlantRepositoryImpl(NetworkFactory.getInstance().getNetworkClient());
    return _plantRepository!;
  }
}