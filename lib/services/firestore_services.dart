import 'package:getanywheels/consts/paths.dart';

//get users data...
class FirestoreServices {
  static getUser(uid) {
    return firestore
        .collection(usersCollection)
        .where('id', isEqualTo: uid)
        .snapshots();
  }

  //geting products accourding to categories....
  static getWheels(category) {
    return firestore
        .collection(wheelsCollection)
        .where('w_category', isEqualTo: category)
        .snapshots();
  }

  static getSubCategoryWheels(title){
    return firestore
        .collection(wheelsCollection)
        .where('w_subcategory', isEqualTo: title)
        .snapshots();

  }

  //get favourite
  static getFavourite(uid) {
    return firestore
        .collection(favouriteCollection)
        .where('added_by', isEqualTo: uid)
        .snapshots();
  }

//this fuction will remvoe data from favorite...
  static deleteDocument(docId) {
    return firestore.collection(favouriteCollection).doc(docId).delete();
  }

// get all messages...
  static getChatMessages(docId) {
    return firestore
        .collection(chatsCollection)
        .doc(docId)
        .collection(messagesCollection)
        .orderBy('created_on', descending: false)
        .snapshots();
  }

  //geting all bookings( ORDERS ) by this method
  static getAllBookings() {
    return firestore
        .collection(bookingCollection)
        .where('booking_by', isEqualTo: currentUser!.uid)
        .snapshots();
  }

  //geting all wishlists by this method
  static getWishlist() {
    return firestore
        .collection(wheelsCollection)
        .where('w_wishlist', arrayContains: currentUser!.uid)
        .snapshots();
  }

  //geting all messages by this method
  static getAllMessages() {
    return firestore
        .collection(chatsCollection)
        .where('fromid', isEqualTo: currentUser!.uid)
        .snapshots();
  }

  ///COUNTS that are on profile screen
  static getCounts() async {
    var res = await Future.wait([
      firestore
          .collection(favouriteCollection)
          .where('added_by', isEqualTo: currentUser!.uid)
          .get()
          .then((value) {
        return value.docs.length;
      }),
      firestore
          .collection(wheelsCollection)
          .where('w_wishlist', arrayContains: currentUser!.uid)
          .get()
          .then((value) {
        return value.docs.length;
      }),
      firestore
          .collection(bookingCollection)
          .where('booking_by', isEqualTo: currentUser!.uid)
          .get()
          .then((value) {
        return value.docs.length;
      })
    ]);
    return res;
  }

  ///ALL WHEELS to show on main page....
  static allWheels() {
    return firestore.collection(wheelsCollection).snapshots();
  }

  ///FOR FEATURED WHEELS
  static getFeaturedWheels() {
    return firestore
        .collection(wheelsCollection)
        .where('is_featured', isEqualTo: true)
        .get();
  }

  ///TO GET WHEELS FOR SEARCH.... (wheels = products)
  static searchWheels(title){
    return firestore.collection(wheelsCollection).get();
  }
}
