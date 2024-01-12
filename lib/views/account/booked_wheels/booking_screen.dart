import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:getanywheels/consts/paths.dart';
import 'package:getanywheels/consts/loading_indicator.dart';
import 'package:getanywheels/services/firestore_services.dart';
import 'package:getanywheels/views/account/booked_wheels/booking_details.dart';

class BookingsScreen extends StatelessWidget {
  const BookingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
        appBar: AppBar(
          title:
              "My Booking".text.color(darkFontGrey).fontFamily(semibold).make(),
        ),
        body: StreamBuilder(
          //in below line we have called the method getAllBookings created in firestore_services file
            stream: FirestoreServices.getAllBookings(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: loadingIndicator(),
                );
              } else if (snapshot.data!.docs.isEmpty) {
                return "No Booking yet!".text.color(darkFontGrey).makeCentered();
              } else {
                var data = snapshot.data!.docs;

                return ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (BuildContext context, int index) {

                    return ListTile(
                      leading: "${index + 1}".text.fontFamily(bold).color(darkFontGrey).xl.make(),
                      title: data[index]['booking_code'].toString().text.color(redColor).fontFamily(semibold).make(),
                      subtitle: data[index]['total_amount'].toString().numCurrency.text.fontFamily(bold).make(),
                      trailing: IconButton(
                        onPressed: () {
                          //haha
                          //yaha bohat khapa bcoz const hatana bhol gya tha lol
                          Get.to(() =>  BookingsDetails(data: data[index]));

                        },
                        icon: const Icon(
                          Icons.arrow_forward_ios_outlined,
                          color: darkFontGrey,

                        ),
                      ),
                    );
                    
                  },
                );
              }
            })
            );
  }
}
