import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:getanywheels/consts/paths.dart';
import 'package:getanywheels/consts/lists.dart';
import 'package:getanywheels/consts/loading_indicator.dart';
import 'package:getanywheels/controllers/auth_controllers.dart';
import 'package:getanywheels/controllers/profile_controller.dart';
import 'package:getanywheels/services/firestore_services.dart';
import 'package:getanywheels/views/auth/login_screen.dart';
import 'package:getanywheels/views/account/messages/messaging_screen.dart';
import 'package:getanywheels/views/account/booked_wheels/booking_screen.dart';
import 'package:getanywheels/views/account/profile_screen.dart/components/details_card.dart';
import 'package:getanywheels/views/account/profile_screen.dart/edit_profile_screen.dart';
import 'package:getanywheels/views/account/wishlist_screen/wishlist_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProfileController());

    return
        // bgWidget(
        //     child:
        Scaffold(
            backgroundColor: whiteColor,
            body: StreamBuilder(
                stream: FirestoreServices.getUser(currentUser!.uid),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(myOrange),
                      ),
                    );
                  } else {
                    var data = snapshot.data!.docs[0];
                    return SafeArea(
                        child: Column(
                      children: [
                        //edit profile button...
                        Padding(
                          padding: const EdgeInsets.all(0),
                          child: const Align(
                            alignment: Alignment.topRight,
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Icon(
                                Icons.edit,
                                color: myOrange,
                              ),
                            ),
                          ).onTap(() {
                            controller.nameController.text = data['name'];

                            Get.to(() => EditProfileScreen(data: data));
                          }),
                        ),

                        //users detail section...
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Row(
                            children: [
                              //IMAGE....
                              //if data image url and controller path is empty....
                              data['imageUrl'] == '' &&
                                      controller.profilImgPath.isEmpty
                                  ? Image.asset(
                                      profilePic1,
                                      width: 80,
                                      fit: BoxFit.cover,
                                    )
                                      .box
                                      .roundedFull
                                      .clip(Clip.antiAlias)
                                      .make()
                                  //if data is not empty but controller path is empty....
                                  : data['imageUrl'] != '' &&
                                          controller.profilImgPath.isEmpty
                                      ? Image.network(
                                          data['imageUrl'],
                                          width: 80,
                                          fit: BoxFit.cover,
                                        )
                                          .box
                                          .roundedFull
                                          .clip(Clip.antiAlias)
                                          .make()
                                      //if both are empty.....
                                      : Image.file(
                                          File(controller.profilImgPath.value),
                                          width: 80,
                                          fit: BoxFit.cover,
                                        )
                                          .box
                                          .roundedFull
                                          .clip(Clip.antiAlias)
                                          .make(),
                              10.widthBox,
                              Expanded(
                                  child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  "${data['name']}"
                                      .text
                                      .fontFamily(semibold)
                                      .color(myOrange)
                                      .make(),
                                  "${data['email']}"
                                      .text
                                      .color(myOrange)
                                      .make(),
                                ],
                              )),
                              //logout button....
                              OutlinedButton(
                                  style: OutlinedButton.styleFrom(
                                    side: const BorderSide(color: myOrange),
                                  ),
                                  onPressed: () async {
                                    await Get.put(AuthController())
                                        .signoutMethod(context);
                                    Get.offAll(() => const LoginScreen());
                                  },
                                  child: logout.text
                                      .fontFamily(semibold)
                                      .color(myOrange)
                                      .make())
                            ],
                          ),
                        ),

                        20.heightBox,

                        FutureBuilder(
                            future: FirestoreServices.getCounts(),
                            builder:
                                (BuildContext context, AsyncSnapshot snapshot) {
                              if (!snapshot.hasData) {
                                return Center(
                                  child: loadingIndicator(),
                                );
                              } else {
                                var countData = snapshot.data;

                                return Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    // detailsCard(
                                    //     count: countData[0].toString(),
                                    //     title: "In Favourite",
                                    //     width: context.screenWidth / 3.4),
                                    detailsCard(
                                        count: countData[1].toString(),
                                        title: "In WishList",
                                        width: context.screenWidth / 3.4),
                                    detailsCard(
                                        count: countData[2].toString(),
                                        title: "Booked Wheels",
                                        width: context.screenWidth / 3.4),
                                  ],
                                );
                              }
                            }),

                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        //   children: [
                        //     detailsCard(
                        //         count: data['favourite_count'],
                        //         title: "Favourite",
                        //         width: context.screenWidth / 3.4),
                        //     detailsCard(
                        //         count: data['booking_count'],
                        //         title: "WishList",
                        //         width: context.screenWidth / 3.4),
                        //     detailsCard(
                        //         count: data['previous_booking'],
                        //         title: "Previous Book",
                        //         width: context.screenWidth / 3.4),
                        //   ],
                        // ),

                        //buttons section...

                        ListView.separated(
                                shrinkWrap: true,
                                separatorBuilder: (context, index) {
                                  return const Divider(
                                    color: myOrange,
                                  );
                                },
                                itemCount: profileButtonsList.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return ListTile(
                                    onTap: () {
                                      switch (index) {
                                        case 0:
                                          Get.to(() => const BookingsScreen());
                                          break;
                                        case 1:
                                          Get.to(() => const MessagesScreen());
                                          break;
                                          case 2:
                                          Get.to(() => const WishlistScreen());
                                          break;
                                        
                                      }
                                    },
                                    leading: Image.asset(
                                      profileButtonIcons[index],
                                      width: 22,
                                      //icons colors of card
                                      color: myOrange,
                                    ),
                                    title: profileButtonsList[index]
                                        .text
                                        .fontFamily(semibold)
                                        //font colors of card
                                        .color(darkFontGrey)
                                        .make(),
                                  );
                                })
                            .box
                            //upgrounnd color of card
                            .color(whiteColor)
                            .rounded
                            .margin(const EdgeInsets.all(12))
                            .padding(const EdgeInsets.symmetric(horizontal: 16))
                            .shadowMd
                            .make()
                            .box
                            //background color of card
                            .color(whiteColor)
                            .make(),
                      ],
                    ));
                  }
                }));
  }
}
