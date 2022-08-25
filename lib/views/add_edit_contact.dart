import 'package:contact/models/contact_model.dart';
import 'package:contact/view_models/contacts_controller.dart';
import 'package:contact/views/contact_profile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

import '../utils/constants.dart';
import '../utils/widgets/text_field/custom_textfield.dart';

class AddEditContact extends StatelessWidget {
  final bool editContact;
  final ContactModel? contactModel;
  const AddEditContact({Key? key, this.editContact = false,this.contactModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ContactsController contactsController = Get.find();
    TextEditingController firstNameController = TextEditingController();
    TextEditingController lastNameController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    List<TextEditingController> phones = [];

    if (editContact) {
      firstNameController.text = contactModel!.firstName!;
      lastNameController.text = contactModel!.lastName!;
      emailController.text = contactModel!.email!;
      for (var element in contactModel!.phone!) {
        phones.add(TextEditingController(text: element));
      }
    } else {
      phones.add(TextEditingController());
    }

    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        backgroundColor: kPrimaryDark,
        title: Text(editContact ? "Edit contact" : "New contact").text.color(kTextLite).make(),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            Get.back();
          },
        ),
        actions: [
          Align(
            alignment: Alignment.centerRight,
            child: MaterialButton(
              onPressed: () async{
                if(editContact){
                  if(!(firstNameController.text.isNotEmpty || lastNameController.text.isNotEmpty)){
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Please enter name")));
                    return;
                  }
                  if(phones.first.text.isEmpty){
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Please enter phone number")));
                    return;
                  }
                  ContactModel newModel = ContactModel(
                      firstName: firstNameController.text,
                      lastName: lastNameController.text,
                      email: emailController.text,
                      phone: phones.map((e) => e.text).toList(),
                      id: contactModel!.id
                  );
                  await contactsController.updateContact(newModel);
                  Get.back();
                  Get.back();
                  Get.to(ContactProfile(contactModel: newModel));
                }else{
                  if(!(firstNameController.text.isNotEmpty || lastNameController.text.isNotEmpty)){
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Please enter name")));
                    return;
                  }
                  if(phones.first.text.isEmpty){
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Please enter phone number")));
                    return;
                  }
                  await contactsController.addContact(ContactModel(
                      firstName: firstNameController.text,
                      lastName: lastNameController.text,
                      email: emailController.text,
                      phone: phones.map((e) => e.text).toList()
                  ));
                  Get.back();
                }
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              color: kButtonColor,
              child: "Save".text.color(kBlack).make(),
            ),
          ),
          if (editContact)
            IconButton(onPressed: () {
              contactsController.deleteContact(contactModel!);
              Get.back();
              Get.back();
            }, icon: const Icon(Icons.delete_outline)),
          if (!editContact)
            const SizedBox(
              width: 16,
            ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: Column(
          children: [
            CustomTextField(
              controller: firstNameController,
              hintText: "First name",
              iconData: Icons.person_outline_rounded,
            ),
            CustomTextField(
              controller: lastNameController,
              hintText: "Last name",
            ),
            CustomTextField(
              controller: emailController,
              hintText: "Email",
              iconData: Icons.email_outlined,
            ),
            StatefulBuilder(
              builder: (context, setState) {
                return Column(
                  children: List.generate(
                    phones.length,
                    (index) => CustomTextField(
                      controller: phones[index],
                      hintText: "Number ${index + 1}",
                      textInputType: TextInputType.number,
                      iconData: index == 0 ? Icons.local_phone_outlined : null,
                      onChanged: (String v) {
                        if (v.isEmpty) {
                          if (!(index == phones.length - 1)) {
                            phones.removeLast();
                          }
                          setState(() {});
                        } else if (index == phones.length - 1) {
                          phones.add(TextEditingController());
                          setState(() {});
                        }
                      },
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
