// ignore_for_file: deprecated_member_use

import 'package:chat_box/presentation/app_constant/app_constant.dart';
import 'package:chat_box/presentation/custom_widgets/buttons/custom_icon_button.dart';
import 'package:chat_box/presentation/custom_widgets/container_widget.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:chat_box/blocs/contact_fetch/contact_fetch_bloc.dart';
import 'package:chat_box/blocs/contact_fetch/contact_fetch_event.dart';
import 'package:chat_box/blocs/contact_fetch/contact_fetch_state.dart';
import 'package:chat_box/presentation/custom_widgets/custom_app_bar.dart';
import 'package:chat_box/presentation/custom_widgets/custom_text_widget.dart';

class ContactNav extends StatelessWidget {
  const ContactNav({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        ContactsBloc contactsBloc = ContactsBloc();
        contactsBloc.add(FetchContactsEvent());
        return contactsBloc;
      },
      child: const ContactNavView(),
    );
  }
}

class ContactNavView extends StatelessWidget {
  const ContactNavView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Contacts',
        icon: const Icon(Icons.person),
      ),
      body: BlocBuilder<ContactsBloc, ContactsState>(
        builder: (context, state) {
          if (state is ContactsLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ContactsLoadedState) {
            List<Contact> contacts = state.contacts;
            Map<String, List<Contact>> groupedContacts = {};
            for (var contact in contacts) {
              String firstLetter = contact.displayName![0].toUpperCase();
              groupedContacts[firstLetter] = groupedContacts[firstLetter] ?? [];
              groupedContacts[firstLetter]!.add(contact);
            }
            List<String> sortedKeys = groupedContacts.keys.toList()..sort();
            return Padding(
                padding: const EdgeInsets.only(top: 8),
                child: ContainerWidget(
                  topLeftValue: AppConstants.decorationValue,
                  topRightValue: AppConstants.decorationValue,
                  child: contacts.isEmpty
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : ListView.builder(
                          itemCount: sortedKeys.length + 1,
                          itemBuilder: (context, index) {
                            if (index == 0) {
                              return const Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                child: CustomTextWidget(
                                    text: 'My Contacts',
                                    fontSize: 22,
                                    color: AppConstants.secondaryColor,
                                    fontWeight: FontWeight.bold),
                              );
                            } else {
                              String key = sortedKeys[index - 1];
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 8),
                                    child: CustomTextWidget(
                                        text: key,
                                        fontSize: 20,
                                        color: AppConstants.secondaryColor,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  ListView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: groupedContacts[key]!.length,
                                    itemBuilder: (context, subIndex) {
                                      Contact contact =
                                          groupedContacts[key]![subIndex];
                                      ImageProvider? contactImage;
                                      if (contact.avatar != null &&
                                          contact.avatar!.isNotEmpty) {
                                        contactImage =
                                            MemoryImage(contact.avatar!);
                                      } else {
                                        contactImage = null;
                                      }
                                      return ListTile(
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                horizontal: 16, vertical: 8),
                                        leading: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(60),
                                          child: contactImage != null
                                              ? Image(image: contactImage)
                                              : const Icon(
                                                  Icons.person,
                                                  size: 55,
                                                ),
                                        ),
                                        title: CustomTextWidget(
                                            text: contact.displayName!,
                                            fontSize: 18,
                                            color: AppConstants.secondaryColor,
                                            fontWeight: FontWeight.bold),
                                        subtitle: contact.phones?.isNotEmpty ??
                                                false
                                            ? CustomTextWidget(
                                                text: contact
                                                        .phones!.first.value ??
                                                    '',
                                                fontSize: 16,
                                                color: AppConstants.liteColor)
                                            : const CustomTextWidget(
                                                text: 'No Phone number',
                                                fontSize: 16,
                                                color:
                                                    AppConstants.warningColor),
                                        trailing: CustomIconButton(
                                            onPressed: () {
                                              launch(
                                                  'tel:${contact.phones?.first.value}');
                                            },
                                            icon: const Icon(Icons.call_outlined)),
                                      );
                                    },
                                  ),
                                ],
                              );
                            }
                          },
                        ),
                ));
          } else if (state is ContactsErrorState) {
            return Center(child: Text(state.message));
          } else {
            return const Center(child: Text('Unknown state'));
          }
        },
      ),
    );
  }
}
