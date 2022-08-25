import 'dart:math';

import 'package:contact/view_models/contacts_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

import '../models/contact_model.dart';
import '../utils/constants.dart';
import 'add_edit_contact.dart';

class ContactProfile extends StatelessWidget {
  final ContactModel contactModel;
  const ContactProfile({Key? key,required this.contactModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ContactsController contactsController = Get.find();
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        backgroundColor: kPrimaryDark,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Get.back();
          },
        ),
        actions: [
          IconButton(onPressed: () {
            Get.to(AddEditContact(
              contactModel: contactModel,
              editContact: true,
            ));
          }, icon: const Icon(Icons.edit_outlined)),
          IconButton(onPressed: () {
            contactsController.deleteContact(contactModel);
            Get.back();
          }, icon: const Icon(Icons.delete_outline)),
        ],
      ),
      body: SizedBox(
        width: double.infinity,
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: Column(
            children: [
              const SizedBox(height: 30,),
              CircleAvatar(
                radius: 56,
                backgroundColor: Colors.primaries[Random().nextInt(Colors.primaries.length)],
                child: "${contactModel.firstName!.isEmpty ? contactModel.lastName : contactModel.firstName}".characters.first.text.uppercase.color(kTextLite).size(40).make(),
              ),
              const SizedBox(height: 30,),
              Text("${contactModel.firstName!} ${contactModel.lastName!}").text.size(30).make(),
              const SizedBox(height: 30,),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 18,horizontal: 18),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  color: kPrimaryLite
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    "Contact info".text.size(16).semiBold.make(),
                    const SizedBox(height: 16,),
                    Column(
                      children: List.generate(contactModel.phone!.length - 1, (index) => ListTile(
                        trailing: InkWell(
                          onTap: ()async{
                            await FlutterPhoneDirectCaller.callNumber(contactModel.phone![index]);
                          },
                          child: const CircleAvatar(
                            radius: 20,
                            backgroundColor: kButtonColor,
                            child: Icon(Icons.local_phone_outlined),
                          ),
                        ),
                        title: contactModel.phone![index].toString().text.size(18).make(),
                      )),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
