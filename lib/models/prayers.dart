class Prayer {
  final int id;
  final String title;
  final String text;
  final String audioPath;

  Prayer({
    required this.id,
    required this.title,
    required this.text,
    required this.audioPath,
  });

  factory Prayer.fromJson(Map<String, dynamic> json) {
    return Prayer(
      id: json['id'] ?? 0, // Assurez-vous de gérer les valeurs null ou de fournir une valeur par défaut
      title: json['title'] ?? '',
      text: json['text'] ?? '',
      audioPath: json['audioPath'] ?? '',
    );
  }
}
