
import '../model/plants.dart';

abstract class PlantRepository{

  Future<List<Plant>> getPlants();

  Future<Plant> getDetails(int id);
}