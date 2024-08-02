import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:holy_rosarie/models/prayers.dart';

class PrayerService {
  Future<List<Prayer>> fetchPrayers() async {
    final response = await rootBundle.loadString('assets/prayers.json');
    final data = json.decode(response);
    
    if (data['prayers'] is List) {
      return (data['prayers'] as List)
          .map((json) => Prayer.fromJson(json))
          .toList();
    } else {
      throw Exception('Failed to load prayers');
    }
  }
}
