import 'package:chat_box/presentation/app_constant/app_constant.dart';
import 'package:chat_box/presentation/custom_widgets/create_chat/enlarged_chat_image.dart';
import 'package:chat_box/presentation/custom_widgets/custom_text_widget.dart';
import 'package:chat_box/presentation/custom_widgets/personal_chat.dart';
import 'package:chat_box/presentation/custom_widgets/sized_box.dart';
import 'package:flutter/material.dart';


class CreateChat extends StatefulWidget {
  final ImageProvider chatImage;
  final String name;
  const CreateChat({
    super.key,
    required this.chatImage,
    required this.name,
  });

  @override
  State<CreateChat> createState() => _CreateChatState();
}

class _CreateChatState extends State<CreateChat> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => PersonalChat(
                  chatImage: widget.chatImage, name: widget.name))),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 1, vertical: 8),
        leading: GestureDetector(
          onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => EnlargedChatImage(
                      name: widget.name, imagePath: widget.chatImage))),
          child: CircleAvatar(
            radius: 35,
            backgroundImage: widget.chatImage,
          ),
        ),
        title: CustomTextWidget(
            text: widget.name,
            fontSize: 19,
            fontWeight: FontWeight.bold,
            color: AppConstants.secondaryColor),
        subtitle: const CustomTextWidget(
            text: 'Hi welcome', fontSize: 17, color: AppConstants.liteColor),
        trailing: Column(
          children: [
            const Text('2 min ago'),
            SizedBoxWidget(height: 0.01),
            const CircleAvatar(
              radius: 10,
              backgroundColor: AppConstants.warningColor,
              child: Text('3'),
            )
          ],
        ),
      ),
    );
  }
}
