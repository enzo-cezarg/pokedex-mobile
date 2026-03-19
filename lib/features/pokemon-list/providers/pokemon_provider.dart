import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PokemonProvider extends ChangeNotifier {
  // listas
  List<Map> allPokemons = []; // lista completa carregada uma vez
  List<Map> paginatedList = []; // slice do allPokemons exibido na UI
  List<Map> searchResults = []; // resultado do filtro local

  // controles de paginação
  int currentPage = 0;
  final int pageSize = 20;
  bool isLoading = false;
  String searchQuery = '';

  // getters de conveniência pra UI
  bool get isSearching => searchQuery.isNotEmpty;
  List<Map> get displayList => isSearching ? searchResults : paginatedList;

  // carrega todos os nomes uma vez
  Future<void> fetchAll() async {
    isLoading = true;
    notifyListeners();

    final res = await http.get(
      Uri.parse('https://pokeapi.co/api/v2/pokemon?limit=100000&offset=0'),
    );
    final data = jsonDecode(res.body);
    //allPokemons = List<Map>.from(data['results']);

    allPokemons = List<Map>.from(
      data['results'],
    ).where(isBaseOrRegional).toList();

    /* somente pokemons base > allPokemons = List<Map>.from(
      data['results'],
    ).where((p) => getId(p['url']) <= 1010).toList();*/

    _loadPage();

    isLoading = false;
    notifyListeners();
  }

  // chamado pelo scroll infinito
  void loadNextPage() {
    if (isSearching) return;
    currentPage++;
    _loadPage();
    notifyListeners();
  }

  void _loadPage() {
    final end = (currentPage + 1) * pageSize;
    paginatedList = allPokemons.sublist(0, end.clamp(0, allPokemons.length));
  }

  // chamado pelo onChange do controller
  void onSearch(String query) {
    searchQuery = query.toLowerCase();

    if (searchQuery.isEmpty) {
      currentPage = 0;
      _loadPage();
    } else {
      searchResults = allPokemons
          .where((p) => p['name'].contains(searchQuery))
          .toList();
    }

    notifyListeners();
  }

  // extrai o id da url pra montar sprite
  int getId(String url) => int.parse(url.split('/').reversed.skip(1).first);

  bool isBaseOrRegional(Map pokemon) {
    final name = pokemon['name'] as String;
    final id = getId(pokemon['url']);

    if (id <= 1010) return true; // todos os base

    // formas regionais pelos sufixos
    return name.endsWith('-alola') ||
        name.endsWith('-galar') ||
        name.endsWith('-hisui') ||
        name.endsWith('-paldea');
  }
}
