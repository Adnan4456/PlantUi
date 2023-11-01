

import 'package:estado/state/state.dart';

import 'package:estado/state/viewmodel.dart';

import 'package:plant_ui/domain/plant_repository.dart';

import '../../../model/plants.dart';

class PlantViewModel extends EventViewModel {

  final PlantRepository _repository;

  PlantViewModel(this._repository);

  Future  loadPlants() async {
    notify(LoadingEvent(isLoading:true));
    var result = await _repository.getPlants();
    notify(LoadingEvent(isLoading:false));
    notify(PlantListstate(result));
  }
}

class LoadingEvent extends ViewEvent {

  bool isLoading;
  LoadingEvent({required this.isLoading}) : super("LoadingEvent");

}


class PlantListstate extends ViewEvent{
  static const String tag = "PlantListState";
  List<Plant> plantsList;
  PlantListstate(this.plantsList):super(tag);
}