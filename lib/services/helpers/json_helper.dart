import 'dart:convert';
import 'package:flutter/services.dart';

class JSONHelper {
  static Future<List<dynamic>> loadJsonData({required String assetRoute, required String dataName}) async {

    // print(assetRoute);
    String jsonString = await rootBundle.loadString(assetRoute);
    // print(jsonString);
    Map<String, dynamic> data = json.decode(jsonString);
    // print(data.toString());
    List<dynamic> markerData = data[dataName]; // 'peaks'
    return markerData;
  }

}