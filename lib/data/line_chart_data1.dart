import 'package:fl_chart/fl_chart.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class LineData1 {
  Future<Map<String, dynamic>> fetchData() async {
    final url =
        'https://api.thingspeak.com/channels/2505530/feeds.json?api_key=J2BXJBBW7WYO18GJ&results=120';
    List<FlSpot> flSpots = [];
    Map<String, dynamic> titles = {};

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);

        final List<Map<String, dynamic>> feeds =
            List<Map<String, dynamic>>.from(jsonResponse['feeds']);

        // Extract created_at and field1 and convert them into FlSpot format
        feeds.forEach((feed) {
          double createdAt = double.parse(feed['entry_id'].toString()) - feeds[0]['entry_id']; 
          double field1 = double.parse(feed['field1'].toString());
          flSpots.add(FlSpot(createdAt, field1));
        });

        titles['bottomTitle'] = {
          0: '0h',
          10: '1h',
          20: '2h',
          30: '3h',
          40: '4h',
          50: '5h',
          60: '6h',
          70: '7h',
          80: '8h',
          90: '9h',
          100: '10h',
          110: '11h',
        };

        titles['leftTitle'] = {
          0: '0 °C',
          20: '20 °C',
          40: '40 °C',
          60: '60 °C',
          80: '80 °C',
        };

        return {'flSpots': flSpots, 'titles': titles};
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      throw e.toString();
    }
  }
}
