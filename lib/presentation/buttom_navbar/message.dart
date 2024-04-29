import 'package:chat_box/presentation/app_constant/app_constant.dart';
import 'package:chat_box/presentation/custom_widgets/add_story/add_story.dart';
import 'package:chat_box/presentation/custom_widgets/container_widget.dart';
import 'package:chat_box/presentation/custom_widgets/create_chat/create_chat.dart';
import 'package:chat_box/presentation/custom_widgets/custom_app_bar.dart';
import 'package:chat_box/presentation/custom_widgets/icon_border.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chat_box/blocs/contact_fetch/contact_fetch_bloc.dart';
import 'package:chat_box/blocs/contact_fetch/contact_fetch_event.dart';
import 'package:chat_box/blocs/contact_fetch/contact_fetch_state.dart';
import 'package:chat_box/presentation/custom_widgets/sized_box.dart';

class MessageNav extends StatelessWidget {
  const MessageNav({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        ContactsBloc contactsBloc = ContactsBloc();
        contactsBloc.add(FetchContactsEvent());
        return contactsBloc;
      },
      child: const MessageNavView(),
    );
  }
}

class MessageNavView extends StatelessWidget {
  const MessageNavView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
            title: 'Home', icon: const Icon(Icons.call), homeImage: true),
        body: BlocBuilder<ContactsBloc, ContactsState>(
          builder: (context, state) {
            if (state is ContactsLoadingState) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ContactsLoadedState) {
              List<Contact> contacts = state.contacts;
              return Column(
                children: [
                  SizedBoxWidget(height: 0.01),
                  SizedBoxWidget(
                    height: 0.15,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: contacts.length,
                      itemBuilder: (context, index) {
                        final contact = contacts[index];
                        ImageProvider? contactImage;
                        if (contact.avatar != null &&
                            contact.avatar!.isNotEmpty) {
                          contactImage = MemoryImage(contact.avatar!);
                        } else {
                          contactImage = null;
                        }
                        return Padding(
                          padding: EdgeInsets.only(
                              right: MediaQuery.of(context).size.width * 0.018),
                          child: AddStory(
                              imagesPath: contactImage ??
                                  const AssetImage(AppConstants.noProfile),
                              name: contacts[index].displayName!),
                        );
                      },
                    ),
                  ),
                  Expanded(
                      child: ContainerWidget(
                    topLeftValue: AppConstants.decorationValue,
                    topRightValue: AppConstants.decorationValue,
                    child: contacts.isEmpty
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : ListView.builder(
                            itemCount: contacts.length,
                            itemBuilder: (context, index) {
                              final contact = contacts[index];
                              ImageProvider? contactImage;
                              if (contact.avatar != null &&
                                  contact.avatar!.isNotEmpty) {
                                contactImage = MemoryImage(contact.avatar!);
                              } else {
                                contactImage = null;
                              }
                              return Dismissible(
                                key: Key(contact.displayName!),
                                direction: DismissDirection.endToStart,
                                background: Container(
                                  color: AppConstants.dividerColor,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      const IconBorder(
                                        icon: Icon(Icons.delete_outline),
                                        colors: AppConstants.warningColor,
                                      ),
                                      SizedBoxWidget(width: 0.03),
                                      const IconBorder(
                                        icon:
                                            Icon(Icons.notifications_outlined),
                                        colors: Colors.black,
                                      )
                                    ],
                                  ),
                                ),
                                child: ListTile(
                                  title: CreateChat(
                                    chatImage: contactImage ??
                                        const AssetImage(
                                            AppConstants.noProfile),
                                    name: contact.displayName!,
                                  ),
                                ),
                              );
                            },
                          ),
                  ))
                ],
              );
            } else if (state is ContactsErrorState) {
              return Center(child: Text(state.message));
            } else {
              return const Center(child: Text('Unknown state'));
            }
          },
        ));
  }
}

/*
 onDismissed: (direction) {
                            setState(() {
                              dismissedContacts.add(contacts[index]);
                              contacts.removeAt(index);
                            });
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: const Text(
                                  'Contact dismissed',
                                  textAlign: TextAlign.center,
                                ),
                                action: SnackBarAction(
                                  label: 'Undo',
                                  onPressed: () {
                                    setState(() {
                                      contacts.insert(index, dismissedContacts.last);
                                      dismissedContacts.removeLast();
                                    });
                                  },
                                ),
                              ),
                            );
                          },
 */
