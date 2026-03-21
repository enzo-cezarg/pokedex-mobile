import 'package:pokedex/models/pokemon_move.dart';
import 'package:pokedex/models/pokemon_type.dart';

class Pokemon {
  final int id;
  final String name;
  final List<PokemonType> types;
  final List<PokemonMove> moves;

  Pokemon({
    required this.id,
    required this.name,
    required this.types,
    required this.moves,
  });

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    final List<PokemonType> typesList = [];

    for (final types in json['types'] as List) {
      typesList.add(PokemonType.fromJson(types['type']));
    }

    final List<PokemonMove> movesList = [];
    for (final moves in json['moves']) {
      movesList.add(PokemonMove.fromJson(moves['move']));
    }

    return Pokemon(
      id: json['id'],
      name: json['name'],
      types: typesList,
      moves: movesList,
    );
  }
}
