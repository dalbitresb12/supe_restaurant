import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supe_restaurants/pages/auth/login_form.dart';
import 'package:supe_restaurants/utils/supe_client.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  late SupeClient client;

  String firstName = '';
  String lastName = '';
  String username = '';
  String password = '';

  void navigateToLogin() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const LoginForm(),
      ),
    );
  }

  Future<bool> handleSubmit() async {
    try {
      await client.register(
        username: username,
        firstName: firstName,
        lastName: lastName,
        password: password,
      );
      if (!mounted) return true;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginForm(),
        ),
      );
    } catch (error) {
      String message = 'An unknown error has ocurred';
      final snackBar = SnackBar(content: Text(message));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
    return false;
  }

  @override
  void initState() {
    client = context.read<SupeClient>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

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
                    'Sign up',
                    style: textTheme.titleMedium,
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'First name',
                  ),
                  onChanged: (value) {
                    setState(() {
                      firstName = value;
                    });
                  },
                ),
                const SizedBox(height: 16),
                TextField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Last name',
                  ),
                  onChanged: (value) {
                    setState(() {
                      lastName = value;
                    });
                  },
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
                    child: const Text('Register'),
                  ),
                ),
                const SizedBox(height: 8),
                GestureDetector(
                  onTap: navigateToLogin,
                  child: Text.rich(
                    TextSpan(
                      text: 'Already have an account? ',
                      children: [
                        TextSpan(
                          text: 'Login instead',
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
