import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:holy_rosarie/models/mystery.dart';

class MysteryService {
  Future<List<Mystery>> fetchMysteries() async {
    final response = await rootBundle.loadString('assets/mysteries.json');
    final data = json.decode(response);
    final mysteries = (data['mysteries'] as List).map((json) => Mystery.fromJson(json)).toList();
    return mysteries;
  }
}