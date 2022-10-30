import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:learn_flutter/screens/login-screen.dart';
import 'package:learn_flutter/services/auth-service.dart';
import 'package:learn_flutter/utils/showSnackBar.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late User user;

  void logout() async {
    await context.read<AuthService>().logOut(context);
  }

  @override
  void initState() {
    user = context.read<AuthService>().user;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        actions: [
          Text(user.email as String),
          IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                          title: const Text("Log out"),
                          content:
                              const Text("Are you sure you want to log out?"),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text("No")),
                            TextButton(
                                onPressed: () {
                                  logout();
                                  Navigator.of(context).pop();
                                },
                                child: const Text("Yes"))
                          ],
                        ));
              },
              icon: const Icon(Icons.logout))
        ],
      ),
    );
  }
}
