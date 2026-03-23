import 'package:flutter/material.dart';
import 'package:pokedex/features/pokemon-list/components/pokemon_card.dart';
import 'package:pokedex/features/pokemon-move-details/pages/pokemon_move_details.dart';
import 'package:pokedex/models/pokemon.dart';

class PokemonMovesCard extends StatelessWidget {
  final Pokemon pokemon;

  const PokemonMovesCard({super.key, required this.pokemon});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(12),
        side: BorderSide(
          color: Theme.of(context).colorScheme.primary,
          width: 3,
          strokeAlign: 0,
        ),
      ),
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const .only(top: 16),
          child: Column(
            spacing: 10,
            crossAxisAlignment: .center,
            children: [
              Text(
                'Moves',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: .w600,
                ),
              ),
              SizedBox(
                width: .infinity,
                height: 300,
                child: ClipRRect(
                  borderRadius: .only(
                    bottomLeft: .circular(12),
                    bottomRight: .circular(12),
                  ),
                  child: ListView.builder(
                    itemCount: pokemon.moves.length,
                    itemBuilder: (context, index) {
                      final move = pokemon.moves[index];
                      final isEven = index % 2 == 0;

                      return Container(
                        color: isEven
                            ? Colors.grey.shade100
                            : Colors.grey.shade300,
                        child: Row(
                          mainAxisAlignment: .spaceBetween,
                          children: [
                            Padding(
                              padding: .symmetric(vertical: 10, horizontal: 24),
                              child: Text(
                                move.name.formatPokemonName(),
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            Padding(
                              padding: .only(right: 10),
                              child: IconButton(
                                onPressed: () => Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                    pageBuilder:
                                        (
                                          context,
                                          animation,
                                          secondaryAnimation,
                                        ) => PokemonMoveDetails(move: move),
                                    transitionDuration: Duration(
                                      milliseconds: 200,
                                    ),
                                    transitionsBuilder:
                                        (
                                          context,
                                          animation,
                                          secondaryAnimation,
                                          child,
                                        ) {
                                          return SlideTransition(
                                            position: Tween<Offset>(
                                              begin: const Offset(1, 0),
                                              end: Offset.zero,
                                            ).animate(animation),
                                            child: child,
                                          );
                                        },
                                  ),
                                ),
                                icon: Icon(Icons.chevron_right),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
