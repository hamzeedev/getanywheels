import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:getanywheels/consts/paths.dart';
import 'package:getanywheels/consts/loading_indicator.dart';
import 'package:getanywheels/controllers/favourite_controller.dart';
import 'package:getanywheels/services/firestore_services.dart';
import 'package:getanywheels/views/booking/user_address_info_screen.dart';
import 'package:getanywheels/views/widgets_common/our_button.dart';

class ProceedBookingScreen extends StatelessWidget {
  const ProceedBookingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(FavouriteController());
    return Scaffold(
      //we can use this button in below also
      //yaha ziada acha lag ra tha thats why i use it here....
      bottomNavigationBar: SizedBox(
        height: 50,
        child: ourButton(
          color: myOrange,
          onPress: () {
            Get.to(() => const UserAdressInfoScreen());
          },
          textColor: whiteColor,
          title: "Proceed to Booking",
        ),
      ),
      backgroundColor: whiteColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: "Bookings".text.color(darkFontGrey).fontFamily(semibold).make(),
      ),
      body: StreamBuilder(
          stream: FirestoreServices.getFavourite(currentUser!.uid),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: loadingIndicator(),
              );
            } else if (snapshot.data!.docs.isEmpty) {
              return Center(
                child: "Booking is empty".text.color(darkFontGrey).make(),
              );
            } else {
              var data = snapshot.data!.docs;
              controller.calculate(data);
              controller.wheelsSnapshot = data;

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Expanded(
                        child: ListView.builder(
                            itemCount: data.length,
                            itemBuilder: (BuildContext context, int index) {
                              return ListTile(
                                leading: Image.network(
                                  "${data[index]['img']}",
                                  width: 80,
                                  fit: BoxFit.cover,
                                ),
                                title:
                                    "${data[index]['title']} (For ${data[index]['days']} Day)"
                                        .text
                                        .fontFamily(semibold)
                                        .size(16)
                                        .make(),
                                subtitle: "${data[index]['wprice']} Rs."
                                    .text
                                    .color(redColor)
                                    .fontFamily(semibold)
                                    .make(),
                                //remove button.....
                                trailing: const Icon(
                                  Icons.delete,
                                  color: redColor,
                                ).onTap(() {
                                  FirestoreServices.deleteDocument(
                                      data[index].id);
                                }),
                              );
                            })),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        "Total Price"
                            .text
                            .fontFamily(semibold)
                            .color(darkFontGrey)
                            .make(),
                        Obx(
                          () => "${controller.totalP.value}"
                              .numCurrency
                              .text
                              .fontFamily(semibold)
                              .color(redColor)
                              .make(),
                        ),
                      ],
                    )
                        .box
                        .padding(const EdgeInsets.all(12))
                        .width(context.screenWidth - 60)
                        .color(lightGrey)
                        .roundedSM
                        .make(),
                    10.heightBox,
                    // SizedBox(
                    //   width: context.screenWidth - 60,
                    //   child: ourButton(
                    //     color: redColor,
                    //     onPress: () {},
                    //     textColor: whiteColor,
                    //     title: "Proceed to Booking",
                    //   ),
                    // )
                  ],
                ),
              );
            }
          }),
    );
  }
}
