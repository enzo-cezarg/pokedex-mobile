import 'package:flutter/material.dart';
import 'package:pokedex/features/pokemon-list/components/pokemon_card.dart';
import 'package:pokedex/features/pokemon-list/providers/pokemon_provider.dart';
import 'package:pokedex/features/pokemon-move-details/components/pokemon_move_details_card.dart';
import 'package:pokedex/models/move_details.dart';
import 'package:pokedex/models/pokemon_move.dart';
import 'package:provider/provider.dart';

class PokemonMoveDetails extends StatefulWidget {
  final PokemonMove move;

  const PokemonMoveDetails({super.key, required this.move});

  @override
  State<PokemonMoveDetails> createState() => _PokemonMoveDetailsState();
}

class _PokemonMoveDetailsState extends State<PokemonMoveDetails> {
  late MoveDetails move;
  bool isLoading = true;
  String? errorMsg;

  Future<void> fetchMove(String url) async {
    try {
      move = await context.read<PokemonProvider>().fetchMove(url);
    } catch (e) {
      errorMsg = e.toString();
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchMove(widget.move.url);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(
          widget.move.name.formatPokemonName(),
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator(color: Colors.white))
          : errorMsg != null
          ? Center(
              child: Text(errorMsg!, style: TextStyle(color: Colors.white)),
            )
          : SingleChildScrollView(
              child: Padding(
                padding: .all(8),
                child: PokemonMoveDetailsGrid(move: move),
              ),
            ),
    );
  }
}
