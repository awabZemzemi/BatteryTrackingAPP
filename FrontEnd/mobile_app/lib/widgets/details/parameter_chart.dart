import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_app/models/details_data.dart';
import 'package:mobile_app/providers/parametersProvider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ParameterChart extends ConsumerWidget {
  ParameterChart({
    required this.title,
    required this.yValueMapper,
  });
  final String title;

  final double Function(DetailsData, int)? yValueMapper;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final refer = ref.watch(fetchDetailsProvider);
    List<DetailsData> data = refer.dataList!;
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SfCartesianChart(
          primaryXAxis: const NumericAxis(title: AxisTitle(text: 'Time (s)')),
          primaryYAxis: NumericAxis(title: AxisTitle(text: title)),
          series: <LineSeries<DetailsData, double>>[
            LineSeries<DetailsData, double>(
              dataSource: data,
              xValueMapper: (DetailsData details, _) => details.Time,
              yValueMapper: yValueMapper,
              dataLabelSettings: const DataLabelSettings(isVisible: true),
            ),
          ],
        ),
      ),
    );
  }
}
