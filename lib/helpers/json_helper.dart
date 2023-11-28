import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';

class JSONHelper {
  static Future<List<dynamic>> loadJsonData() async {
    String jsonString = await rootBundle.loadString('assets/json_data/peak_location.json');
    Map<String, dynamic> data = json.decode(jsonString);
    List<dynamic> peaks = data['peaks'];
    return peaks;
  }

}