import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class ActuatorPage extends StatefulWidget {
  const ActuatorPage({super.key});

  @override
  State<ActuatorPage> createState() => _ActuatorPageState();
}

class _ActuatorPageState extends State<ActuatorPage> {
  final DatabaseReference _dbRef = FirebaseDatabase.instance.ref("control_commands");

  bool yellowRelay = false;
  bool redRelay = false;

  @override
  void initState() {
    super.initState();
    _listenRelayStates();
  }

  void _listenRelayStates() {
    _dbRef.onValue.listen((event) {
      final data = event.snapshot.value as Map?;
      if (data != null) {
        setState(() {
          yellowRelay = data["yellow_relay"] == 1;
          redRelay = data["red_relay"] == 1;
        });
      }
    });
  }

  void _updateRelay(String relay, bool state) {
    _dbRef.child(relay).set(state ? 1 : 0);
  }

  Widget relayTile(
      String name, bool state, IconData icon, Color color, Function(bool) onToggle) {
    return Card(
      color: Colors.pink.shade50,
      elevation: 6,
      shadowColor: color.withValues(alpha: 0.4),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Icon(icon, color: color, size: 40),
            const SizedBox(width: 20),
            Expanded(
              child: Text(
                name,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),
            Switch(
              value: state,
              activeColor: color,
              onChanged: onToggle,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink.shade50,
      appBar: AppBar(
        backgroundColor: Colors.pinkAccent,
        title: const Text("Actuator Control"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            relayTile(
              "Yellow Relay",
              yellowRelay,
              Icons.lightbulb,
              Colors.amber,
                  (val) => _updateRelay("yellow_relay", val),
            ),
            relayTile(
              "Red Relay",
              redRelay,
              Icons.power,
              Colors.redAccent,
                  (val) => _updateRelay("red_relay", val),
            ),
          ],
        ),
      ),
    );
  }
}
