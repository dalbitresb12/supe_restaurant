import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'package:supe_restaurants/pages/auth/register_form.dart';
import 'package:supe_restaurants/pages/restaurants/restaurants_list.dart';
import 'package:supe_restaurants/utils/supe_client.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  late SupeClient client;
  late FlutterSecureStorage storage;

  bool initialized = false;

  String username = '';
  String password = '';

  void navigateToRegister() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const RegisterForm(),
      ),
    );
  }

  Future<bool> handleSubmit() async {
    try {
      await client.login(username: username, password: password);
      await storage.write(key: 'username', value: username);
      await storage.write(key: 'password', value: password);
      if (!mounted) return true;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const RestaurantsList(),
        ),
      );
    } catch (error) {
      String message = 'An unknown error has ocurred';
      if (error is InvalidLoginException) {
        message = error.cause;
      }
      final snackBar = SnackBar(content: Text(message));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
    return false;
  }

  @override
  void initState() {
    client = context.read<SupeClient>();
    storage = context.read<FlutterSecureStorage>();
    storage.readAll().then((values) async {
      if (!mounted) return;
      final username = values['username'];
      final password = values['password'];
      if (username == null || password == null) {
        setState(() {
          initialized = true;
        });
        return;
      }
      this.username = username;
      this.password = password;
      final result = await handleSubmit();
      if (!result) {
        setState(() {
          initialized = true;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    if (!initialized) {
      return const Scaffold(
        body: SafeArea(
          child: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      );
    }

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
            child: Column(
              children: [
                Center(
                  child: Text(
                    'Supe Restaurants',
                    style: textTheme.headlineMedium
                        ?.copyWith(color: Colors.deepOrange),
                  ),
                ),
                const SizedBox(height: 8),
                Center(
                  child: Text(
                    'Sign In',
                    style: textTheme.titleMedium,
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Username',
                  ),
                  onChanged: (value) {
                    setState(() {
                      username = value;
                    });
                  },
                ),
                const SizedBox(height: 16),
                TextField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                  ),
                  obscureText: true,
                  onChanged: (value) {
                    setState(() {
                      password = value;
                    });
                  },
                ),
                const SizedBox(height: 8),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: handleSubmit,
                    child: const Text('Login'),
                  ),
                ),
                const SizedBox(height: 8),
                GestureDetector(
                  onTap: navigateToRegister,
                  child: Text.rich(
                    TextSpan(
                      text: "Don't have an account yet? ",
                      children: [
                        TextSpan(
                          text: 'Create an account',
                          style: textTheme.bodyMedium
                              ?.copyWith(color: Colors.deepOrange),
                        ),
                        const TextSpan(text: '.'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
