import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:getanywheels/consts/paths.dart';

class AuthController extends GetxController {

  var isloading = false.obs;

  //textControllers
  var emailController = TextEditingController();
  var passwordController = TextEditingController();



  //login method....
  Future<UserCredential?> loginMethod({context}) async {
    UserCredential? userCredential;

    try {
      userCredential = await auth.signInWithEmailAndPassword(email: emailController.text, password: passwordController.text);
    } on FirebaseAuthException catch (e) {
      VxToast.show(context, msg: e.toString());
    }
    return userCredential;
  }

  //signup method....
  Future<UserCredential?> signupMethod({email, password, context}) async {
    UserCredential? userCredential;

    try {
      userCredential = await auth.createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      VxToast.show(context, msg: e.toString());
    }
    return userCredential;
  }

  //storing data method....
  storeUserData({name, password, email}) async {
    DocumentReference store = firestore.collection(usersCollection).doc(currentUser!.uid);
    store.set( {
      'name': name, 
      'password': password, 
      'email': email, 
      'imageUrl': '',
      'id': currentUser!.uid,
      'favourite_count':  "00",
      'booking_count':    "00",
      'previous_booking': "00",
      

      });
  }

  //signout methods....
  signoutMethod (context) async{
    try {
      await auth.signOut();
    } catch (e) {
      VxToast.show(context, msg: e.toString());
    }
  }
}
