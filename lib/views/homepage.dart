import 'package:contact/utils/constants.dart';
import 'package:contact/view_models/contacts_controller.dart';
import 'package:contact/views/contact_profile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

import '../utils/widgets/tiles/contact_tile.dart';
import 'add_edit_contact.dart';

//List of contacts
class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: kPrimaryDark,
          title: "Contacts".text.color(kTextLite).make(),
      ),
      body: GetX<ContactsController>(
        builder: (controller) {
          return ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            itemCount: controller.contacts.length,
            itemBuilder: (context, index) {
              return ContactTile(
                name: "${controller.contacts[index].firstName!} ${controller.contacts[index].lastName!}",
                onTap: (){
                  Get.to(ContactProfile(
                    contactModel: controller.contacts[index],
                  ));
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: kBlue,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        onPressed: () {
          Get.to(const AddEditContact());
        },
        child: const Icon(Icons.add,color: kTextLite,),
      ),
    );
  }
}
