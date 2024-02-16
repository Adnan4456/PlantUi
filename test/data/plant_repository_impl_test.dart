



import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:plant_ui/app_exception.dart';
import 'package:plant_ui/constants.dart';
import 'package:plant_ui/data/network/network_client.dart';
import 'package:plant_ui/data/plant_repository_iml.dart';

import 'plant_repository_impl_test.mocks.dart';

@GenerateMocks([NetworkClient])
void main(){

  late NetworkClient network;
   late PlantRepositoryImpl repo;

  setUpAll(() {
    network = MockNetworkClient();
    repo = PlantRepositoryImpl(network);

  });


  test("throw exception ", () async {

    when(network.getGetApiResponse(Constants.url))
        .thenThrow( FetchDataException());

    expect(() async {
      await repo.getPlants();
    }, throwsA(isA<FetchDataException>()));

  });

}