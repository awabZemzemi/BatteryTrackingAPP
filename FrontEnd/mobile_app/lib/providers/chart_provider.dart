import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_app/models/chart_data.dart';
import 'package:mobile_app/widgets/home/average.dart';

ChartData getaAverage(int hour, List list) {
  double avg = 0;
  int count = 0;
  for (int i = 0; i < list.length; i++) {
    if (list[i]['Time'].hour == hour) {
      count++;
      avg += list[i]['SOC'];
    }
  }

  return ChartData(hour, avg / count);
}

int getAvgPerPeriod(Period period, List list) {
  double avg = 0;
  int count = 0;
  bool hasData = false;
  for (int i = 0; i < list.length; i++) {
    if (period == Period.week) {
      if ((list[i]['Time'] as DateTime)
          .isAfter(DateTime.now().subtract(Duration(days: 7)))) {
        count++;
        avg += list[i]['SOC'];
        hasData = true;
      }
    } else if (period == Period.month) {
      if ((list[i]['Time'] as DateTime)
          .isAfter(DateTime.now().subtract(Duration(days: 30)))) {
        count++;
        avg += list[i]['SOC'];
        hasData = true;
      }
    } else if (period == Period.day) {
      if ((list[i]['Time'] as DateTime)
          .isAfter(DateTime.now().subtract(Duration(days: 1)))) {
        count++;
        avg += list[i]['SOC'];
        hasData = true;
      }
    }
  }

  return hasData ? (avg / count).round() : 0;
}

final batteryDataProvider =
    FutureProvider<List<Map<String, dynamic>>>((ref) async {
  final datasnapshot =
      await FirebaseDatabase.instance.ref().child('batteryDetails').get();
  if (datasnapshot.exists) {
    final values = datasnapshot.value as Map<dynamic, dynamic>;
    List<Map<String, dynamic>> list = [];

    values.forEach((key, value) {
      list.add({
        'Current_charge': value['Current_charge'],
        'Current_measured': value['Current_measured'],
        'Temperature_measured': value['Temperature_measured'],
        'Time': DateTime.parse(value['Time']),
        'Voltage_charge': value['Voltage_charge'],
        'Voltage_measured': value['Voltage_measured'],
        'SOC': value['SOC'],
        'SOH': value['SOH'],
      });
    });

    list.sort((a, b) => a['Time'].compareTo(b['Time']));
    return list;
  } else {
    throw Exception('Failed to load data');
  }
});

final chartProvider = FutureProvider<List<ChartData>>((ref) async {
  final list = await ref.watch(batteryDataProvider.future);
  int lastSavedHour = list[0]['Time'].hour;

  return [
    for (int i = 6; i >= 0; i--)
      getaAverage(
        lastSavedHour - i >= 0 ? lastSavedHour - i : lastSavedHour - i + 24,
        list,
      ),
  ];
});
final avgPerPeriodProvider =
    FutureProvider.family<int, Period>((ref, period) async {
  final list = await ref.watch(batteryDataProvider.future);
  return getAvgPerPeriod(period, list);
});
