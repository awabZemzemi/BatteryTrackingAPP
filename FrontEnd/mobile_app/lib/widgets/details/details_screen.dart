import 'package:flutter/material.dart';
import 'package:mobile_app/widgets/details/parameter_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_app/providers/parametersProvider.dart';
import 'dart:async';

class DetailsScreen extends ConsumerStatefulWidget {
  const DetailsScreen({super.key});
  @override
  ConsumerState<DetailsScreen> createState() {
    return _DetailsScreenState();
  }
}

class _DetailsScreenState extends ConsumerState<DetailsScreen> {
  @override
  void initState() {
    super.initState();
    ref.read(fetchDetailsProvider.notifier).getResponse();

    Timer.periodic(const Duration(seconds: 5), (timer) {
      ref.read(fetchDetailsProvider.notifier).getResponse();
    });
  }

  @override
  Widget build(BuildContext context) {
    final data = ref.watch(fetchDetailsProvider);
    return data.isLoding
        ? const Center(child: CircularProgressIndicator())
        : data.error != null
            ? Text(data.error!)
            : AnimatedSwitcher(
                duration: const Duration(milliseconds: 500),
                transitionBuilder: (Widget child, Animation<double> animation) {
                  return FadeTransition(opacity: animation, child: child);
                },
                child: SingleChildScrollView(
                  key: ValueKey(data.data!.Time),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Column(
                    children: [
                      ParameterWidget(
                        value: data.data!.Soc,
                        title: 'SOC',
                      ),
                      const SizedBox(height: 10),
                      ParameterWidget(
                        value: data.data!.Soh,
                        title: 'SOH',
                      ),
                      const SizedBox(height: 10),
                      ParameterWidget(
                        value: data.data!.Current_charge,
                        title: 'Current charge',
                      ),
                      const SizedBox(height: 10),
                      ParameterWidget(
                        value: data.data!.Current_measured,
                        title: 'Current measured',
                      ),
                      const SizedBox(height: 10),
                      ParameterWidget(
                        value: data.data!.Voltage_charge,
                        title: 'Voltage charge',
                      ),
                      const SizedBox(height: 10),
                      ParameterWidget(
                        value: data.data!.Temperature_measured,
                        title: 'Temperature',
                        temp: data.data!.Temperature_measured,
                      ),
                      const SizedBox(height: 10),
                      ParameterWidget(
                        value: data.data!.Soc,
                        title: 'Voltage measured',
                      ),
                      const SizedBox(height: 10),
                      ParameterWidget(
                        value: data.data!.Soh,
                        title: 'Voltage measured',
                      ),
                    ],
                  ),
                ),
              );
  }
}
