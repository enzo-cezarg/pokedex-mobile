class PokemonMove {
  final String name;
  final String url;

  PokemonMove({required this.name, required this.url});

  factory PokemonMove.fromJson(Map<String, dynamic> json) {
    return PokemonMove(name: json['name'], url: json['url']);
  }
}
