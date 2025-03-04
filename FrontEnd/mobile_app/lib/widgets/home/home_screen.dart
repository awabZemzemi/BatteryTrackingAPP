import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_app/providers/homeScreenProvider.dart';
import 'package:mobile_app/widgets/home/average.dart';
import 'package:mobile_app/widgets/home/battery_charge.dart';
import 'package:mobile_app/widgets/home/chart.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});
  String getHealthMesage(double health) {
    if (health > 80) {
      return 'Your battery is Healthy';
    } else {
      return 'Your Battery health is bad You should Change it';
    }
  }

  @override
  Widget build(BuildContext context, ref) {
    final charge = ref.watch(chargeProvider);
    ref.read(chargeProvider.notifier).getCharge();
    return SingleChildScrollView(
      child: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 5,
            ),
            BatteryCharge(
              percentage: charge,
              isCharging: false,
            ),
            const SizedBox(
              height: 30,
            ),
            Text(
              getHealthMesage(charge),
              style: const TextStyle(color: Color.fromARGB(255, 114, 114, 114)),
            ),
            const SizedBox(
              height: 30,
            ),
            const Chart(),
            const SizedBox(
              height: 30,
            ),
            const Average(title: 'Average consumption', value: 60)
          ],
        ),
      ),
    );
  }
}
