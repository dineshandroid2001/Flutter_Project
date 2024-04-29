import 'package:chat_box/presentation/custom_widgets/sized_box.dart';
import 'package:flutter/material.dart';

class EnlargedStory extends StatelessWidget {
  final ImageProvider imagePath;
  final String name;
  const EnlargedStory(
      {super.key, required this.imagePath, required this.name});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
        centerTitle: true,
      ),
      body: Center(
          child: SizedBoxWidget(
        height: 0.9,
        width: 0.9,
        child: Image(image: imagePath),
      )),
    );
  }
}