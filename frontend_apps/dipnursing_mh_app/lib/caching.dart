import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';




Future<void> cacheData(String dataName ,List<dynamic> items) async {
  final prefs = await SharedPreferences.getInstance();
  final currentTime = DateTime.now().toIso8601String();
  final cacheData = {
    'timestamp': currentTime,
    'data': items,
  };
  await prefs.setString(dataName, json.encode(cacheData));
  //print("-----------cached data succesfully -------------");
}


Future<List<dynamic>> getCachedData(String dataName) async {
  final prefs = await SharedPreferences.getInstance();
  final cachedData = prefs.getString(dataName);
  //print("---------------- cached data -----------------------");
  List<dynamic> finalData = [];

  if( (cachedData != null) ) {
    final decodedData = json.decode(cachedData);
    //print("---------------- decoded data -----------------------");
    final cachedTimestamp = DateTime.parse(decodedData['timestamp']);
    // final cachedDataData = decodedData['data'];
    //print(cachedDataData);

    final currentTime = DateTime.now();
    final difference = currentTime.difference(cachedTimestamp).inMinutes;
    // Cache is valid for 30 minutes
    if( difference < 30){
      finalData = decodedData['data'];
    }
    //print("changed final data");
  }
  //print("--------- returned ${finalData}");
  return finalData;
}