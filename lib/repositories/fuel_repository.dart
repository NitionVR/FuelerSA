import 'package:fuel_price_tracker/models/fuel_type.dart';
import 'package:fuel_price_tracker/models/price_event.dart';

abstract class FuelRepository{
  Future<void> addPriceEvent(PriceEvent event);
  Future<List<PriceEvent>> getRecentPriceEvents();
  Future<List<PriceEvent>> getRecentPriceEventsForFuelType(FuelType fuelType);
  Future<PriceEvent> getMostRecentPrice(FuelType fuelType);
}