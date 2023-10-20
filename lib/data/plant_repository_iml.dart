

import 'dart:convert';

import 'package:plant_ui/domain/plant_repository.dart';
import 'package:plant_ui/model/plants.dart';

import 'network/network_client.dart';

class PlantRepositoryImpl  extends PlantRepository{

  final NetworkClient _networkClient;

  PlantRepositoryImpl(this._networkClient);

  @override
  Future<Plant> getDetails(int id) {
    // TODO: implement getDetails
    throw UnimplementedError();
  }

  @override
  Future<List<Plant>> getPlants() async {
    var response = await _networkClient.get();
    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);

      print(jsonData);
      if (jsonData is List) {
        // return jsonData.map<Plant>((json) => Plant.fromJson(json)).toList();
        return jsonData.map<Plant>((json) => Plant.fromJson(json)).toList();
      } else {
        throw Exception("Response data is not in the expected format (List).");
      }
    } else {
      throw Exception("Failed to load personas");
    }
  }
  // @override
  // Future<List<Plant>> getPlants() async {
  //   var response = await _networkClient.get();
  //   if (response.statusCode == 200) {
  //     var jsonData = jsonDecode(response.body);
  //     return jsonData.map<Plant>((json){
  //       var p = Plant.fromJson(json);
  //       return p;
  //     }).toList();
  //   }else {
  //     throw Exception("Failed to load personas");
  //   }
  // }

}