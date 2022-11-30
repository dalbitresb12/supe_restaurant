import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'package:supe_restaurants/database/database.dart';
import 'package:supe_restaurants/pages/auth/login_form.dart';
import 'package:supe_restaurants/utils/supe_client.dart';

void main() {
  runApp(const AppRoot());
}

class AppRoot extends StatelessWidget {
  const AppRoot({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<FlutterSecureStorage>(
          create: (_) => const FlutterSecureStorage(),
        ),
        Provider<SupeClient>(
          create: (_) => SupeClient(),
        ),
        Provider<AppDatabase>(
          create: (_) => AppDatabase(),
        ),
      ],
      child: MaterialApp(
        title: 'Supe Restaurants',
        theme: ThemeData(
          primarySwatch: Colors.deepOrange,
        ),
        home: const LoginForm(),
      ),
    );
  }
}
