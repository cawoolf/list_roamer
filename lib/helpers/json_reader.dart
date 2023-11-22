import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';

class JSONReader {
  static Set<Map<String, dynamic>> readJsonFile() {
    // String jsonString = await rootBundle.loadString(assetPath);
    Set<dynamic> jsonData = json.decode('''{
  "peaks": [
    {
      "name": "Mount Elbert",
      "elevation": 14440,
      "coordinates": {
        "latitude": 39.1178,
        "longitude": -106.4454
      }
    },
    {
      "name": "Mount Massive",
      "elevation": 14421,
      "coordinates": {
        "latitude": 39.1875,
        "longitude": -106.4753
      }
    },
    {
      "name": "Mount Harvard",
      "elevation": 14420,
      "coordinates": {
        "latitude": 38.9244,
        "longitude": -106.3208
      }
    },
    {
      "name": "Blanca Peak",
      "elevation": 14351,
      "coordinates": {
        "latitude": 37.5775,
        "longitude": -105.4856
      }
    },
    {
      "name": "La Plata Peak",
      "elevation": 14336,
      "coordinates": {
        "latitude": 39.0294,
        "longitude": -106.4727
      }
    },
    {
      "name": "Uncompahgre Peak",
      "elevation": 14309,
      "coordinates": {
        "latitude": 38.0717,
        "longitude": -107.4629
      }
    },
    {
      "name": "Crestone Peak",
      "elevation": 14294,
      "coordinates": {
        "latitude": 37.9665,
        "longitude": -105.5858
      }
    },
    {
      "name": "Mount Lincoln",
      "elevation": 14286,
      "coordinates": {
        "latitude": 39.3514,
        "longitude": -106.1111
      }
    },
    {
      "name": "Grays Peak",
      "elevation": 14270,
      "coordinates": {
        "latitude": 39.6339,
        "longitude": -105.8174
      }
    },
    {
      "name": "Mount Antero",
      "elevation": 14269,
      "coordinates": {
        "latitude": 38.6748,
        "longitude": -106.2467
      }
    }
  ]
}''');

    Set<Map<String, dynamic>> peakList = {};

    for (var peakData in jsonData) {
      peakList.add(peakData);
    }

    return peakList;
  }
}