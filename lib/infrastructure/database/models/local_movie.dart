class LocalMovie {
  final int id;
  final String title;
  final String posterPath;

  LocalMovie({required this.id, required this.title, required this.posterPath});

  // Convertir el objeto a Mapa (para guardarlo en SQLite)
  Map<String, dynamic> toMap() {
    return {'id': id, 'title': title, 'posterPath': posterPath};
  }

  // Convertir Mapa a objeto (para leer de SQLite)
  factory LocalMovie.fromMap(Map<String, dynamic> map) {
    return LocalMovie(
      id: map['id'],
      title: map['title'],
      posterPath: map['posterPath'],
    );
  }
}
