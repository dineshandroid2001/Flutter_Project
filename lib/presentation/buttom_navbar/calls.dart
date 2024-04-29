// ignore_for_file: deprecated_member_use

import 'dart:typed_data';
import 'package:call_log/call_log.dart';
import 'package:chat_box/presentation/app_constant/app_constant.dart';
import 'package:chat_box/presentation/custom_widgets/buttons/custom_icon_button.dart';
import 'package:chat_box/presentation/custom_widgets/container_widget.dart';
import 'package:chat_box/presentation/custom_widgets/sized_box.dart';
import 'package:chat_box/sqflite/sqlite.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:chat_box/data/models/contact_model.dart';
import 'package:chat_box/presentation/custom_widgets/custom_app_bar.dart';
import 'package:chat_box/presentation/custom_widgets/custom_text_widget.dart';

class CallsNav extends StatefulWidget {
  const CallsNav({super.key});

  @override
  State<CallsNav> createState() => _CallsNavState();
}

class _CallsNavState extends State<CallsNav> {
  List<ContactModel> contactNames = [];
  List<CallLogEntry> _callLogs = [];
  DatabaseHelper dbHelper = DatabaseHelper();
  @override
  void initState() {
    super.initState();
    fetchContactFromDatabase();
    fetchCallLogs();
  }

  Future<void> fetchContactFromDatabase() async {
    List<ContactModel> contacts = await dbHelper.getContacts();
    setState(() {
      contactNames = contacts;
    });
  }

  Future<void> fetchCallLogs() async {
    Iterable<CallLogEntry> callLogs = await CallLog.get();
    setState(() {
      _callLogs = callLogs.toList();
    });
  }

  Uint8List? findContactImageByName(String name) {
    for (ContactModel contact in contactNames) {
      if (contact.name == name) {
        return contact.imagePath;
      }
    }
    return null;
  }

  Widget getContactImage(Uint8List? avatar) {
    if (avatar != null && avatar.isNotEmpty) {
      try {
        return Image.memory(avatar);
      } catch (e) {
        return const Icon(Icons.person, size: 55);
      }
    } else {
      return const Icon(Icons.person, size: 55);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Calls', icon: const Icon(Icons.call)),
      body: Padding(
          padding: const EdgeInsets.only(top: 8),
          child: ContainerWidget(
            topLeftValue: AppConstants.decorationValue,
            topRightValue: AppConstants.decorationValue,
            child: _callLogs.isEmpty
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : ListView.builder(
                    itemCount: _callLogs.length + 1,
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        return const Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: CustomTextWidget(
                              text: 'Recents',
                              fontSize: 22,
                              color: AppConstants.secondaryColor,
                              fontWeight: FontWeight.bold),
                        );
                      } else {
                        final callLogs = _callLogs[index - 1];
                        final calltype = callLogs.callType;
                        final icon = calltype == CallType.outgoing
                            ? Icons.call_made
                            : Icons.call_received;
                        final dateTime = DateTime.fromMillisecondsSinceEpoch(
                            callLogs.timestamp!);
                        final formattedDate =
                            DateFormat('dd/MM/yyyy').format(dateTime);
                        final formattedTime = DateFormat.jm().format(dateTime);
                        final Uint8List? contactImage =
                            findContactImageByName(callLogs.name ?? '');
                        final Widget contactImageWidget =
                            getContactImage(contactImage);
                        final name = callLogs.name;
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: ListTile(
                            leading: ClipRRect(
                                borderRadius: BorderRadius.circular(60),
                                child: contactImageWidget),
                            title: Text(
                              //name ?? 'Unknown',style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                              name!.isNotEmpty ? name : 'Unknown',style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                            subtitle: Row(
                              children: [
                                Icon(
                                  icon,
                                ),
                                SizedBoxWidget(width: 0.02),
                                CustomTextWidget(
                                  text: formattedDate,
                                  fontSize: 15,
                                  color: AppConstants.secondaryColor,
                                ),
                                CustomTextWidget(
                                  text: ', $formattedTime',
                                  fontSize: 15,
                                  color: AppConstants.secondaryColor,
                                )
                              ],
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                CustomIconButton(
                                    onPressed: () {
                                      launch('tel:${callLogs.number}');
                                    },
                                    icon: const Icon(Icons.call_outlined)),
                                const CustomIconButton(icon: Icon(Icons.video_call_outlined,color: AppConstants.liteColor,))
                              ],
                            ),
                          ),
                        );
                      }
                    },
                  ),
          )),
    );
  }
}
