import 'package:flutter/cupertino.dart';
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
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildCard(Icons.access_alarm, 'Card 1'),
        _buildCard(Icons.access_time, 'Card 2'),
        _buildCard(Icons.accessibility, 'Card 3'),
      ],
    );
  }

  Widget _buildCard(IconData iconData, String text) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              iconData,
              size: 48,
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
