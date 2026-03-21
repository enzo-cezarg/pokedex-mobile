class PokemonType {
  final String name;
  final int id;

  PokemonType({required this.name, required this.id});

  factory PokemonType.fromJson(Map<String, dynamic> json) {
    return PokemonType(
      name: json['name'],
      id: int.parse(json['url'].split('/').reversed.skip(1).first),
    );
  }
}
