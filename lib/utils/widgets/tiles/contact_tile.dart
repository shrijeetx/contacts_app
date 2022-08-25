import 'dart:math';

import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../constants.dart';

class ContactTile extends StatelessWidget {
  final String name;
  final VoidCallback onTap;
  const ContactTile({Key? key,required this.name,required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 14),
        child: Row(
          children: [
            CircleAvatar(
              radius: 24,
              backgroundColor: Colors.primaries[Random().nextInt(Colors.primaries.length)],
              child: name.characters.first.text.uppercase.color(kTextLite).size(20).make(),
            ),
            const SizedBox(width: 16,),
            Expanded(
              child: name.text.color(kTextLite).size(16).maxLines(1).overflow(TextOverflow.ellipsis).make(),
            )
          ],
        ),
      ),
    );
  }
}
