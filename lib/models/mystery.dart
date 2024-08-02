import '../screens/home_screen.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
class Mystery {
  final int id;
  final String title;
  final String description;
  final String imagePath;
  final List<Meditation> meditations;

  Mystery({
    required this.id,
    required this.title,
    required this.description,
    required this.imagePath,
    required this.meditations,
  });

  factory Mystery.fromJson(Map<String, dynamic> json) {
    return Mystery(
      id: json['id'] ?? 0, // Default to 0 if id is null
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      imagePath: json['imagePath'] ?? '',
      meditations: (json['meditations'] as List<dynamic>?)
          ?.map((meditationJson) => Meditation.fromJson(meditationJson))
          .toList() ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'imagePath': imagePath,
      'meditations': meditations.map((meditation) => meditation.toJson()).toList(),
    };
  }
}
// models/prayer.dart
class Prayer {
  final String title;
  final String text;

  Prayer({required this.title, required this.text});

  factory Prayer.fromJson(Map<String, dynamic> json) {
    return Prayer(
      title: json['title'],
      text: json['text'],
    );
  }
}




class Meditation {
  final String title;
  final String description;
  final String? audioPath;
  final List<PostMysteryPrayer> postMysteryPrayers;

  Meditation({
    required this.title,
    required this.description,
    this.audioPath,
    required this.postMysteryPrayers,
  });

  factory Meditation.fromJson(Map<String, dynamic> json) {
    return Meditation(
      title: json['title'],
      description: json['description'],
      audioPath: json['audioPath'],
      postMysteryPrayers: (json['postMysteryPrayers'] as List)
          .map((prayerJson) => PostMysteryPrayer.fromJson(prayerJson))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'audioPath': audioPath,
      'postMysteryPrayers': postMysteryPrayers.map((prayer) => prayer.toJson()).toList(),
    };
  }
}

class PostMysteryPrayer {
  final String title;
  final String text;

  PostMysteryPrayer({
    required this.title,
    required this.text,
  });

  factory PostMysteryPrayer.fromJson(Map<String, dynamic> json) {
    return PostMysteryPrayer(
      title: json['title'],
      text: json['text'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'text': text,
    };
  }
}