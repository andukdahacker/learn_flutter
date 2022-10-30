import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:learn_flutter/screens/signup-screen.dart';
import 'package:learn_flutter/services/auth-service.dart';
import 'package:learn_flutter/utils/showSnackBar.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = "/login";
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscureText = true;
  bool _isLoading = false;

  void togglePassword() {
    setState(() {
      if (_obscureText) {
        _obscureText = false;
      } else {
        _obscureText = true;
      }
    });
  }

  void login() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      await context
          .read<AuthService>()
          .signIn(_emailController.text, _passwordController.text, context)
          .then((value) {
        setState(() {
          _isLoading = false;
          Navigator.of(context).pushReplacementNamed("/");
        });
      });
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign In"),
        centerTitle: true,
      ),
      body: Center(
          child: Padding(
        padding: const EdgeInsets.all(30),
        child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                      hintText: "abc@gmail.com", label: Text("Email")),
                  validator: (value) {
                    return RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(value!)
                        ? null
                        : "Please enter a valid email";
                  },
                ),
                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                      label: const Text("Password"),
                      suffixIcon: GestureDetector(
                        onTap: togglePassword,
                        child: const Icon(Icons.remove_red_eye),
                      )),
                  obscureText: _obscureText,
                  validator: (value) {
                    return RegExp(
                                r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
                            .hasMatch(value!)
                        ? null
                        : "Must Contain 8 Characters, One Uppercase, One Lowercase, One Number and one special case Character";
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    onPressed: () {
                      login();
                    },
                    child: _isLoading
                        ? const CircularProgressIndicator()
                        : const Text("Sign in")),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have an account?"),
                    TextButton(
                        onPressed: () {
                          Navigator.of(context)
                              .pushReplacementNamed(SignupScreen.routeName);
                        },
                        child: const Text(
                          "Sign up",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ))
                  ],
                )
              ],
            )),
      )),
    );
  }
}
