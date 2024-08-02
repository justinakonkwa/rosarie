import 'package:flutter/material.dart';
import 'package:holy_rosarie/services/mystere_service.dart';
import '../models/mystery.dart';

class MysteryProvider with ChangeNotifier {
  List<Mystery> _mysteries = [];
  final MysteryService _mysteryService = MysteryService();

  List<Mystery> get mysteries => _mysteries;

  Future<void> loadMysteries() async {
    _mysteries = await _mysteryService.fetchMysteries();
    notifyListeners();
  }
}
