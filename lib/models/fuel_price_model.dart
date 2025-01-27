import 'package:flutter/foundation.dart';

class FuelPriceModel extends ChangeNotifier {
  int _petrolPricePerLitre = 21;
  int _dieselPricePerLitre = 22;

  bool _showPetrolPrice = true;
  bool _showDieselPrice = true;

  int get currentPetrolPrice => _petrolPricePerLitre;
  int get currentDieselPrice => _dieselPricePerLitre;

  bool get showPetrolPrice => _showPetrolPrice;
  bool get showDieselPrice => _showDieselPrice;

  void updatePetrolPrice(int newPrice) {
    _petrolPricePerLitre = newPrice;
    notifyListeners();
  }

  void updateDieselPrice(int newPrice) {
    _dieselPricePerLitre = newPrice;
    notifyListeners();
  }

  void updateShowPetrolPrice(bool show) {
    _showPetrolPrice = show;
    notifyListeners();
  }

  void updateShowDieselPrice(bool show) {
    _showDieselPrice = show;
    notifyListeners();
  }
}