import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class SensorDataPage extends StatefulWidget {
  const SensorDataPage({super.key});

  @override
  State<SensorDataPage> createState() => _SensorDataPageState();
}

class _SensorDataPageState extends State<SensorDataPage> {
  final ref = FirebaseDatabase.instance.ref("sensor_data");

  Map data = {
    "ultrasonic_detect": "No",
    "humidity": 0,
    "ldr_percent": 0,
    "relay_yellow": 0,
    "relay_red": 0,
    "distance_cm": 0,
  };

  @override
  void initState() {
    super.initState();
    ref.onValue.listen((event) {
      if (event.snapshot.exists) {
        setState(() {
          data = Map<String, dynamic>.from(event.snapshot.value as Map);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[100],
      appBar: AppBar(
        title: const Text("Sensor Monitoring"),
        backgroundColor: Colors.pink,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            _itemTile("Motion Detect", data["ultrasonic_detect"].toString()),
            _itemTile("Distance (cm)", data["distance_cm"].toString()),
            _itemTile("Humidity (%)", data["humidity"].toString()),
            _itemTile("Light (%)", data["ldr_percent"].toString()),
            _itemTile("Yellow Relay", data["relay_yellow"] == 1 ? "ON" : "OFF"),
            _itemTile("Red Relay", data["relay_red"] == 1 ? "ON" : "OFF"),
          ],
        ),
      ),
    );
  }

  Widget _itemTile(String title, String value) {
    return Card(
      color: Colors.pink[50],
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        trailing: Text(
          value,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
