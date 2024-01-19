import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as html;
import 'dart:convert';

void main() async {
  // List of URLs
  final urls = [
    'https://www.mountainproject.com/area/105716763/indian-creek',
    'https://www.mountainproject.com/area/105716784/castle-valley',
    'https://www.mountainproject.com/area/105716826/saint-george',
    'https://www.mountainproject.com/area/105717086/kolob-canyon',
    'https://www.mountainproject.com/area/105744243/clear-creek-canyon',
    'https://www.mountainproject.com/area/105744246/eldorado-canyon-state-park',
    'https://www.mountainproject.com/area/105744319/castlewood-canyon-sp',
    'https://www.mountainproject.com/area/105744373/poudre-canyon',
    'https://www.mountainproject.com/area/105837312/reimers-ranch',
    'https://www.mountainproject.com/area/105868955/taos-area',
  ];

  // List to store data for each URL
  final List<Map<String, dynamic>> dataList = [];

  // Loop through each URL
  for (final url in urls) {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final document = html.parse(response.body);

      // Extract title
      final titleElement = document.querySelector('title');
      final title = titleElement?.text ?? 'Title not found';

      // Find GPS coordinates directly in the HTML
      final gpsMatch = RegExp(r'(\d+\.\d+),\s*(-?\d+\.\d+)').firstMatch(response.body);
      final latitude = gpsMatch?.group(1) ?? 'Latitude not found';
      final longitude = gpsMatch?.group(2) ?? 'Longitude not found';

      // Create data for the URL
      final urlData = {
        'name': title,
        'snippet': 'One of Cams many crags',
        'coordinates': {
          'latitude': double.parse(latitude),
          'longitude': double.parse(longitude),
        },
      };

      // Add data to the list
      dataList.add(urlData);
    } else {
      print('Failed to load the website $url. Status code: ${response.statusCode}');
    }
  }

  // Create JSON object with the list of data
  final jsonData = {'crags': dataList};

  // Convert the JSON to string
  final jsonString = jsonEncode(jsonData);

  // Print the JSON
  print('JSON Data:\n$jsonString');
}



