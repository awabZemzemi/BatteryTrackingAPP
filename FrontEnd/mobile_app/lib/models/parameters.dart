class Parameters {
  final double terminalVoltage;
  final double terminalCurrent;
  final double temperature;
  final double chargeCurrent;
  final double capacity;
  final double cycle;
  final double soh;
  final double soc;

  Parameters({
    required this.terminalVoltage,
    required this.terminalCurrent,
    required this.temperature,
    required this.chargeCurrent,
    required this.capacity,
    required this.cycle,
    required this.soh,
    required this.soc,
  });
}
