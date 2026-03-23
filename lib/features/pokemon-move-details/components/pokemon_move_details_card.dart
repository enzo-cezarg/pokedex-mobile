import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pokedex/features/pokemon-list/components/pokemon_card.dart';
import 'package:pokedex/features/pokemon-list/providers/pokemon_provider.dart';
import 'package:pokedex/models/move_details.dart';
import 'package:provider/provider.dart';

class PokemonMoveDetailsGrid extends StatelessWidget {
  final MoveDetails move;

  const PokemonMoveDetailsGrid({super.key, required this.move});

  @override
  Widget build(BuildContext context) {
    final typeSpriteUrl = context.read<PokemonProvider>().typeSpriteUrl;

    return Column(
      spacing: 4,
      children: [
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: .circular(12),
            side: BorderSide(
              color: Theme.of(context).colorScheme.primary,
              width: 3,
              strokeAlign: 0,
            ),
          ),
          child: SizedBox(
            width: double.infinity,
            child: Padding(
              padding: .all(24),
              child: Text(
                move.flavorTextEntry,
                textAlign: .center,
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),
            ),
          ),
        ),
        GridView(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 2,
            mainAxisSpacing: 2,
            childAspectRatio: 3,
          ),
          children: [
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: .circular(12),
                side: BorderSide(
                  color: Theme.of(context).colorScheme.primary,
                  width: 3,
                  strokeAlign: 0,
                ),
              ),
              child: SizedBox(
                width: double.infinity,
                child: Center(
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Class: ',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 16,
                          ),
                        ),
                        TextSpan(
                          text: move.damageClass.formatPokemonName(),
                          style: TextStyle(color: Colors.black, fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: .circular(12),
                side: BorderSide(
                  color: Theme.of(context).colorScheme.primary,
                  width: 3,
                  strokeAlign: 0,
                ),
              ),
              child: SizedBox(
                width: double.infinity,
                child: Center(
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Power: ',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 16,
                          ),
                        ),
                        TextSpan(
                          text: move.power.toString(),
                          style: TextStyle(color: Colors.black, fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: .circular(12),
                side: BorderSide(
                  color: Theme.of(context).colorScheme.primary,
                  width: 3,
                  strokeAlign: 0,
                ),
              ),
              child: SizedBox(
                width: double.infinity,
                child: Center(
                  child: SizedBox(
                    width: 70,
                    child: CachedNetworkImage(
                      imageUrl: '$typeSpriteUrl${move.type.id}.png',
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
            ),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: .circular(12),
                side: BorderSide(
                  color: Theme.of(context).colorScheme.primary,
                  width: 3,
                  strokeAlign: 0,
                ),
              ),
              child: SizedBox(
                width: double.infinity,
                child: Center(
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'PP: ',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 16,
                          ),
                        ),
                        TextSpan(
                          text: move.pp.toString(),
                          style: TextStyle(color: Colors.black, fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
