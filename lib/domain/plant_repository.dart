
import '../model/plants.dart';

abstract class PlantRepository{

  Future<List<Plant>> getPlants();

  Future<Plants> getDetails(int id);
}