import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fuel_price_tracker/models/fuel_type.dart';
import 'package:fuel_price_tracker/models/price_event.dart';
import 'package:fuel_price_tracker/repositories/fuel_repository.dart';



class FirebaseRepository implements FuelRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final priceEventsRef = FirebaseFirestore.instance
      .collection('events')
      .withConverter<PriceEvent>(
    fromFirestore: (snapshot, _) => PriceEvent.fromJson(snapshot.data()!),
    toFirestore: (event, _) => event.toJson(),
  );

  @override
  Future<void> addPriceEvent(PriceEvent event) async {
    await priceEventsRef.add(event);
  }

  @override
  Future<List<PriceEvent>> getRecentPriceEvents() async {
    final snapshot = await priceEventsRef.orderBy('timeStamp', descending: true).limit(100).get();
    return snapshot.docs.map((doc) => doc.data()).toList();
  }

  @override
  Future<List<PriceEvent>> getRecentPriceEventsForFuelType(FuelType fuelType) async {
    final snapshot = await priceEventsRef
        .where('fuelType', isEqualTo: fuelType.name)
        .orderBy('timestamp', descending: true)
        .limit(100)
        .get();
    return snapshot.docs.map((doc) => doc.data()).toList();
  }

  @override
  Future<PriceEvent> getMostRecentPrice(FuelType fuelType) async {
    List<PriceEvent> events = await getRecentPriceEventsForFuelType(fuelType);
    if (events.isNotEmpty) {
      return events.first;
    } else {
      return PriceEvent(timeStamp: DateTime.now(), fuelType: fuelType, price: 24);
    }
  }
}