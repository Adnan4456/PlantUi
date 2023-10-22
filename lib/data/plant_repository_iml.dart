

import 'dart:convert';
import 'dart:math';

import 'package:plant_ui/domain/plant_repository.dart';
import '../model/plants.dart';
import 'network/network_client.dart';

class PlantRepositoryImpl  extends PlantRepository{

  final NetworkClient _networkClient;

  PlantRepositoryImpl(this._networkClient);

  @override
  Future<Plants> getDetails(int id) {
    // TODO: implement getDetails
    throw UnimplementedError();
  }
  List<Plants> parsePlantsList(String json) {
    final parsed = jsonDecode(json);
    return List<Plants>.from(parsed['data'].map((plant) => Plants.fromJson(plant)));
  }


  @override
  Future<List<Plant>> getPlants() async {
    var response = await _networkClient.get();
    print(response.body);
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body); // Assuming you have your JSON as a string
      final plantResponse = Plants.fromJson(jsonResponse);
      // List<Plant> plants = plantResponse.data;
      // print(plants);
      return plantResponse.data;
    }else {
      throw Exception("Failed to load personas");
    }
  }

   int randomNumber(){
    Random random = Random();
    return  10 + random.nextInt(50 -  10 + 1);

  }
}