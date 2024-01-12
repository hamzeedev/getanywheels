import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:getanywheels/consts/paths.dart';
import 'package:getanywheels/controllers/wheels_controller.dart';
import 'package:getanywheels/views/account/messages/chat_screen.dart';

import 'package:getanywheels/views/widgets_common/our_button.dart';
// import 'package:getanywheels/views/widgets_common/confirmDialog.dart';

import '../../consts/loading_indicator.dart';
import '../../controllers/favourite_controller.dart';
import '../../services/firestore_services.dart';

class VehiclesDetails extends StatelessWidget {
  final String? title;
  final dynamic data;
  const VehiclesDetails({Key? key, required this.title, this.data})
      : super(key: key);

  @override
  
  Widget build(BuildContext context) {
     var controller = Get.put(FavouriteController());
    
//given line initializing that days controller from product_controller.dart
    var controller1 = Get.put(ProductController());

//here we have call rest value function
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () async {
        controller1.resetValues();
        return true;
      },
      child: Scaffold(
        backgroundColor: lightGrey,
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              //here we have call rest value function
              controller1.resetValues();
              Get.back();
            },
            icon: const Icon(Icons.arrow_back_ios_new),
          ),
          title: title!.text.color(darkFontGrey).fontFamily(bold).make(),
          actions: [
            //share icon....
            // IconButton(
            //   onPressed: () {},
            //   icon: const Icon(
            //     Icons.share,
            //   ),
            // ),
            //favourite icon
            Obx(
              () => IconButton(
                onPressed: () {
                  if (controller1.isFav.value) {
                    controller1.removeFromWishlist(data.id, context);
                    controller1.isFav(false);
                  } else {
                    controller1.addToWishlist(data.id, context);
                    controller1.isFav(true);
                  }
                },
                icon: Icon(
                  Icons.favorite_outlined,
                  color: controller1.isFav.value ? myOrange : darkFontGrey,
                ),
              ),
            ),
          ],
        ),
        body: Column(
          children: [
            Expanded(
                child: Padding(
              padding: const EdgeInsets.all(8),
              child: SingleChildScrollView(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //swiper section
                  VxSwiper.builder(
                      autoPlay: true,
                      height: 250,
                      aspectRatio: 16 / 9,
                      viewportFraction: 1.0,

                      //by given line is fatching images length from database
                      itemCount: data['w_imgs'].length,
                      itemBuilder: (context, index) {
                        return Image.network(
                          //by given line is fatching images length from database
                          data["w_imgs"][index],
                          width: double.infinity,
                          fit: BoxFit.cover,
                        );
                      }),

                  10.heightBox,
                  //title and details...
                  title!.text
                      .size(16)
                      .color(darkFontGrey)
                      .fontFamily(bold)
                      .make(),
                  //rating
                  10.heightBox,
                  VxRating(
                    //by given line we have fixed the rating
                    isSelectable: false,
                    //by given line rating is fetched from database
                    value: double.parse(data['w_rating']),
                    onRatingUpdate: (value) {},
                    normalColor: textfieldGrey,
                    selectionColor: golden,
                    count: 5,
                    maxRating: 5,
                    size: 25,
                  ),

                  //price...
                  10.heightBox,
                  "${data['w_price']} Rs./Per Day"

                      //.numCurrency
                      .text
                      .color(redColor)
                      .fontFamily(semibold)
                      .size(18)
                      .make(),

                  //M E S S A G E S icon..
                  10.heightBox,
                  Row(
                    children: [
                      Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          "Talk with".text.white.fontFamily(semibold).make(),
                          5.heightBox,
                          "${data['w_agency']}"
                              .text
                              .fontFamily(semibold)
                              .color(darkFontGrey)
                              .make(),
                        ],
                      )),
                      const CircleAvatar(
                        backgroundColor: whiteColor,
                        child: Icon(
                          Icons.message_rounded,
                          color: darkFontGrey,
                        ),
                      ).onTap(() {
                        Get.to(
                          () => const ChatScreen(),
                          arguments: [data['w_agency'], data['agency_id']],
                        );
                      }),
                    ],
                  )
                      .box
                      .height(60)
                      .rounded
                      .padding(const EdgeInsets.symmetric(horizontal: 16))
                      .color(textfieldGrey)
                      .make(),

                  //color Section...
                  20.heightBox,
                  Obx(
                    () => Column(
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: 100,
                              child: "Color: ".text.color(textfieldGrey).make(),
                            ),
                            Row(
                              children: List.generate(
                                  data['w_colors'].length,
                                  (index) => Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          VxBox()
                                              .size(30, 30)
                                              .roundedFull
                                              .margin(
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 3))
                                              .color(
                                                  Color(data['w_colors'][index])
                                                      .withOpacity(1.0))
                                              .make()
                                              .onTap(() {
                                            controller1.changeColorIndex(index);
                                          }),
                                          Visibility(
                                            visible: index ==
                                                controller1.colorIndex.value,
                                            child: const Icon(
                                              Icons.done,
                                              color: myOrange,
                                            ),
                                          )
                                        ],
                                      )),
                            )
                          ],
                        ).box.padding(const EdgeInsets.all(8)).make(),

                        //quantity row (ADD DAYS)...
                        Row(
                          children: [
                            SizedBox(
                              width: 100,
                              child: "Days: ".text.color(textfieldGrey).make(),
                            ),
                            Obx(
                              () => Row(
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        controller1.decreaseDays();
                                        controller1.calculateTotalPrice(
                                            int.parse(data['w_price']));
                                      },
                                      icon: const Icon(Icons.remove)),
                                  controller1.days.value.text
                                      .size(16)
                                      .color(whiteColor)
                                      .fontFamily(bold)
                                      .make(),
                                  IconButton(
                                      onPressed: () {
                                        controller1.increaseDays(
                                            int.parse(data['w_days']));
                                        controller1.calculateTotalPrice(
                                            int.parse(data['w_price']));
                                      },
                                      icon: const Icon(Icons.add)),
                                  10.heightBox,
                                  "(${data['w_days']})"
                                      .text
                                      .color(textfieldGrey)
                                      .make(),
                                ],
                              ),
                            ),
                          ],
                        ).box.padding(const EdgeInsets.all(8)).make(),

                        //total wali row...
                        Row(
                          children: [
                            SizedBox(
                              width: 100,
                              child: "Total: ".text.color(textfieldGrey).make(),
                            ),
                            "${controller1.totalPrice.value} Rs./Per Day"
                                
                                .text
                                .color(whiteColor)
                                .size(16)
                                .fontFamily(semibold)
                                .make(),
                          ],
                        ).box.padding(const EdgeInsets.all(8)).make(),
                      ],
                    ).box.color(myOrange).roundedSM.shadowMd.make(),
                  ),

                  //Description wala section...
                  10.heightBox,
                  "Description"
                      .text
                      .color(darkFontGrey)
                      .fontFamily(semibold)
                      .make(),
                  10.heightBox,
                  "${data['w_desc']}".text.color(darkFontGrey).make(),

                  //buttons section....
                  10.heightBox,
                  // ListView(
                  //   physics: const NeverScrollableScrollPhysics(),
                  //   shrinkWrap: true,
                  //   children: List.generate(
                  //       itemDetailButtonList.length,
                  //       (index) => ListTile(
                  //             title: itemDetailButtonList[index]
                  //                 .text
                  //                 .fontFamily(semibold)
                  //                 .color(darkFontGrey)
                  //                 .make(),
                  //             trailing: const Icon(Icons.arrow_forward),
                  //           )),
                  // ),

                  //products you may like section...
                  10.heightBox,
                  productsYouMayLike.text
                      .fontFamily(bold)
                      .size(16)
                      .color(darkFontGrey)
                      .make(),
                  10.heightBox,
                  SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: FutureBuilder(
                            future: FirestoreServices.getFeaturedWheels(),
                            builder: (context,
                                AsyncSnapshot<QuerySnapshot> snapshot) {
                              if (!snapshot.hasData) {
                                return Center(
                                  child: loadingIndicator(),
                                );
                              } else if (snapshot.data!.docs.isEmpty) {
                                return "No Featured Wheels Found".text.make();
                              } else {
                                var featuredData = snapshot.data!.docs;
                                return Row(
                                  children: List.generate(
                                      featuredData.length,
                                      (index) => Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Image.network(
                                                featuredData[index]['w_imgs']
                                                    [0],
                                                width: 150,
                                                height: 110,
                                                fit: BoxFit.cover,
                                              ),
                                              10.heightBox,
                                              "${featuredData[index]['w_name']}"
                                                  .text
                                                  .fontFamily(bold)
                                                  .color(darkFontGrey)
                                                  .make(),
                                              10.heightBox,
                                              "${featuredData[index]['w_price']} RS"
                                                  .text
                                                  .fontFamily(semibold)
                                                  .color(redColor)
                                                  .size(8)
                                                  .make(),
                                            ],
                                          )
                                              .box
                                              .white
                                              .margin(
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 4))
                                              .roundedSM
                                              .padding(const EdgeInsets.all(8))
                                              .make()
                                              .onTap(() {
                                            Get.to(() => VehiclesDetails(
                                                  title:
                                                      "${featuredData[index]['w_name']}",
                                                  data: featuredData[index],
                                                ));
                                          })),
                                );
                              }
                            },
                          ),
                        ),
                  // SingleChildScrollView(
                  //   scrollDirection: Axis.horizontal,
                  //   child: Row(
                  //     children: List.generate(
                  //         6,
                  //         (index) => Column(
                  //               crossAxisAlignment: CrossAxisAlignment.start,
                  //               children: [
                  //                 Image.asset(
                  //                   worFW1,
                  //                   width: 150,
                  //                   fit: BoxFit.cover,
                  //                 ),
                  //                 10.heightBox,
                  //                 "Honda Civic (2023)"
                  //                     .text
                  //                     .fontFamily(bold)
                  //                     .color(darkFontGrey)
                  //                     .make(),
                  //                 10.heightBox,
                  //                 "22,000 Rs. Per day"
                  //                     .text
                  //                     .fontFamily(semibold)
                  //                     .color(redColor)
                  //                     .size(8)
                  //                     .make(),
                  //               ],
                  //             )
                  //                 .box
                  //                 .white
                  //                 .margin(
                  //                     const EdgeInsets.symmetric(horizontal: 4))
                  //                 .roundedSM
                  //                 .padding(const EdgeInsets.all(8))
                  //                 .make()),
                  //   ),
                  // ),
                ],
              )),
            )),
            Padding(
              padding: const EdgeInsets.only(bottom: 24, left: 12, right: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // //Book Now button....
                  // ourButton(
                  //         color: myOrange,
                  //         onPress: () {
                  //           if (controller1.days.value > 0) {
                  //             Get.to(()=> const ProceedBookingScreen());
                  //             // Get.to( ()=> confirmDialog(context) );
                  //           // popupDialog(context);
                              
                  //           } else {

                  //             VxToast.show(context, msg: "Minimum 1 days is required");
                              
                  //           }
                  //         },
                  //         textColor: whiteColor,
                  //         title: "Book Now")
                  //     .box
                  //     .width(400)
                  //     .make(),

                  //favourtie = add to cart (will remove this comment)
                  //Add to favorite button .....
                  ourButton(
                          color: myOrange,
                          onPress: () {
                            if (controller1.days.value > 0) {
                              
                              controller1.addFavourite(
                                color: data['w_colors'][controller1.colorIndex.value],
                                context: context,
                                agencyID: data['agency_id'],
                                img: data['w_imgs'][0],
                                days: controller1.days.value,
                                agencyname: data['w_agency'],
                                title: data['w_name'],
                                wprice: controller1.totalPrice.value);
                            VxToast.show(context, msg: "Added to Bookings");
                              
                            } else {
                              VxToast.show(context, msg: "Minimum 1 days is required");
                            }
                          },
                          textColor: whiteColor,
                          title: "Add Wheel To Bookings")
                      .box
                      .width(400)
                      .make(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
