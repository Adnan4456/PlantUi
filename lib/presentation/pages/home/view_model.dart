

import 'package:estado/state/state.dart';
import 'package:estado/state/viewmodel.dart';
import 'package:estado/state/utils/LoadingState.dart';

import 'package:plant_ui/domain/plant_repository.dart';
import 'package:plant_ui/model/plants.dart';

class PlantViewModel extends ViewModel {

  final PlantRepository _repository;

  PlantViewModel(this._repository);

  void loadPlants() async{
    notify(LoadingState(true));
    var result = await _repository.getPlants();
    notify(LoadingState(false));
    notify(PlantListstate(result));
  }
}

class PlantListstate extends ViewState{
  static const String tag = "PlantListState";
  List<Plant> plantsList;
  PlantListstate(this.plantsList):super(tag);
}