
/// this is custom widget and we can use it and change their properties according to our need

import 'package:getanywheels/consts/paths.dart';

Widget bookingPlacedDetails({title1,title2, d1,d2}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            "$title1".text.fontFamily(semibold).make(),
            "$d1"
                .text
                .color(redColor)
                .fontFamily(semibold)
                .make()
          ],
        ),
        SizedBox(
          width: 130,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              "$title2".text.fontFamily(semibold).make(),
              "$d2"
                  .text
                  .color(redColor)
                  .fontFamily(semibold)
                  .make()
            ],
          ),
        ),
      ],
    ),
  );
}
