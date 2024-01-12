import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:getanywheels/consts/paths.dart';
import 'package:getanywheels/controllers/home_controller.dart';

class ChatsController extends GetxController {
  @override
  void onInit() {
    getChatId();
    super.onInit();
  }

  var chats = firestore.collection(chatsCollection);

  var friendName = Get.arguments[0];
  var friendId = Get.arguments[1];

  var senderName = Get.find<HomeController>().username;
  var currentId = currentUser!.uid;

  var msgController = TextEditingController();

  dynamic chatDocId;

  var isloading = false.obs;

  getChatId() async {
    isloading (true);
    await chats
        .where('users', isEqualTo: {friendId: null, currentId: null})
        .limit(1)
        .get()
        .then((QuerySnapshot snapshot) {
          //agr phly se chat ho rahi h to if
          if (snapshot.docs.isNotEmpty) {
            chatDocId = snapshot.docs.single.id;
          }
          //agr first time chat ho gi to else...
          else {
            chats.add({
              'created_on': null,
              'last_msg': '',
              'users': {friendId: null, currentId: null},
              'toid': '',
              'fromid': '',
              'friend_name': friendName,
              'sender_name': senderName,
            }).then((value) {
              chatDocId = value.id;
            });
          }
        });
        isloading(false);
  }

//message send wala method...
  sendMsg(String msg) async {
    if (msg.trim().isNotEmpty) {
      chats.doc(chatDocId).update({
        'created_on': FieldValue.serverTimestamp(),
        'last_msg': msg,
        'toid': friendId,
        'fromid': currentId,
      });

      //yaha b dono k darmiyan honay walay messages store hon gay ta ka pata chal sakay kis nay mesage kia...
      chats.doc(chatDocId).collection(messagesCollection).doc().set({
        'created_on': FieldValue.serverTimestamp(),
        'msg': msg,
        'uid': currentId,
      });
    }
  }
}
