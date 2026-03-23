import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pokedex/features/pokemon-list/components/pokemon_card.dart';
import 'package:pokedex/features/pokemon-list/providers/pokemon_provider.dart';
import 'package:pokedex/models/pokemon.dart';
import 'package:provider/provider.dart';

class PokemonDetailsCard extends StatelessWidget {
  final Pokemon pokemon;

  const PokemonDetailsCard({super.key, required this.pokemon});

  String get spriteUrl =>
      'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/${pokemon.id}.png';

  String get spriteBackUrl =>
      'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/${pokemon.id}.png';

  @override
  Widget build(BuildContext context) {
    final typeSpriteUrl = context.read<PokemonProvider>().typeSpriteUrl;

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: .circular(12),
        side: BorderSide(
          color: Theme.of(context).colorScheme.primary,
          width: 3,
          strokeAlign: 0,
        ),
      ),
      child: SizedBox(
        width: .infinity,
        child: Padding(
          padding: const .symmetric(vertical: 16),
          child: Column(
            crossAxisAlignment: .center,
            children: [
              Row(
                spacing: 16,
                mainAxisAlignment: .center,
                children: [
                  SizedBox(
                    width: 150,
                    height: 150,
                    child: CachedNetworkImage(
                      imageUrl: spriteUrl,
                      fit: .contain,
                      filterQuality: .none,
                      placeholder: (context, url) => Center(
                        child: SizedBox(
                          width: 25,
                          height: 25,
                          child: CircularProgressIndicator(
                            color: Color.fromARGB(255, 102, 190, 113),
                          ),
                        ),
                      ),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  ),
                  SizedBox(
                    width: 150,
                    height: 150,
                    child: CachedNetworkImage(
                      imageUrl: spriteBackUrl,
                      fit: .contain,
                      filterQuality: .none,
                      placeholder: (context, url) => Center(
                        child: SizedBox(
                          width: 25,
                          height: 25,
                          child: CircularProgressIndicator(
                            color: Color.fromARGB(255, 102, 190, 113),
                          ),
                        ),
                      ),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  ),
                ],
              ),
              Text(
                pokemon.name.formatPokemonName(),
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                  fontWeight: .w600,
                ),
              ),
              Row(
                spacing: 8,
                mainAxisAlignment: .center,
                children: [
                  ...pokemon.types.map(
                    (type) => Padding(
                      padding: const .only(top: 4),
                      child: SizedBox(
                        width: 70,
                        child: CachedNetworkImage(
                          imageUrl: '$typeSpriteUrl${type.id}.png',
                          fit: BoxFit.contain,
                          filterQuality: FilterQuality.none,
                          placeholder: (context, url) => Center(
                            child: SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                color: Color.fromARGB(255, 102, 190, 113),
                              ),
                            ),
                          ),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
