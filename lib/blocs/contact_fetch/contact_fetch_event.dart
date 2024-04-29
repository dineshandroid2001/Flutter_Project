import 'package:equatable/equatable.dart';

abstract class ContactsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchContactsEvent extends ContactsEvent {}
