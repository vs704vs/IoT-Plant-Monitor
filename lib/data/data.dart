import 'dart:convert'; // Import this for JSON parsing

import 'package:http/http.dart' as http;

Future<void> fetchDataFromAPI() async {
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

      print([field1, field2, field3][0]);
    } else {
      print(
          'Failed to load data from API. Status code: ${response.statusCode}');
    }
  } catch (e) {
    print('Error occurred: $e');
  }
}

void main() {
  fetchDataFromAPI();
}
