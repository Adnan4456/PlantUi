
import 'package:plant_ui/domain/plant_repository.dart';
import '../constants.dart';
import '../model/plants.dart';
import 'network/network_client.dart';

class PlantRepositoryImpl  extends PlantRepository{

  final NetworkClient _networkClient;

  PlantRepositoryImpl(this._networkClient);

  @override
  Future<Plants> getDetails(int id) {
    throw UnimplementedError();
  }

  @override
  Future<List<Plant>> getPlants() async {
    var response = await _networkClient.getGetApiResponse(Constants.url);
    final plantResponse = Plants.fromJson(response);
    return plantResponse.data;
  }
}