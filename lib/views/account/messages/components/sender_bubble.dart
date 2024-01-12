import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:getanywheels/consts/paths.dart';
import 'package:intl/intl.dart' as intl;

Widget senderBubble(DocumentSnapshot data) {
  var t =
      data['created_on'] == null ? DateTime.now() : data['created_on'].toDate();
  var time = intl.DateFormat("h:mma").format(t);

  return Directionality(
    // textDirection: TextDirection.rtl,
    //below line will change chat dirction of sender and receiver...
    textDirection:
        data['uid'] == currentUser!.uid ? TextDirection.rtl : TextDirection.ltr,
    child: Container(
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        //below line will change chat color of sender and receiver...
        color: data['uid'] == currentUser!.uid ? myOrange : darkFontGrey,
        // color: redColor,
        borderRadius: data['uid'] == currentUser!.uid
            ? const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
                bottomLeft: Radius.circular(20),
              )
            : const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //line to show message
          "${data['msg']}".text.white.size(16).make(),
          10.heightBox,
          //line to show time of message...
          time.text.color(whiteColor.withOpacity(0.5)).make(),
        ],
      ),
    ),
  );
}
