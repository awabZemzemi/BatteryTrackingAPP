import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:mobile_app/models/details_data.dart';
import 'package:firebase_database/firebase_database.dart';

int i = 0;

class futureDetails {
  futureDetails({this.data, this.error, this.isLoding = false, this.dataList});
  bool isLoding;
  String? error;
  DetailsData? data;
  List<DetailsData>? dataList;
}

class FetchDetailsNotifier extends StateNotifier<futureDetails> {
  FetchDetailsNotifier() : super(futureDetails(isLoding: true));
  double j = 0;
  void getResponse() async {
    try {
      final datasnapshot =
          await FirebaseDatabase.instance.ref().child('batteryDetails').get();
      if (datasnapshot.exists) {
        final values = datasnapshot.value as Map<dynamic, dynamic>;
        List list = [];
        values.forEach((key, value) {
          list.add(value);
        });
        j++;
        DetailsData newData = DetailsData(
          Current_charge: list[i]['Current_charge'],
          Current_measured: list[i]['Current_measured'],
          Temperature_measured: list[i]['Temperature_measured'],
          Time: j,
          Voltage_charge: list[i]['Voltage_charge'],
          Voltage_measured: list[i]['Voltage_measured'],
          Soc: list[i]['SOC'],
          Soh: list[i]['SOH'],
        );
        state = futureDetails(
            isLoding: false,
            data: newData,
            dataList: state.dataList == null
                ? [newData]
                : [...state.dataList!, newData]);
        i++;
      } else {
        state = futureDetails(error: 'Failed to load data', isLoding: false);
      }
    } catch (e) {
      state = futureDetails(error: e.toString(), isLoding: false);
    }
  }
}

final fetchDetailsProvider =
    StateNotifierProvider<FetchDetailsNotifier, futureDetails>((ref) {
  return FetchDetailsNotifier();
});
