import 'package:fitness_dashboard_ui/model/health_model.dart';
import 'dart:convert'; // Import this for JSON parsing

import 'package:http/http.dart' as http;

class HealthDetails {
  Future<List<String>> fetchDataFromAPI() async {
    var url = Uri.parse(
        'https://api.thingspeak.com/channels/2505530/feeds.json?api_key=J2BXJBBW7WYO18GJ&results=1');

    try {
      var response = await http.get(url);

      if (response.statusCode == 200) {
        // Parse the JSON response
        Map<String, dynamic> jsonResponse = json.decode(response.body);

        // Access field1, field2, and field3 from the feeds list
        var fields = jsonResponse['feeds'][0];
        var field1 = fields['field1'];
        var field2 = fields['field2'];
        var field3 = fields['field3'];

        return [field1, field2, field3];
      } else {
        throw Exception("unable to get anything from api");
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<HealthModel>> getHealthData() async{
List<String> apiData = await fetchDataFromAPI();
    List<HealthModel> healthData = [
      HealthModel(icon: 'assets/images/humidity.png', value: apiData[1], title: "Humidity"),
      HealthModel(icon: 'assets/images/temperature.png', value: apiData[0],title: "Temperature"),
      HealthModel(icon: 'assets/images/moisture.png',value: apiData[2] , title: "Moisture"),
      HealthModel(icon: 'assets/images/motor.png', value: "yayy", title:  "Start Pump"),
    ];

    return healthData;
  }
}
