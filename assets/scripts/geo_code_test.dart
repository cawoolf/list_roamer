import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:list_roamer/services/api_keys.dart';
import 'package:puppeteer/puppeteer.dart';

Future<void> main() async {
  // Google Maps location link
  const locationLink = 'https://maps.app.goo.gl/YacqDjkdfEuW9x1m8';
  String? fullUrl = await getFullURLFromPuppeteer(locationLink);
  // print(fullUrl);
  // parsePlaceId(fullUrl);
  getDetailsFromGeocodingAPI(await parsePlaceId(fullUrl));

}

Future<String?> parsePlaceId(String? locationLink) async {
  final coordinatesMatch = RegExp(r'@([-0-9.,]+)').firstMatch(locationLink!);
  final coordinates = coordinatesMatch?.group(1);

  print("Coordinates: $coordinates");
  return coordinates;
}


Future<String?> getFullURLFromPuppeteer(String redirectLink) async {
  var browser = await puppeteer.launch(headless: true);

  // const testRedirect = 'https://maps.app.goo.gl/YacqDjkdfEuW9x1m8';

  // Open a new tab
  var myPage = await browser.newPage();

  // Go to a page and wait to be fully loaded
  await myPage.goto(redirectLink,
      wait: Until.networkIdle);

  print(myPage.url);

  // Gracefully close the browser's process
  await browser.close();

  return myPage.url;
}

Future<void> getDetailsFromGeocodingAPI(String? coordinates) async {
  if (coordinates != null) {
    // Split the coordinates into latitude, longitude, and zoom level
    final parts = coordinates.split(',');

    // Extract latitude and longitude
    final latitude = parts[0];
    final longitude = parts[1];

    // Google Maps API endpoint for geocoding
    const geocodeEndpoint = 'https://maps.googleapis.com/maps/api/geocode/json?';

    // Your API key
    const apiKey = APIKeys.GOOGLE_MAPS_API_KEY; // Replace with your actual API key

    // Build the geocoding API request URL
    final geocodingUrl = "$geocodeEndpoint&latlng=$latitude,$longitude&key=$apiKey";

    try {
      // Fetch data from the Google Maps Geocoding API using http package
      final response = await http.get(Uri.parse(geocodingUrl));

      if (response.statusCode == 200) {
        // Decode the JSON response
        final data = json.decode(response.body);

        // Extract location name (formatted address) from the API response
        final locationName = data['results'][0]['formatted_address'];

        // Use the extracted information
        print('Location Name: $locationName');
      } else {
        print('Error: Failed to fetch data from the Geocoding API. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error fetching data from the Geocoding API: $error');
    }
  } else {
    print("Coordinates not found in the provided link.");
  }
}

