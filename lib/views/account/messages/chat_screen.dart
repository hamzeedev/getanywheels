import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:getanywheels/consts/paths.dart';
import 'package:getanywheels/consts/loading_indicator.dart';
import 'package:getanywheels/controllers/chats_controller.dart';
import 'package:getanywheels/services/firestore_services.dart';
import 'package:getanywheels/views/account/messages/components/sender_bubble.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {

    var controller = Get.put(ChatsController());

    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: "${controller.friendName}".text.fontFamily(semibold).color(darkFontGrey).make(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Obx(
              () => controller.isloading.value
                  ? Center(
                      child: loadingIndicator(),
                    )
                  : Expanded(
                      child: StreamBuilder(
                      stream: FirestoreServices.getChatMessages(
                          controller.chatDocId.toString()),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        //if will show loading....
                        if (!snapshot.hasData) {
                          return Center(
                            child: loadingIndicator(),
                          );
                        }
                        //else if
                        else if (snapshot.data!.docs.isEmpty) {
                          return Center(
                            child: "Send a message...."
                                .text
                                .color(darkFontGrey)
                                .make(),
                          );
                        } else {
                          return ListView(
                            children: snapshot.data!.docs
                                .mapIndexed((currentValue, index) {
                              var data = snapshot.data!.docs[index];

                            return 
                            // Align(
                            //   alignment: Alignment.centerRight,
                            //   child: senderBubble(data));
                             Align(
                              alignment: 
                              data['uid'] == currentUser!.uid ? Alignment.centerRight : Alignment.centerLeft,
                              child: senderBubble(data));
                            }).toList(),
                          );
                        }
                      },
                    ),
                  ),
            ),
            10.heightBox,
            Row(
              children: [
                Expanded(
                    child: TextFormField(
                  controller: controller.msgController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: textfieldGrey,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: textfieldGrey,
                        ),
                      ),
                      hintText: "Type a message...."),
                )),
                IconButton(
                    onPressed: () {
                      controller.sendMsg(controller.msgController.text);
                      controller.msgController.clear();
                    },
                    icon: const Icon(
                      Icons.send,
                      size: 40.0,
                      color: myOrange,
                    ))
              ],
            )
                .box
                .height(80)
                .padding(const EdgeInsets.all(12))
                .margin(const EdgeInsets.only(bottom: 12))
                .make(),
          ],
        ),
      ),
    );
  }
}
