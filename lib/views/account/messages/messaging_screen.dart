import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:getanywheels/consts/loading_indicator.dart';
import 'package:getanywheels/services/firestore_services.dart';
import 'package:getanywheels/views/account/messages/chat_screen.dart';

import '../../../consts/paths.dart';

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: lightGrey,
        appBar: AppBar(
          title: "My Messages"
              .text
              .color(darkFontGrey)
              .fontFamily(semibold)
              .make(),
        ),
        body: StreamBuilder(
            //in below line we have called the method getWishlist created in firestore_services file
            stream: FirestoreServices.getAllMessages(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: loadingIndicator(),
                );
              } else if (snapshot.data!.docs.isEmpty) {
                return "No Messages yet!"
                    .text
                    .color(darkFontGrey)
                    .makeCentered();
              } else {
                var data = snapshot.data!.docs;
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Expanded(
                          child: ListView.builder(
                              itemCount: data.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Card(
                                  child: ListTile(
                                    onTap: () {
                                      Get.to(()=> const ChatScreen(),
                                      arguments: [
                                        data[index]['friend_name'],
                                        data[index]['toid'],
                                      ]
                                      );
                                    },
                                    leading: const CircleAvatar(
                                      backgroundColor: myOrange,
                                      child: Icon(
                                        Icons.person,
                                        color: whiteColor,
                                      ),
                                    ),
                                    title: "${data[index]['friend_name']}"
                                        .text
                                        .fontFamily(semibold)
                                        .color(darkFontGrey)
                                        .make(),
                                    subtitle: "${data[index]['last_msg']}"
                                        .text
                                        .make(),
                                  ),
                                );
                              }))
                    ],
                  ),
                );
              }
            }));
  }
}
