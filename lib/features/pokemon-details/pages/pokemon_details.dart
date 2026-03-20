import 'package:flutter/material.dart';
import 'package:pokedex/features/pokemon-details/components/pokemon_details_card.dart';

class PokemonDetailsPage extends StatefulWidget {
  final String name;
  final int id;

  const PokemonDetailsPage({super.key, required this.name, required this.id});

  @override
  State<PokemonDetailsPage> createState() => _PokemonDetailsPageState();
}

class _PokemonDetailsPageState extends State<PokemonDetailsPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 1, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(widget.name, style: TextStyle(fontWeight: FontWeight.bold)),
        bottom: _NoSplashTabBar(
          tabBar: TabBar(
            controller: _tabController,
            labelStyle: TextStyle(
              color: Theme.of(context).colorScheme.onPrimary,
              fontWeight: FontWeight.w600,
            ),
            indicatorPadding: EdgeInsetsGeometry.symmetric(horizontal: -16),
            indicatorSize: TabBarIndicatorSize.label,
            overlayColor: WidgetStateProperty.all(Colors.transparent),
            tabs: [
              Tab(
                text: 'Details',
                icon: Icon(
                  Icons.info_outline,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
            ],
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                  PokemonDetailsCard(name: widget.name, id: widget.id),
                  Text('2'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _NoSplashTabBar extends StatelessWidget implements PreferredSizeWidget {
  final TabBar tabBar;

  const _NoSplashTabBar({required this.tabBar});

  @override
  Size get preferredSize => tabBar.preferredSize;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        tabBar,
        Positioned.fill(child: Container(color: Colors.transparent)),
      ],
    );
  }
}
