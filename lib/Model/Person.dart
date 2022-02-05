class Person {
  final String name;
  final String? imageUrl;
  final String characterName;
  final double? popularity;

  Person(
      {required this.name,
      this.imageUrl,
      required this.characterName,
      required this.popularity});

  Person copyWith({
    String? name,
    String? imageUrl,
    String? characterName,
    double? popularity,
  }) {
    return Person(
        name: name ?? this.name,
        imageUrl: imageUrl ?? this.imageUrl,
        characterName: characterName ?? this.characterName,
        popularity: popularity ?? this.popularity
    );
  }

  factory Person.fromJson(Map<String, dynamic> map) {
    return Person(
      name: map['name'],
      characterName: map['character'],
      imageUrl: map['profile_path'],
      popularity: map['popularity'] as double,
    );
  }
}
