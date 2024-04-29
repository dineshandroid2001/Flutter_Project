import 'package:chat_box/presentation/app_constant/app_constant.dart';
import 'package:chat_box/presentation/custom_widgets/add_story/enlarged_story.dart';
import 'package:chat_box/presentation/custom_widgets/custom_text_widget.dart';
import 'package:chat_box/presentation/custom_widgets/sized_box.dart';
import 'package:flutter/material.dart';

class AddStory extends StatelessWidget {
  final ImageProvider imagesPath;
  final String name;
  const AddStory({
    super.key,
    required this.imagesPath,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AppConstants.warningColor, width: 2.3)),
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => EnlargedStory(
                            imagePath: imagesPath,
                            name: name,
                          )));
            },
            child: CircleAvatar(
              backgroundImage: imagesPath,
              radius: 35.0,
            ),
          ),
        ),
        SizedBoxWidget(height: 0.01),
        CustomTextWidget(text: name, fontSize: 16),
      ],
    );
  }
}

