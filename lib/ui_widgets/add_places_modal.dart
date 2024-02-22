import 'package:flutter/material.dart';

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
                _buildCard('assets/images/icons/add_places_modal_icons/map-pin.png', 'Card 1'),
                const SizedBox(width: 16), // Adjust spacing between cards
                _buildCard('assets/images/icons/add_places_modal_icons/map-marker.png', 'Card 2'),
              ],
            ),
            const SizedBox(height: 32), // Adjust vertical space between rows
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildCard('assets/images/icons/add_places_modal_icons/location-crosshairs.png', 'Card 3'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCard(String iconPath, String text) {
    return Card(
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
    );
  }
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