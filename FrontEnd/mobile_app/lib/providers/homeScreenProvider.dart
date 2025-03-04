import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:firebase_database/firebase_database.dart';

int i = 0;

class FetchHomeNotifier extends StateNotifier<double> {
  FetchHomeNotifier() : super(0);
  void getCharge() async {
    final datasnapshot = await FirebaseDatabase.instance
        .ref()
        .child('batteryDetails')
        .limitToFirst(1)
        .get();
    if (datasnapshot.exists) {
      final response = datasnapshot.value as Map<dynamic, dynamic>;
      response.forEach((key, value) {
        state = double.parse((value['SOC'] as double).toStringAsFixed(2));
      });
    } else {
      throw Exception('Failed to load data');
    }
  }
}

final chargeProvider = StateNotifierProvider<FetchHomeNotifier, double>((ref) {
  return FetchHomeNotifier();
});
