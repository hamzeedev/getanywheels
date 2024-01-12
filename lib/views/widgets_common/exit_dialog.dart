import 'package:flutter/services.dart';
import 'package:getanywheels/consts/paths.dart';
import 'package:getanywheels/views/widgets_common/our_button.dart';

Widget exitDialog(context) {
  return Dialog(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        "Confirm".text.fontFamily(bold).size(18).color(darkFontGrey).make(),
        const Divider(),
        10.heightBox,
        "Are you sure yor want to exit?"
            .text
            .size(16)
            .color(darkFontGrey)
            .make(),
        10.heightBox,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            //YES button....
            ourButton(
                color: redColor,
                onPress: () {
                  SystemNavigator.pop();
                },
                textColor: whiteColor,
                title: "Yes"),
            //NO button .....    
            ourButton(
                color: redColor,
                onPress: () {
                  Navigator.pop(context);
                },
                textColor: whiteColor,
                title: "No"),
          ],
        ),
      ],
    ).box.color(lightGrey).roundedSM.make(),
  );
}
