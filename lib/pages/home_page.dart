// ignore_for_file: non_constant_identifier_names

import 'package:distance_calculator/models/coordinates.dart';
import 'package:distance_calculator/models/message_model.dart';
import 'package:distance_calculator/models/result_model.dart';
import 'package:distance_calculator/services/api_services.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  MessageModel? messageModel;

  TextEditingController title = TextEditingController();
  TextEditingController body = TextEditingController();
  TextEditingController userId = TextEditingController();

  Widget HBox(double height) => SizedBox(height: height);

  void postMessage() async {
    MessageModel message = MessageModel(
      body: body.text.trim(),
      title: title.text.trim(),
      userId: int.parse(userId.text.trim()),
    );
    final apiMessage = await ApiServices.postMessage(message);
    if (apiMessage != null) {
      setState(() {
        messageModel = apiMessage;
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
              AppTextField(controller: title, text: "Message title"),
              HBox(8),
              AppTextField(controller: body, text: "Message body"),
              HBox(16),
              AppTextField(controller: userId, text: "User Id"),
              HBox(24),
              ElevatedButton.icon(
                onPressed: postMessage,
                icon: const Icon(Icons.calculate_outlined),
                label: const Text("Post"),
              ),
              HBox(24),
              if (messageModel != null)
                Text(
                  "${messageModel!.id}",
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
