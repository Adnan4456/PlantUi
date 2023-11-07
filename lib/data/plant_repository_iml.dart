

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
  @override
  Future<List<Plant>> getPlants() async {
    var response = await _networkClient.get();
    print(response.body);
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body); //  you have your JSON as a string
      final plantResponse = Plants.fromJson(jsonResponse);
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