import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:getanywheels/consts/paths.dart';
import 'package:getanywheels/controllers/home_controller.dart';

class FavouriteController extends GetxController{
  var totalP = 0.obs;

  //text editing controllers
  var addressController    = TextEditingController();
  var cityController       = TextEditingController();
  var stateController      = TextEditingController();
  var postalcodeController = TextEditingController();
  var phoneController      = TextEditingController();

//variable for payment
  var paymentIndex = 0.obs;

//wheelsSnapshot = productSnapshot.....
  late dynamic wheelsSnapshot;
  var wheels = [];
  var renters = [];

  //confirmBooking = placingOder
  var confirmBooking = false.obs;

  calculate(data){
    totalP.value = 0;
    for (var i = 0; i < data.length; i++) {
//wprice = tprice (will remove this comment)
      totalP.value = totalP.value + int.parse(data[i]['wprice'].toString());
      
    }
  }

  // to change payment methods..
  changePaymentIndex(index){
    paymentIndex.value = index;
  }

  //collection for payment to store in firebase...
  // booking = order
  placeMyBooking({required bookingPaymentMethod, required totalAmount}) async{
    confirmBooking(true);

    await getWheelsDetails();
    await firestore.collection(bookingCollection).doc().set({

      'booking_code': "233981237",
      'booking_date': FieldValue.serverTimestamp(),
      'booking_by': currentUser!.uid,
      'booking_by_name': Get.find<HomeController>().username,
      'booking_by_email': currentUser!.email,
      'booking_by_address': addressController.text,
      'booking_by_state': stateController.text,
      'booking_by_city': cityController.text,
      'booking_by_phone': phoneController.text,
      'booking_by_postalcode': postalcodeController.text,
      //hiring_method = shipping_method......
      'hiring_method': "At Owners Place",
      //bookingPaymentMethod = orederPaymentMethod
      'payment_method': bookingPaymentMethod,
      'booking_placed': true,
      'booking_confirmed': false,
      //wheels_hiried = order_delivered.....
      'wheel_hiried': false,
      'total_amount': totalAmount,
      'bookings': FieldValue.arrayUnion(wheels),
      'renters': FieldValue.arrayUnion(renters)
    });

    confirmBooking(false);
  }

//ye function har products mai se given cheezain filter kr k list kr day ga
  getWheelsDetails (){
    wheels.clear();
    renters.clear();
    for (var i = 0; i < wheelsSnapshot.length; i++) {
      wheels.add({
        'color' : wheelsSnapshot[i]['color'],
        'img' : wheelsSnapshot[i]['img'],
        'agency_id': wheelsSnapshot[i]['agency_id'],
        'wprice': wheelsSnapshot[i]['wprice'],
        'days' : wheelsSnapshot[i]['days'],
        'title' : wheelsSnapshot[i]['title'],
      });
      renters.add(wheelsSnapshot[i]['agency_id']);
    }
  }

  //method for clearing the favourite screen after confirm booking
  clearFavourite(){
    for (var i = 0; i < wheelsSnapshot.length; i++) {
      firestore.collection(favouriteCollection).doc(wheelsSnapshot[i].id).delete();
      
    }
  }







}