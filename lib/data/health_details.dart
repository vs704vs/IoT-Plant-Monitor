import 'package:fitness_dashboard_ui/model/health_model.dart';

class HealthDetails {
  final healthData = const [
    HealthModel(
        icon: 'assets/images/humidity.png', value: "40%", title: "Humidity"),
    HealthModel(
        icon: 'assets/images/temperature.png', value: "34°C", title: "Temperature"),
    HealthModel(
        icon: 'assets/images/moisture.png', value: "60%", title: "Moisture"),
    HealthModel(icon: 'assets/icons/sleep.png', value: "7h48m", title: "Start Pump"),
  ];
}
