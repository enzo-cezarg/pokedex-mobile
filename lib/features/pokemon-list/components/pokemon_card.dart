import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

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

    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Material(
        child: InkWell(
          onTap: () {
            debugPrint('teste');
          },
          child: Card(
            elevation: 3,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.3),
                    blurRadius: 12,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  // fundo verde pokédex
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.tertiary,
                      border: Border(
                        right: BorderSide(
                          color: Color.fromARGB(255, 102, 190, 113),
                          width: 3,
                        ),
                      ),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12),
                        bottomLeft: Radius.circular(12),
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
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
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
        ),
      ),
    );
  }
}
