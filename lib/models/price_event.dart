import 'fuel_type.dart';

class PriceEvent{
  final DateTime timeStamp;
  final FuelType fuelType;
  final int price;

  PriceEvent({required this.timeStamp, required this.fuelType, required this.price});

  PriceEvent.basic(FuelType fuelType, int price) : this(
    timeStamp: DateTime.now(),
    fuelType: fuelType,
    price: price
  );

  Map<String, dynamic> toJson(){
    return {
      'timeStamp': timeStamp.toIso8601String(),
      'price': price,
      'fuelType': fuelType.name
    };
  }

  PriceEvent.fromJson(Map<String, dynamic> jsonMap) : this (
    timeStamp: DateTime.parse(jsonMap['timeStamp'] as String),
    fuelType: (jsonMap['fuelType'] as String) == 'diesel' ? FuelType.diesel : FuelType.petrol,
    price: jsonMap['price'] as int,

  );

  @override
  String toString(){
    return 'PriceEvent{timestamp:$timeStamp, fuelType: $fuelType, price: $price}';
  }
}


