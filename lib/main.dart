import 'package:flutter/material.dart';
import 'package:pokedex/features/pokemon-list/pages/home.dart';
import 'package:pokedex/features/pokemon-list/providers/pokemon_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const PokedexApp());
}

class PokedexApp extends StatelessWidget {
  const PokedexApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => PokemonProvider())],
      child: MaterialApp(
        title: 'Pokédex App',
        theme: ThemeData(
          useMaterial3: true,
          fontFamily: 'Inter',
          colorScheme: .fromSeed(seedColor: Color.fromARGB(255, 229, 68, 31))
              .copyWith(
                primary: Color.fromARGB(255, 229, 68, 31),
                onPrimary: Colors.white,
                secondary: Color.fromARGB(255, 252, 94, 63),
                onSecondary: Colors.white,
                tertiary: Color.fromARGB(255, 174, 254, 184),
                surface: Color.fromARGB(255, 252, 94, 63),
                onSurface: Colors.white,
              ),
        ),
        home: const HomePage(title: 'Pokédex'),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
