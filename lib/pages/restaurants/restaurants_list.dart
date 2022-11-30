import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'package:supe_restaurants/database/database.dart';
import 'package:supe_restaurants/models/restaurant_model.dart';
import 'package:supe_restaurants/pages/auth/login_form.dart';
import 'package:supe_restaurants/utils/supe_client.dart';

class RestaurantsList extends StatefulWidget {
  const RestaurantsList({super.key});

  @override
  State<RestaurantsList> createState() => _RestaurantsListState();
}

class _RestaurantsListState extends State<RestaurantsList> {
  late SupeClient client;
  late FlutterSecureStorage storage;

  late Future<List<RestaurantModel>> results;

  void handleLogout() async {
    await storage.delete(key: 'username');
    await storage.delete(key: 'password');
    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const LoginForm(),
      ),
    );
  }

  @override
  void initState() {
    client = context.read<SupeClient>();
    storage = context.read<FlutterSecureStorage>();
    results = client.getAllRestaurants();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Supe Restaurants'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: handleLogout,
          )
        ],
      ),
      body: FutureBuilder(
        future: results,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text('Unable to load restaurants.'),
            );
          }

          final isLoading = snapshot.connectionState == ConnectionState.waiting;
          if (!snapshot.hasData || isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final data = snapshot.data!;
          if (data.isEmpty) {
            return const Center(
              child: Text('No restaurants were found.'),
            );
          }

          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              final item = data[index];
              return RestaurantListItem(item: item);
            },
          );
        },
      ),
    );
  }
}

class RestaurantListItem extends StatefulWidget {
  const RestaurantListItem({
    super.key,
    required this.item,
  });

  final RestaurantModel item;

  @override
  State<RestaurantListItem> createState() => _RestaurantListItemState();
}

class _RestaurantListItemState extends State<RestaurantListItem> {
  late AppDatabase database;

  bool isFavorite = false;

  void handleFavorite() {
    if (isFavorite) {
      database.deleteRestaurant(widget.item.id);
    } else {
      database.insertRestaurant(widget.item);
    }
    setState(() {
      isFavorite = !isFavorite;
    });
  }

  @override
  void initState() {
    database = context.read<AppDatabase>();
    database.existsProductById(widget.item.id).then((value) {
      setState(() {
        isFavorite = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        foregroundImage: NetworkImage(widget.item.poster),
        child: Text(widget.item.title[0].toUpperCase()),
      ),
      title: Text(widget.item.title, maxLines: 1),
      subtitle: Text('ID: ${widget.item.id}'),
      trailing: IconButton(
        icon: const Icon(Icons.favorite),
        color: isFavorite ? Colors.red : Colors.grey,
        onPressed: handleFavorite,
      ),
    );
  }
}
