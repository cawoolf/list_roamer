import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:list_roamer/model/user_marker.dart';

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