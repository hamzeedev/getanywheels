import 'package:flutter/cupertino.dart';
import 'package:getanywheels/consts/paths.dart';

Future popupDialog(context) {
  return showDialog(
      context: context,
      //you can use cupertinoAlertDialog , speceficly for iphone and cant use background color in  it
      builder: (context) {
        return CupertinoAlertDialog(
          title: const Text(
            "Warning !",
            style: TextStyle(color: redColor),
          ),
          content: const Text(
            "You have to pay 1500 Rs as advance booking for security purpose, if you cancel booking before 12 hours there is no return policy of booking fee",
            style: TextStyle(color: darkFontGrey),
          ),
          actions: [
            MaterialButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  "Confirm",
                  style: TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.bold
                    ),
                )),
            MaterialButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  "Cancel",
                  style: TextStyle(
                    color: redColor,
                    fontWeight: FontWeight.bold
                    ),
                )),
          ],
        );
      });
}
