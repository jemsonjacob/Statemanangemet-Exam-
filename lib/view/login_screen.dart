// Login Auth Flow

// Login screen with form validation, simulated async auth (2s
// delay), loading spinner, error state, and success navigation

import 'package:examapp/controller/login_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  void dispose() {
    _passwordController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  String? _validateEmail(String? email) {
    if (email == null || email.isEmpty) {
      return '''Enter your email ''';
    }
    String emailPattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    if (!RegExp(emailPattern).hasMatch(email)) {
      return 'Enter a valid email id';
    }
    return null;
  }

  String? _validatePassword(String? pwd) {
    if (pwd == null || pwd.isEmpty || pwd.length <= 5) {
      return '''Enter your password ''';
    }
    return null;
  }

  Future<void> _handleLogin() async {
    if (_formKey.currentState!.validate()) {
      //provider login ()
      try {
        context.read<LoginProvider>().login(
          _emailController.text.trim(),
          _passwordController.text.trim(),
        );
      } catch (e) {
        print(e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login")),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Login",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              TextFormField(
                validator: (value) => _validateEmail(_emailController.text),
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hint: Text("Email"),
                ),
                controller: _emailController,
              ),
              const SizedBox(height: 10),

              TextFormField(
                validator: (value) =>
                    _validatePassword(_passwordController.text),
                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hint: Text("Password"),
                ),
                controller: _passwordController,
              ),
              const SizedBox(height: 10),

              SizedBox(
                width: double.infinity,
                child: Consumer<LoginProvider>(
                  builder: (context, loginprovider, child) => ElevatedButton(
                    onPressed: _handleLogin,

                    child: loginprovider.isLogin
                        ? Text("Login")
                        : CircularProgressIndicator(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
