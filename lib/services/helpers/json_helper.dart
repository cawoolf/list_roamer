import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';

class JSONHelper {
  static Future<List<dynamic>> loadJsonData({required String assetRoute}) async {
    String jsonString = await rootBundle.loadString(assetRoute);
    Map<String, dynamic> data = json.decode(jsonString);
    List<dynamic> peaks = data['peaks'];
    return peaks;
  }

}