import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'sensordata.dart';
import 'actuator.dart';
import 'sign_in.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink.shade50,
      appBar: AppBar(
        title: const Text("Smart IoT Dashboard"),
        centerTitle: true,
        backgroundColor: Colors.pinkAccent,
        elevation: 4,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const SignInPage()),
                    (route) => false,
              );
            },
            tooltip: "Logout",
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const Spacer(flex: 2),
              Center(
                child: Image.network(
                  "https://tse3.mm.bing.net/th/id/OIP.EHhk3KryaA9m6lmZ90947QAAAA?pid=Api&P=0&h=180",
                  height: 220,
                  width: 220,
                  fit: BoxFit.cover,
                ),
              ),
              const Spacer(flex: 1),
              _dashboardBtn(
                context,
                label: "Sensor Data",
                page: const SensorDataPage(),
                color: Colors.pink,
              ),
              const SizedBox(height: 20),
              _dashboardBtn(
                context,
                label: "Actuator Control",
                page: const ActuatorPage(),
                color: Colors.pinkAccent,
              ),
              const Spacer(flex: 3),
            ],
          ),
        ),
      ),
    );
  }

  Widget _dashboardBtn(BuildContext context,
      {required String label, required Widget page, required Color color}) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 18),
          backgroundColor: color,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          shadowColor: color.withValues(alpha: 0.4),
          elevation: 6,
        ),
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => page),
        ),
        child: Text(
          label,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
