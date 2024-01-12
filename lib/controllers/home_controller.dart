import 'package:get/state_manager.dart';
import 'package:getanywheels/consts/paths.dart';

class HomeController extends GetxController{
  @override
  void onInit() {
    getUsername();
    super.onInit();
  }

  var currentNavIndex = 0.obs;

//to get detail(name) of user to show in chat with agency..
  var username = '';

  var searchController = TextEditingController();

  //to get detail(name) of user to show in chat with agency..
  getUsername() async{
    var n = await firestore.collection(usersCollection).where('id', isEqualTo: currentUser!.uid).get().then((value) {
      if (value.docs.isNotEmpty) {
        return value.docs.single['name'];
        
      }
    });

    username = n;
  }

}