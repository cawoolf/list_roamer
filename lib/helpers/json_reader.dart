import 'dart:convert';
import 'dart:io';

class JSONReader {
  static Set<Map<String, dynamic>> readJsonFile(String jsonFilePath) {
    String jsonString = File(jsonFilePath).readAsStringSync();
    Set<dynamic> jsonData = json.decode(jsonString);

    Set<Map<String, dynamic>> peakList = {};

    for (var peakData in jsonData) {
      peakList.add(peakData);
    }

    return peakList;
  }
}