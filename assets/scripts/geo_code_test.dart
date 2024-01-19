import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:list_roamer/services/api_keys.dart';

Future<void> main() async {
  // Google Maps location link
  const locationLink = 'https://maps.app.goo.gl/YacqDjkdfEuW9x1m8';

  try {
    // Follow the redirect to get the final URL
    final response = await http.head(Uri.parse(locationLink));

    if (response.isRedirect) {
      final finalUrl = response.headers['location'];
      print('Final URL: $finalUrl');

      // Extract the place ID from the final URL
      final placeIdMatch = RegExp(r'goo\.gl/([^?]+)').firstMatch(finalUrl ?? '');
      final placeId = placeIdMatch?.group(1);

      if (placeId == null) {
        print('Error: Unable to extract place ID from the final URL.');
        return;
      }

      // Use the place ID to get details from the Geocoding API
      await getDetailsFromGeocodingAPI(placeId);
    } else {
      print('Error: The provided link is not a redirect.');
    }
  } catch (error) {
    print('Error following redirect: $error');
  }
}

Future<void> getDetailsFromGeocodingAPI(String placeId) async {
  // Google Maps API endpoint for geocoding
  const geocodeEndpoint = 'https://maps.googleapis.com/maps/api/geocode/json';

  // Your API key
  const apiKey = APIKeys.GOOGLE_MAPS_API_KEY;

  // Build the geocoding API request URL
  final requestUrl = '$geocodeEndpoint?place_id=$placeId&key=$apiKey';

  try {
    // Fetch data from the Google Maps Geocoding API using http package
    final response = await http.get(Uri.parse(requestUrl));

    if (response.statusCode == 200) {
      // Decode the JSON response
      final data = json.decode(response.body);

      // Extract location name (formatted address) from the API response
      final locationName = data['results'][0]['formatted_address'];

      // Extract latitude and longitude from the API response
      final location = data['results'][0]['geometry']['location'];
      final latitude = location['lat'];
      final longitude = location['lng'];

      // Use the extracted information
      print('Location Name: $locationName');
      print('Latitude: $latitude, Longitude: $longitude');
    } else {
      print('Error: Failed to fetch data from the Geocoding API. Status code: ${response.statusCode}');
    }
  } catch (error) {
    print('Error fetching data from the Geocoding API: $error');
  }
}
