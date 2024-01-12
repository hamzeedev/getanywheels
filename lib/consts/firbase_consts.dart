import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

FirebaseAuth auth = FirebaseAuth.instance;
FirebaseFirestore firestore = FirebaseFirestore.instance;
User? currentUser = auth.currentUser;

//collection ..... users wali collection es ka faida ye hai k jb hum change krna chahin es ki yahin se change krin gy or har jgha change ho jaya ga
const usersCollection     = 'users';
const wheelsCollection    = "wheels";
const favouriteCollection = 'favourite';
const chatsCollection     = 'chats';
const messagesCollection  = 'messages';
const bookingCollection   = 'booking';
const wishlistCollection  = 'wheels';