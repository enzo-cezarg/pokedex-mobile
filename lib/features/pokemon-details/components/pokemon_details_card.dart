import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class PokemonDetailsCard extends StatelessWidget {
  final String name;
  final int id;

  const PokemonDetailsCard({super.key, required this.name, required this.id});

  String get spriteUrl =>
      'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/$id.png';

  String get spriteBackUrl =>
      'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/$id.png';

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
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                spacing: 16,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 150,
                    height: 150,
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
                  SizedBox(
                    width: 150,
                    height: 150,
                    child: CachedNetworkImage(
                      imageUrl: spriteBackUrl,
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
                ],
              ),
              Text(
                name,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Row(
                spacing: 8,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('tipos', style: TextStyle(color: Colors.black)),
                  Text('tipos', style: TextStyle(color: Colors.black)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
