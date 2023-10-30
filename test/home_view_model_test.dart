

import 'package:estado/state/observer.dart';
import 'package:estado/state/utils/loading_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:plant_ui/domain/plant_repository.dart';
import 'package:plant_ui/model/plants.dart';
import 'package:plant_ui/presentation/pages/home/view_model.dart';

import 'home_view_model_test.mocks.dart';

@GenerateMocks([PlantRepository , StateObserver])
void main(){

  late PlantRepository repo;
  late PlantViewModel subject;
  late List<Plant> plantList;
  late StateObserver observer;

  setUp(() {
    repo =  MockPlantRepository();
    subject = PlantViewModel(repo);
    observer = MockStateObserver();
    plantList = [];
  });

  test("plant list ", () async{
    when(repo.getPlants())
        .thenAnswer((_) async {
          return plantList;
    });

    subject.subscribe(observer);
    await subject.loadPlants();
    subject.unsubscribe(observer);
    
    verify(repo.getPlants()).called(1);
    expect(plantList.length, 0);
  });

  test("Check we are getting correct data from repository", () async {

    when(repo.getPlants())
        .thenAnswer((_) async {
      return plantList;
    });

    subject.subscribe(observer);
    await subject.loadPlants();
    subject.unsubscribe(observer);

    verify(repo.getPlants()).called(1);
    expect(plantList.length, 0);

    verifyInOrder([
      observer.notify(LoadingState(true)),
      observer.notify(LoadingState(false)),
      observer.notify(PlantListstate(plantList))
    ]);
  });
}