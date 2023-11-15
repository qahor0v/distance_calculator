// ignore_for_file: non_constant_identifier_names

import 'package:distance_calculator/models/coordinates.dart';
import 'package:distance_calculator/models/result_model.dart';
import 'package:distance_calculator/services/api_services.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Distance? distance;
  TextEditingController startLon = TextEditingController();
  TextEditingController startLat = TextEditingController();
  TextEditingController endLon = TextEditingController();
  TextEditingController endLat = TextEditingController();

  Widget HBox(double height) => SizedBox(height: height);

  void calculate() async {
    Coordinates coordinates = Coordinates(
      startLatitude: startLat.text.trim(),
      startLongitude: startLon.text.trim(),
      endLatitude: endLat.text.trim(),
      endLongitude: endLon.text.trim(),
    );

    final result = await ApiServices.calculate(coordinates);
    if (result != null) {
      setState(() {
        distance = result;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: const Text(
          "Distance Calculator",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 40, right: 40),
          child: Column(
            children: [
              HBox(8),
              AppTextField(controller: startLon, text: "Start longitude"),
              HBox(8),
              AppTextField(controller: startLat, text: "Start latitude"),
              HBox(16),
              AppTextField(controller: endLon, text: "End longitude"),
              HBox(8),
              AppTextField(controller: endLat, text: "End latitude"),
              HBox(24),
              ElevatedButton.icon(
                onPressed: calculate,
                icon: const Icon(Icons.calculate_outlined),
                label: const Text("Calculate Distance"),
              ),
              HBox(24),
              if (distance != null)
                Text(
                  "${distance!.meters} m",
                  style: const TextStyle(color: Colors.black, fontSize: 20),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class AppTextField extends StatelessWidget {
  final TextEditingController controller;
  final String text;

  const AppTextField({
    super.key,
    required this.controller,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: TextInputType.number,
      controller: controller,
      decoration: InputDecoration(
        hintText: text,
      ),
    );
  }
}
