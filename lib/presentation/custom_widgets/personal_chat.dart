// ignore_for_file: deprecated_member_use

import 'package:chat_box/presentation/app_constant/app_constant.dart';
import 'package:chat_box/presentation/custom_widgets/attach_file.dart';
import 'package:chat_box/presentation/custom_widgets/container_widget.dart';
import 'package:chat_box/presentation/custom_widgets/personal_text.dart';
import 'package:chat_box/presentation/custom_widgets/sized_box.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';
import 'custom_text_widget.dart';

class PersonalChat extends StatefulWidget {
  final ImageProvider chatImage;
  final String name;

  const PersonalChat({super.key, required this.chatImage, required this.name});

  @override
  State<PersonalChat> createState() => _PersonalChatState();
}

class _PersonalChatState extends State<PersonalChat> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.primaryColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          SizedBoxWidget(height: 0.05),
          ListTile(
            leading: Stack(
              children: [
                CircleAvatar(
                  radius: 33,
                  backgroundImage: widget.chatImage,
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppConstants.primaryColor,
                    ),
                    child: const Icon(
                      Icons.circle,
                      color: AppConstants.liteColor,
                      size: 15,
                    ),
                  ),
                ),
              ],
            ),
            title:CustomTextWidget(
                    text: widget.name,
                    fontSize: 18,
                    color: AppConstants.secondaryColor,
                    fontWeight: FontWeight.bold),
            subtitle: const CustomTextWidget(
                    text: 'Active now',
                    fontSize: 16,
                    color: AppConstants.liteColor),
            trailing: const Icon(Icons.call,size: 30,)
          ),
          const PersonalText(text: 'hey buddy'),
          const PersonalText(text: 'how are you ?'),
          const Spacer(),
          BottomAppBar(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  IconButton(
                    onPressed: _openAttachFileOptions,
                    icon: const Icon(Icons.attach_file),
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            //color: Colors.green,
                            width: 1,
                          ),
                          color: Colors.grey[400]),
                      child: const TextField(
                        decoration: InputDecoration(
                          hintText: ' Write your message',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.insert_emoticon),
                  ),
                  IconButton(
                    onPressed: pickImageCamera,
                    icon: const Icon(Icons.camera_alt),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.mic),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  void _openAttachFileOptions() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return ContainerWidget(
          topLeftValue: 40,
          topRightValue: 40,
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(9.0),
                child: CustomTextWidget(
                    text: 'Share Content',
                    fontSize: 23,
                    color: AppConstants.secondaryColor),
              ),
              AttachFile(
                icon: const Icon(Icons.camera_alt),
                title: 'Camera',
                subTitle: 'Capture a picture',
                onPressed: pickImageCamera,
              ),
              const AttachFile(
                icon: Icon(Icons.document_scanner),
                title: 'Documents',
                subTitle: 'Share your file',
              ),
              const AttachFile(
                icon: Icon(Icons.browse_gallery),
                title: 'Media',
                subTitle: 'Share photos and videos',
              ),
              AttachFile(
                icon: const Icon(Icons.contact_phone),
                title: 'Contact',
                subTitle: 'Share your contacts',
                onPressed: opencontacts,
              ),
              AttachFile(
                icon: const Icon(Icons.location_on),
                title: 'Location',
                subTitle: 'Share your location',
                onPressed: _openGoogleMaps,
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> pickImageCamera() async {
    await ImagePicker().pickImage(source: ImageSource.camera);
  }

  void _openGoogleMaps() async {
    double latitude = 37.422;
    double longitude = -122.084;
    String googleMapsUrl =
        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    if (await canLaunch(googleMapsUrl)) {
      await launch(googleMapsUrl);
    }
  }

  void opencontacts() {
    launch('content://contacts');
  }
}
