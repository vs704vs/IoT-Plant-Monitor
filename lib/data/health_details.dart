import 'package:fitness_dashboard_ui/model/health_model.dart';

class HealthDetails {
  final healthData = const [
    HealthModel(
        icon: 'assets/icons/burn.png', value: "40%", title: "Humidity"),
    HealthModel(
        icon: 'assets/icons/steps.png', value: "34°C", title: "Temperature"),
    HealthModel(
        icon: 'assets/icons/distance.png', value: "60%", title: "Moisture"),
    HealthModel(icon: 'assets/icons/sleep.png', value: "7h48m", title: "Start Pump"),
  ];
}
