import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_app/providers/chart_provider.dart';

enum Period { day, week, month }

class Average extends ConsumerStatefulWidget {
  const Average({required this.title, required this.value, super.key});
  final String title;
  final double value;

  @override
  ConsumerState<Average> createState() {
    return _AverageState();
  }
}

class _AverageState extends ConsumerState<Average> {
  Period _selectedPerdiod = Period.day;
  @override
  Widget build(BuildContext context) {
    final avg = ref.watch(avgPerPeriodProvider(_selectedPerdiod));
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Card(
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF0F9A8E), Color.fromARGB(255, 57, 243, 128)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /*** Title ***/
              Text(
                widget.title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 20),
              /*** Row with Average and Dropdown ***/
              Row(
                children: [
                  const Text(
                    'Average:',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white70,
                    ),
                  ),
                  const SizedBox(width: 10),
                  /*** Period Dropdown ***/
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      color: Colors.white70,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<Period>(
                        value: _selectedPerdiod,
                        items: Period.values.map((Period period) {
                          return DropdownMenuItem<Period>(
                            value: period,
                            child: Text(
                              period.name.toUpperCase(),
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                          );
                        }).toList(),
                        onChanged: (Period? value) {
                          setState(() {
                            _selectedPerdiod = value!;
                          });
                        },
                      ),
                    ),
                  ),
                  const Spacer(),
                  /*** Average Value Container ***/
                  avg.when(
                    loading: () => const CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                    error: (error, stack) => Text(
                      'Error',
                      style: TextStyle(
                        color: Colors.redAccent[100],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    data: (average) => Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 4,
                            offset: Offset(2, 2),
                          ),
                        ],
                      ),
                      child: Text(
                        '$average%',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
    // return Container(
    //   padding: const EdgeInsets.symmetric(horizontal: 20),
    //   child: Card(
    //     elevation: 15,
    //     child: Container(
    //       decoration: const BoxDecoration(
    //           gradient: LinearGradient(
    //               colors: [Color.fromARGB(255, 28, 213, 34), Colors.lightGreen],
    //               begin: Alignment.topLeft,
    //               end: Alignment.bottomRight),
    //           borderRadius: BorderRadius.all(Radius.circular(15))),
    //       padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    //       child: Column(
    //         children: [
    //           Text(widget.title),
    //           Row(
    //             children: [
    //               const Text(
    //                 'average   ',
    //               ),
    //               DropdownButton(
    //                   value: _selectedPerdiod,
    //                   items: [
    //                     ...Period.values.map(
    //                       (e) => DropdownMenuItem(
    //                         value: e,
    //                         child: Text(
    //                           e.name,
    //                         ),
    //                       ),
    //                     )
    //                   ],
    //                   onChanged: (value) {
    //                     setState(() {
    //                       _selectedPerdiod = value!;
    //                     });
    //                   }),
    //               const SizedBox(
    //                 width: 50,
    //               ),
    //               avg.when(
    //                   loading: () => const CircularProgressIndicator(),
    //                   error: (error, stack) => Text('Error: $error'),
    //                   data: (avg) => Text(avg.toString()))
    //             ],
    //           )
    //         ],
    //       ),
    //     ),
    //   ),
    // );
  }
}
