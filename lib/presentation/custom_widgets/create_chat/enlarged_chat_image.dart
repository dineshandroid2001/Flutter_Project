import 'package:chat_box/presentation/custom_widgets/sized_box.dart';
import 'package:flutter/material.dart';

class EnlargedChatImage extends StatelessWidget {
  final ImageProvider imagePath;
  final String name;

  const EnlargedChatImage({super.key, required this.imagePath, required this.name});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(name),
      ),
      body: Center(
        child: SizedBoxWidget(
          width: 0.9,
          height: 0.9,
          child: Image(image: imagePath),
        ),
      ),
    );
  }
}
