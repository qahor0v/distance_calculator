// ignore_for_file: non_constant_identifier_names, use_build_context_synchronously
import 'package:distance_calculator/models/message_model.dart';
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

  void deleteMessage(int id) async {
    final status = await ApiServices.deleteMessage(id);
    if (status) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("$id o'chirildi!"),
          backgroundColor: Colors.blue,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Xatolik! Message o'chirilmadi!"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: const Text(
          "Messages",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: FutureBuilder(
        future: ApiServices.getAllMessages(),
        builder: (context, diyor) {
          if (diyor.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (diyor.hasError) {
            return Text(
              diyor.error.toString(),
              style: const TextStyle(
                color: Colors.black,
              ),
            );
          } else {
            return ListView.builder(
              itemCount: diyor.data!.length,
              itemBuilder: (context, index) {
                final message = diyor.data![index];
                return ListTile(
                  leading: const Icon(
                    Icons.message,
                    color: Colors.black,
                  ),
                  title: Text(
                    message.title,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 1,
                  ),
                  subtitle: Text(
                    message.body,
                    style: const TextStyle(
                      color: Colors.black54,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                    maxLines: 2,
                  ),
                  trailing: GestureDetector(
                    onTap: () async {
                      deleteMessage(message.id!);
                    },
                    child: const Icon(
                      Icons.delete,
                      color: Colors.black,
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}

/*
 SingleChildScrollView(
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
* */

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

class PutPage extends StatefulWidget {
  const PutPage({super.key});

  @override
  State<PutPage> createState() => _PutPageState();
}

class _PutPageState extends State<PutPage> {
  MessageModel? messageModel;
  TextEditingController title = TextEditingController();
  TextEditingController body = TextEditingController();
  TextEditingController userId = TextEditingController();
  TextEditingController id = TextEditingController();

  Widget HBox(double height) => SizedBox(height: height);

  void putMessage() async {
    MessageModel message = MessageModel(
      body: body.text.trim(),
      id: int.parse(id.text.trim()),
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
              AppTextField(controller: id, text: "Message Id"),
              HBox(8),
              AppTextField(controller: userId, text: "User Id"),
              HBox(24),
              ElevatedButton.icon(
                onPressed: putMessage,
                icon: const Icon(Icons.calculate_outlined),
                label: const Text("Post"),
              ),
              HBox(24),
              if (messageModel != null)
                Text(
                  "${messageModel!.id}\n${messageModel!.userId}\n${messageModel!.body}\n${messageModel!.title}",
                  style: const TextStyle(color: Colors.black, fontSize: 20),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
