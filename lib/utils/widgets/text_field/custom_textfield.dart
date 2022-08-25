import 'package:flutter/material.dart';

import '../../constants.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final Function? onChanged;
  final TextInputType textInputType;
  final IconData? iconData;
  const CustomTextField(
      {Key? key,
      required this.controller,
      required this.hintText,
      this.onChanged,
      this.textInputType = TextInputType.text,
      this.iconData,})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          iconData != null ? Icon(iconData,color: kTextLite,) : const Icon(Icons.abc,color: Colors.transparent,),
          const SizedBox(
            width: 16,
          ),
          Expanded(
            child: TextFormField(
              controller: controller,
              keyboardType: textInputType,
              decoration: InputDecoration(
                border: const OutlineInputBorder(
                    borderSide: BorderSide(color: kButtonColor,width: 1.5)),
                focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: kButtonColor,width: 1.5)),
                hintText: hintText,
              ),
              onChanged: (v) {
                if (onChanged != null) onChanged!(v);
              },
            ),
          ),
        ],
      ),
    );
  }
}
