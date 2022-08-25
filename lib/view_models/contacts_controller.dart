import 'dart:convert';

import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';

import '../models/contact_model.dart';
import '../services/database/database_helper.dart';

class ContactsController extends GetxController{
  RxList<ContactModel> contacts = <ContactModel>[].obs;
  late Database db;

  @override
  onInit() async{
    super.onInit();
    db = (await DatabaseHelper.instance.database)!;
    await fetchAllContacts();
  }

  Future<void> addContact(ContactModel contactModel) async {
    var value = {
      "firstName": contactModel.firstName,
      "lastName" : contactModel.lastName,
      "email" : contactModel.email,
      "phones" : json.encode(contactModel.phone)
    };
    contactModel.id = await db.insert('contacts', value);
    contacts.add(contactModel);
  }

  Future<void> updateContact(ContactModel contactModel) async {
    var value = {
      "firstName": contactModel.firstName,
      "lastName" : contactModel.lastName,
      "email" : contactModel.email,
      "phones" : json.encode(contactModel.phone)
    };
    await db.update('contacts', value, where: 'id = ?', whereArgs: [contactModel.id]);
    for (var element in contacts) {
      if(element.id == contactModel.id){
        element.phone = contactModel.phone;
        element.firstName = contactModel.firstName;
        element.lastName = contactModel.lastName;
        element.email = contactModel.email;
        continue;
      }
    }
  }

  Future<void> deleteContact(ContactModel contactModel) async {
    await db.delete('contacts', where: 'id = ?', whereArgs: [contactModel.id]);
    contacts.removeWhere((element) => element.id == contactModel.id);
  }

  Future fetchAllContacts() async{
    List<Map<String,dynamic>> map = await db.rawQuery("select * from contacts");
    for (var element in map) {
      contacts.add(ContactModel(
        firstName: element["firstName"],
        lastName: element["lastName"],
        email: element["email"],
        phone: json.decode(element["phones"]),
        id: element["id"]
      ));
    }
  }

}