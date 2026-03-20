import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pokedex/features/pokemon-details/pages/pokemon_details.dart';

extension Capitalize on String {
  String capitalize() => '${this[0].toUpperCase()}${substring(1)}';
}

extension FormatPokemonName on String {
  String formatPokemonName() =>
      split('-').map((word) => word.capitalize()).join(' ');
}

class PokemonCard extends StatelessWidget {
  final String name;
  final int id;

  const PokemonCard({super.key, required this.name, required this.id});

  @override
  Widget build(BuildContext context) {
    final spriteUrl =
        'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/$id.png';

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(12),
          side: BorderSide(
            color: Theme.of(context).colorScheme.primary,
            width: 3,
            strokeAlign: -0.5,
          ),
        ),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: () => Navigator.push(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) =>
                  PokemonDetailsPage(name: name.formatPokemonName(), id: id),
              transitionDuration: Duration(milliseconds: 200),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
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
          borderRadius: BorderRadius.circular(16),
          child: Row(
            children: [
              // fundo verde pokédex
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.tertiary,
                  border: Border(
                    right: BorderSide(
                      color: Color.fromARGB(255, 102, 190, 113),
                      width: 3,
                    ),
                  ),
                ),
                child: CachedNetworkImage(
                  imageUrl: spriteUrl,
                  fit: BoxFit.contain,
                  filterQuality: FilterQuality.none,
                  placeholder: (context, url) => Center(
                    child: SizedBox(
                      width: 25,
                      height: 25,
                      child: CircularProgressIndicator(
                        color: Color.fromARGB(255, 102, 190, 113),
                      ),
                    ),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Text(
                    name.formatPokemonName(),
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(right: 16),
                child: Icon(Icons.chevron_right, color: Colors.black54),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
