import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:js' as js;

class AddPlaceModal extends StatefulWidget {
  const AddPlaceModal({super.key});

  @override
  State<StatefulWidget> createState() => _AddPlaceModalState();
}

class _AddPlaceModalState extends State<AddPlaceModal> {
  @override
  Widget build(BuildContext context) {
    return _buildAddPlaceModal();
  }

  Widget _buildAddPlaceModal() {
    // Needs to be inside a SafeArea
    return Container(
      width: 400,
      height: 350,
      decoration: BoxDecoration(
        color: Colors.grey[200], // Set background color
        borderRadius: BorderRadius.circular(8.0), // Set border radius
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _addByPlacesSearch(),
                const SizedBox(width: 16), // Adjust spacing between cards
                _addByGoogleMapsShare(),
              ],
            ),
            const SizedBox(height: 32), // Adjust vertical space between rows
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _addByGeoLocation(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCard(String iconPath, String text, VoidCallback onPressed) {
    return Card(
      child: InkWell(
        onTap: onPressed, // Here, we assign the onPressed function to the onTap event.
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                iconPath,
                width: 48,
                height: 48,
              ),
              SizedBox(height: 8),
              Text(
                text,
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _addByPlacesSearch() {
    return _buildCard('assets/images/icons/add_places_modal_icons/map-pin.png',
        'Search Places', triggerAddByPlaces);
  }

  Widget _addByGoogleMapsShare() {

    return _buildCard(
        'assets/images/icons/add_places_modal_icons/map-marker.png',
        'Share from Maps',
        triggerGoogleMapShare);
  }


  Widget _addByGeoLocation() {

    return _buildCard(
      'assets/images/icons/add_places_modal_icons/location-crosshairs.png',
      'GeoLocation',
      triggerGeoLocationAdd,
    );
  }


  // Business Logic
  void getCurrentLocation() async {

    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      print('Current Location: ${position.latitude}, ${position.longitude}');
    } catch (e) {
      print('Error: $e');
    }
  }

  void triggerGeoLocationAdd() {
      print('add_places_modal line 53-> _addByGeoLocation called');
      getCurrentLocation();
  }

  void triggerGoogleMapShare() =>
      print('add_places_modal line 64-> _addByGoogleMapsShare called');

  void triggerAddByPlaces() =>
      print('add_places_modal line 71-> _addByPlacesSearch called');
}

/*
Need to show a modal with three small square cards.
Share a location from Google Maps
Search for a location from Places API
Save and add the current GPS Location
  > Try to find the relevant place in Places API?

Modal can be created from two places?
On the Maps Page
  > Adds a place to whichever list is loaded on the Map
After selecting a List and landing on the MarkersViewPage
  > Can click add and create the modal and add to the current list
 */
