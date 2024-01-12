import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:getanywheels/consts/paths.dart';
import 'package:getanywheels/models/category_model.dart';

class ProductController extends GetxController {
//give line will help to control days for booking
  var days = 0.obs;
  //given line is for selection color
  var colorIndex = 0.obs;
  //given line will multiply per day value
  var totalPrice = 0.obs;

  var subcat = [];

  var isFav = false.obs;

  getSubCategories(title) async {
    //given line 12 se bar bar sari categories ko add nai kry ga
    subcat.clear();
    var data = await rootBundle.loadString("lib/services/category_model.json");
    var decoded = categoryModelFromJson(data);
    var s =
        decoded.categories.where((element) => element.name == title).toList();

    for (var e in s[0].subcategory) {
      subcat.add(e);
    }
  }

  changeColorIndex(index) {
    colorIndex.value = index;
  }

//to increase the quantity of days
  increaseDays(totalDays) {
    if (days.value < totalDays) {
      days.value++;
    }
  }

  decreaseDays() {
    if (days.value > 0) {
      days.value--;
    }
  }

  calculateTotalPrice(price) {
    totalPrice.value = price * days.value;
  }

  //add to cart as favorite... (will remove this comment)
  //agencyname = sellername (will remove this comment)
  //providorID = vendorID (will remove this comment)
  addFavourite(
      {title,img,agencyname,color,days,wprice,context,agencyID}) async {
    await firestore.collection(favouriteCollection).doc().set({
      'title': title,
      'img': img,
      'agencyname': agencyname,
      'color': color,
      'days': days,
      'agency_id': agencyID,
      'wprice': wprice,
      'added_by': currentUser!.uid,
    }).catchError((error) {
      VxToast.show(context, msg: error.toString());
    });
  }

//by this function all values become zero when we go back...
  resetValues() {
    totalPrice.value = 0;
    days.value = 0;
    colorIndex.value = 0;
  }

  //add and remove from wishlist...
  addToWishlist(docId, context) async {
    await firestore.collection(wheelsCollection).doc(docId).set({
      'w_wishlist': FieldValue.arrayUnion([currentUser!.uid])
    }, SetOptions(merge: true));
    isFav(true);
    VxToast.show(context, msg: "Added to wishlist");
  }

  removeFromWishlist(docId, context) async {
    await firestore.collection(wheelsCollection).doc(docId).set({
      'w_wishlist': FieldValue.arrayRemove([currentUser!.uid])
    }, SetOptions(merge: true));
    isFav(false);
    VxToast.show(context, msg: "Removed from wishlist");
  }

  checkIfFav(data) async {
    if (data['w_wishlist'].contains(currentUser!.uid)) {
      isFav(true);
    } else {
      isFav(false);
    }
  }
}
