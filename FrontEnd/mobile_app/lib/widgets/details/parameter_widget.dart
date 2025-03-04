import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_app/models/details_data.dart';
import 'package:mobile_app/widgets/details/parameter_chart.dart';

class ParameterWidget extends StatelessWidget {
  const ParameterWidget(
      {required this.value, required this.title, super.key, this.temp});
  final String title;
  final double value;
  final double? temp;
  void _selectParameter(BuildContext ctx) {
    Navigator.push(ctx, MaterialPageRoute(builder: (Title) {
      return ParameterChart(
          title: title,
          yValueMapper: (DetailsData details, _) {
            switch (title) {
              case 'Current_charge':
                return details.Current_charge;

              case 'Current_measured':
                return details.Current_measured;
              case 'Voltage_charge':
                return details.Voltage_charge;
              case 'Voltage_measured':
                return details.Voltage_measured;
              case 'temperature':
                return details.Temperature_measured;
              case 'SOC':
                return details.Soc;
              case 'SOH':
                return details.Soh;
              default:
                return 0.0;
            }
          });
    }));
  }

  List<Color> getColors(temp) {
    if (temp != null) {
      if (temp > 30) {
        return [Color(0xFF512F), Color(0xDD2476)];
      } else {
        return [
          Color.fromARGB(255, 138, 35, 135),
          Color.fromARGB(255, 233, 64, 87),
          Color.fromARGB(255, 242, 113, 33),
        ];
      }
    } else {
      return [Color(0xFF0F9A8E), Color.fromARGB(255, 57, 243, 128)];
    }
  }

  @override
  Widget build(BuildContext context) {
    final val = value.toStringAsFixed(5);
    return InkWell(
      onTap: () {
        _selectParameter(context);
      },
      splashColor: Colors.greenAccent.withOpacity(0.3),
      child: Card(
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: getColors(temp),
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /*** Title ***/
              Text(
                title,
                style: GoogleFonts.lato(
                  textStyle: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              /*** Value ***/
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.9),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Text(
                    val,
                    style: GoogleFonts.lato(
                      textStyle: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF333333),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:mobile_app/models/details_data.dart';
// import 'package:mobile_app/widgets/details/parameter_chart.dart';

// class ParameterWidget extends StatelessWidget {
//   const ParameterWidget({
//     required this.value,
//     required this.title,
//     super.key,
//     this.temp,
//   });

//   final String title;
//   final double value;
//   final double? temp;

//   void _selectParameter(BuildContext ctx) {
//     Navigator.push(ctx, MaterialPageRoute(builder: (context) {
//       return ParameterChart(
//         title: title,
//         yValueMapper: (DetailsData details, _) {
//           switch (title) {
//             case 'Current_charge':
//               return details.Current_charge;
//             case 'Current_measured':
//               return details.Current_measured;
//             case 'Voltage_charge':
//               return details.Voltage_charge;
//             case 'Voltage_measured':
//               return details.Voltage_measured;
//             case 'temperature':
//               return details.Temperature_measured;
//             case 'SOC':
//               return details.Soc;
//             case 'SOH':
//               return details.Soh;
//             default:
//               return 0.0;
//           }
//         },
//       );
//     }));
//   }

//   List<Color> getColors(double? temp) {
//     if (temp != null) {
//       if (temp > 30) {
//         return [Colors.red.shade900, Colors.red.shade700];
//       } else if (temp < 10) {
//         return [Colors.blue.shade800, Colors.blue.shade600];
//       } else {
//         return [Colors.green.shade800, Colors.green.shade600];
//       }
//     } else {
//       return [Colors.grey.shade800, Colors.grey.shade600];
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final val = value.toStringAsFixed(2);

//     return SizedBox(
//       width: double.infinity,
//       child: InkWell(
//         onTap: () => _selectParameter(context),
//         splashColor: Colors.greenAccent.withOpacity(0.3),
//         child: Card(
//           elevation: 8,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(18),
//           ),
//           child: Container(
//             padding: const EdgeInsets.all(16),
//             decoration: BoxDecoration(
//                 gradient: LinearGradient(
//                     colors: getColors(temp),
//                     begin: Alignment.topLeft,
//                     end: Alignment.bottomRight)),
//           ),
//         ),
//       ),
//     );
//   }
// }
