import 'package:flutter/foundation.dart';
import 'package:fuel_price_tracker/models/fuel_price_model.dart';
import 'package:fuel_price_tracker/models/price_event.dart';
import 'package:fuel_price_tracker/repositories/fuel_repository.dart';

import '../models/fuel_type.dart';

class FuelPriceViewModel extends ChangeNotifier {
  final FuelRepository _fuelRepository;
  final FuelPriceModel _fuelPriceModel;

  FuelPriceViewModel(this._fuelRepository, this._fuelPriceModel);

  int get currentPetrolPrice => _fuelPriceModel.currentPetrolPrice;
  int get currentDieselPrice => _fuelPriceModel.currentDieselPrice;

  bool get showPetrolPrice => _fuelPriceModel.showPetrolPrice;
  bool get showDieselPrice => _fuelPriceModel.showDieselPrice;

  Future<void> incrementPetrolPrice() async {
    _fuelPriceModel.updatePetrolPrice(_fuelPriceModel.currentPetrolPrice + 1);
    await _fuelRepository.addPriceEvent(
      PriceEvent.basic(FuelType.petrol, _fuelPriceModel.currentPetrolPrice),
    );
    notifyListeners();
  }

  Future<void> incrementDieselPrice() async {
    _fuelPriceModel.updateDieselPrice(_fuelPriceModel.currentDieselPrice + 1);
    await _fuelRepository.addPriceEvent(
      PriceEvent.basic(FuelType.diesel, _fuelPriceModel.currentDieselPrice),
    );
    notifyListeners();
  }

  Future<void> updatePetrolPrice(int newPrice) async {
    _fuelPriceModel.updatePetrolPrice(newPrice);
    await _fuelRepository.addPriceEvent(
      PriceEvent.basic(FuelType.petrol, _fuelPriceModel.currentPetrolPrice),
    );
    notifyListeners();
  }

  Future<void> updateDieselPrice(int newPrice) async {
    _fuelPriceModel.updateDieselPrice(newPrice);
    await _fuelRepository.addPriceEvent(
      PriceEvent.basic(FuelType.diesel, _fuelPriceModel.currentDieselPrice),
    );
    notifyListeners();
  }


  Future<List<PriceEvent>> getPriceHistory() {
    return _fuelRepository.getRecentPriceEvents();
  }

  void updateShowPetrolPrice(bool show) {
    _fuelPriceModel.updateShowPetrolPrice(show);
    notifyListeners();
  }

  void updateShowDieselPrice(bool show) {
    _fuelPriceModel.updateShowDieselPrice(show);
    notifyListeners();
  }

}