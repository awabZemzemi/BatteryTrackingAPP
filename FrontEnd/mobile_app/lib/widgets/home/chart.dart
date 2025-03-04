import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_app/providers/chart_provider.dart';

import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:mobile_app/models/chart_data.dart';

class Chart extends ConsumerWidget {
  const Chart({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chartData = ref.watch(chartProvider);

    return chartData.when(
      loading: () => const CircularProgressIndicator(),
      error: (error, stack) => Text('Error: $error'),
      data: (chartData) => SfCartesianChart(
        primaryXAxis: const CategoryAxis(),
        primaryYAxis: const NumericAxis(
          labelFormat:
              '{value}%', // This adds a percentage sign to the Y-axis labels
        ),
        series: <CartesianSeries>[
          ColumnSeries<ChartData, String>(
            dataSource: chartData,
            xValueMapper: (ChartData data, _) =>
                data.time <= 12 ? '${data.time} AM' : "${data.time - 12} PM",
            yValueMapper: (ChartData data, _) => data.percentage,
            pointColorMapper: (ChartData data, _) {
              if (data.percentage < 20) {
                return Colors.red;
              } else if (data.percentage < 30) {
                return Colors.orange;
              } else if (data.percentage < 50) {
                return const Color.fromARGB(255, 255, 230, 0);
              } else if (data.percentage < 70) {
                return Colors.lightGreen;
              } else {
                return Colors.green;
              }
            },
            borderRadius: const BorderRadius.all(Radius.circular(5)),
          ),
        ],
      ),
    );
  }
}
