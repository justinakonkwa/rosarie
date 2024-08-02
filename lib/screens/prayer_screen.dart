import 'package:flutter/material.dart';
import 'package:holy_rosarie/models/prayers.dart';

class PrayerScreen extends StatelessWidget {
  final Prayer prayer;

  PrayerScreen({required this.prayer});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(prayer.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(prayer.text, style: TextStyle(fontSize: 18)),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Ajouter la logique de lecture audio ici
              },
              child: Text('Écouter la prière'),
            ),
          ],
        ),
      ),
    );
  }
}
