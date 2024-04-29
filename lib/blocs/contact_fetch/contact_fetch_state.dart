import 'package:equatable/equatable.dart';
import 'package:contacts_service/contacts_service.dart';

abstract class ContactsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ContactsInitialState extends ContactsState {}

class ContactsLoadingState extends ContactsState {}

class ContactsLoadedState extends ContactsState {
  final List<Contact> contacts;

  ContactsLoadedState(this.contacts);

  @override
  List<Object?> get props => [contacts];
}

class ContactsErrorState extends ContactsState {
  final String message;

  ContactsErrorState(this.message);

  @override
  List<Object?> get props => [message];
}
