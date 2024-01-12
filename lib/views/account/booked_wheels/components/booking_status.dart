/// this is custom widget and we can use it and change their properties according to our need

import 'package:getanywheels/consts/paths.dart';

Widget bookingStatus({icon, color, title, showDone}) {
  return ListTile(
    leading: Icon(
      icon,
      color: color,
    ).box.border(color: color).roundedSM.padding(const EdgeInsets.all(4)).make(),
    trailing: SizedBox(
      height: 100,
      width: 140,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          "$title".text.color(darkFontGrey).make(),
          showDone
              ? const Icon(
                  Icons.done,
                  color: redColor,
                )
              : Container(),
        ],
      ),
    ),
  );
}
