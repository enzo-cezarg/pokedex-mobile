import 'package:pokedex/models/pokemon_type.dart';

class MoveDetails {
  final String damageClass;
  final String flavorTextEntry;
  final int power;
  final int pp;
  final PokemonType type;

  const MoveDetails({
    required this.damageClass,
    required this.flavorTextEntry,
    required this.power,
    required this.pp,
    required this.type,
  });

  factory MoveDetails.fromJson(Map<String, dynamic> json) {
    final flavorTexts = json['flavor_text_entries'] as List;

    final enTexts = flavorTexts
        .where((e) => e['language']['name'] == 'en')
        .toList();

    final String flavorText = enTexts.isNotEmpty
        ? enTexts.last['flavor_text']
        : '';

    return MoveDetails(
      damageClass: json['damage_class']['name'],
      flavorTextEntry: flavorText,
      power: json['power'] ?? 0,
      pp: json['pp'],
      type: PokemonType.fromJson(json['type']),
    );
  }
}
