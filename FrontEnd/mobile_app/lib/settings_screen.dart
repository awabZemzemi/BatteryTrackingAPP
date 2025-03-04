import 'package:flutter/material.dart';

// updateData() async {
//   final response =
//       await FirebaseDatabase.instance.ref().child('batteryDetails').get();
//   if (response != null) {
//     final data = response.value as Map<dynamic, dynamic>;
//     int i = 0;
//     if (data != null) {
//       data.forEach((key, value) {
//         i++;
//         print('updateddata');
//         print(key);
//         FirebaseDatabase.instance
//             .ref()
//             .child('batteryDetails')
//             .child(key)
//             .update({'state': i / 2 == 0 ? 'charging' : 'discharging'});
//       });
//     }
//   }
// }

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return const Text("settings");
  }
}
