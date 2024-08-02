import 'package:flutter/material.dart';
import 'package:holy_rosarie/models/prayers.dart';
import 'package:holy_rosarie/services/prayers_service.dart';


class PrayerProvider with ChangeNotifier {
  List<Prayer> _prayers = [];
  final PrayerService _prayerService = PrayerService();

  List<Prayer> get prayers => _prayers;

  Future<void> loadPrayers() async {
    _prayers = await _prayerService.fetchPrayers();
    notifyListeners();
  }
}
