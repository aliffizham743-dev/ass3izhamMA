import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool loading = false;

  Future<void> signUp() async {
    setState(() => loading = true);
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Sign Up Successful!")),
      );
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message ?? "Error signing up")),
      );
    } finally {
      setState(() => loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[50],
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Create Account",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.pink[800],
                ),
              ),
              const SizedBox(height: 30),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: "Email",
                  prefixIcon: const Icon(Icons.email),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: "Password",
                  prefixIcon: const Icon(Icons.lock),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none),
                ),
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: loading ? null : signUp,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pinkAccent,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                  child: loading
                      ? const CircularProgressIndicator(
                    color: Colors.white,
                  )
                      : const Text(
                    "Sign Up",
                    style: TextStyle(fontSize: 18),
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
