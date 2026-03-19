import 'package:flutter/material.dart';
import 'package:pokedex/features/pokemon-list/components/pokemon_card.dart';
import 'package:pokedex/features/pokemon-list/providers/pokemon_provider.dart';
import 'package:provider/provider.dart';

class PokemonList extends StatefulWidget {
  const PokemonList({super.key});

  @override
  State<PokemonList> createState() => _PokemonListState();
}

class _PokemonListState extends State<PokemonList> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<PokemonProvider>().fetchAll();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        spacing: 14,
        children: [
          TextField(
            onChanged: context.read<PokemonProvider>().onSearch,
            style: const TextStyle(color: Colors.black),
            decoration: InputDecoration(
              hintText: 'Buscar Pokémon...',
              hintStyle: TextStyle(color: Color.fromARGB(180, 76, 76, 76)),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: BorderSide.none,
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
            ),
          ),
          Expanded(
            child: Consumer<PokemonProvider>(
              builder: (context, provider, _) => ListView.builder(
                cacheExtent: 500,
                itemCount: provider.displayList.length,
                itemBuilder: (context, index) {
                  if (provider.isLoading) {
                    return CircularProgressIndicator(color: Colors.white);
                  }

                  if (!provider.isSearching &&
                      index == provider.displayList.length - 1) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      provider.loadNextPage();
                    });
                  }

                  final pokemon = provider.displayList[index];
                  final id = provider.getId(pokemon['url']);
                  return PokemonCard(name: pokemon['name'], id: id);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
