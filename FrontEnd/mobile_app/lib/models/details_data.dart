// ignore_for_file: non_constant_identifier_names

class DetailsData {
  DetailsData(
      {required this.Current_charge,
      required this.Current_measured,
      required this.Temperature_measured,
      required this.Time,
      required this.Voltage_charge,
      required this.Voltage_measured,
      required this.Soc,
      required this.Soh});
  double Voltage_measured;
  double Current_measured;
  double Temperature_measured;
  double Current_charge;
  double Voltage_charge;
  double Time;
  double Soc;
  double Soh;
}
