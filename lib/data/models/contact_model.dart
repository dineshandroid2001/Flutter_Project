import 'package:flutter/services.dart';

class ContactModel {
  final int? id;
  final String name;
  final Uint8List? imagePath;

  ContactModel({this.id, required this.name,required this.imagePath});

  get avatar => null;
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'imagePath':imagePath,
    };
  }

  factory ContactModel.fromMap(Map<String, dynamic> map) {
    return ContactModel(
      id: map['id'],
      name: map['name'],
      imagePath: map['imagePath'] != null
          ? Uint8List.fromList(map['imagePath'])
          : Uint8List.fromList([]), 
    );
  }
}


