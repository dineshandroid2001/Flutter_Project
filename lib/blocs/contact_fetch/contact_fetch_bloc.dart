import 'package:bloc/bloc.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:chat_box/data/models/contact_model.dart';
import 'package:chat_box/sqflite/sqlite.dart';
import 'contact_fetch_event.dart';
import 'contact_fetch_state.dart';


class ContactsBloc extends Bloc<ContactsEvent, ContactsState> {
  ContactsBloc() : super(ContactsInitialState()) {
    on<FetchContactsEvent>((event, emit) async {
      emit(ContactsLoadingState());
      
      try {
        if (await Permission.contacts.isGranted) {
          List<Contact> fetchedContacts = await ContactsService.getContacts();
          DatabaseHelper dbHelper = DatabaseHelper();

          for (Contact contact in fetchedContacts) {
            if (contact.displayName != null) {
              ContactModel contactModel = ContactModel(
                name: contact.displayName!,
                imagePath: contact.avatar,
              );
              await dbHelper.insertContact(contactModel);
            }
          }

          emit(ContactsLoadedState(fetchedContacts));
        } else {
          await Permission.contacts.request();
          emit(ContactsErrorState('Contacts permission denied'));
        }
      } catch (e) {
        emit(ContactsErrorState('Error fetching contacts: ${e.toString()}'));
      }
    });
  }
}
