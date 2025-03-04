// import 'package:flutter/material.dart';

// class BatteryCharge extends StatelessWidget {
//   final double percentage;
//   final double kmpercent = 0.4;
//   const BatteryCharge({required this.percentage, super.key});

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 150,
//       width: 150,
//       child: Stack(
//         fit: StackFit.expand,
//         children: [
//           CircularProgressIndicator(
//             value: percentage / 100,
//             strokeWidth: 12,
//             backgroundColor: Colors.grey.shade200,
//             valueColor: const AlwaysStoppedAnimation<Color>(Colors.green),
//           ),
//           Center(
//             child: Column(mainAxisSize: MainAxisSize.min, children: [
//               Text(
//                 '$percentage%',
//                 style:
//                     const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//               ),
//               Text(
//                 '${(kmpercent * percentage).toStringAsFixed(2)} Km',
//                 style: const TextStyle(
//                     fontSize: 22,
//                     fontWeight: FontWeight.bold,
//                     color: Color.fromARGB(255, 129, 125, 125)),
//               ),
//             ]),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class BatteryCharge extends StatelessWidget {
  final double percentage;
  final double kmpercent = 0.4;
  final bool isCharging; // New parameter to indicate charging status

  const BatteryCharge({
    required this.percentage,
    required this.isCharging, // Initialize charging status
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 190,
      width: 190,
      child: Stack(
        fit: StackFit.expand,
        children: [
          SfCircularChart(
            margin: const EdgeInsets.all(0),
            series: <CircularSeries>[
              RadialBarSeries<_ChartData, String>(
                dataSource: [_ChartData('Battery', percentage)],
                xValueMapper: (_ChartData data, _) => data.label,
                yValueMapper: (_ChartData data, _) => data.value,
                radius: '100%',
                innerRadius: '80%',
                cornerStyle: CornerStyle.bothCurve,
                trackColor: Colors.grey.shade200,
                trackBorderWidth: 12,
                maximumValue: 100,
                pointColorMapper: (_ChartData data, _) {
                  if (data.value < 20) {
                    return Colors.red;
                  } else if (data.value < 30) {
                    return Colors.orange;
                  } else if (data.value < 50) {
                    return const Color.fromARGB(255, 255, 230, 0);
                  } else if (data.value < 70) {
                    return Colors.lightGreen;
                  } else {
                    return Colors.green;
                  }
                },
              ),
            ],
          ),
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '$percentage%',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '${(kmpercent * percentage).toStringAsFixed(2)} Km',
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 129, 125, 125),
                  ),
                ),
                if (isCharging)
                  const Padding(
                    padding: EdgeInsets.only(top: 8.0),
                    child: Icon(Icons.flash_on, color: Colors.yellow, size: 30),
                  ),
                if (!isCharging)
                  const Padding(
                    padding: EdgeInsets.only(top: 8.0),
                    child: Icon(Icons.flash_off, color: Colors.red, size: 30),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ChartData {
  _ChartData(this.label, this.value);

  final String label;
  final double value;
}
