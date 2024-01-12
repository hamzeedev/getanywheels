import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:getanywheels/consts/loading_indicator.dart';
import 'package:getanywheels/views/category_screen/vehicle_details.dart';

import '../../../consts/paths.dart';
import '../../../services/firestore_services.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: whiteColor,
        appBar: AppBar(
          // automaticallyImplyLeading: false,
          title: "My Wishlist"
              .text
              .color(darkFontGrey)
              .fontFamily(semibold)
              .make(),
        ),
        body: StreamBuilder(
            //in below line we have called the method getWishlist created in firestore_services file
            stream: FirestoreServices.getWishlist(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: loadingIndicator(),
                );
              } else if (snapshot.data!.docs.isEmpty) {
                return "Noting in wishlist yet!"
                    .text
                    .color(darkFontGrey)
                    .makeCentered();
              } else {
                var data = snapshot.data!.docs;
                return Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                          itemCount: data.length,
                          itemBuilder: (BuildContext context, int index) {
                            return ListTile(
                              
                                    leading: Image.network(
                                      "${data[index]['w_imgs'][0]}",
                                      width: 80,
                                      fit: BoxFit.cover,
                                    ).onTap(() { 
                                      Get.to(() => VehiclesDetails(
                                        title:"${data[index]['w_name']}",
                                        data: data[index],
                                      ));
                                    }),
                                    title:
                                        "${data[index]['w_name']}"
                                            .text
                                            .fontFamily(semibold)
                                            .size(16)
                                            .make()
                                            .onTap(() {
                                              Get.to(() => VehiclesDetails(
                                        title:"${data[index]['w_name']}",
                                        data: data[index],
                                      ));
                                            })
                                            ,
                                    subtitle: "${data[index]['w_price']} Rs."
                                        .text
                                        .color(redColor)
                                        .fontFamily(semibold)
                                        .make(),
                                    trailing: const Icon(
                                      Icons.delete,
                                      color: redColor,
                                    ).onTap(() async{
                                      await firestore.collection(wishlistCollection).doc(data[index].id).set({
                                        'w_wishlist' : FieldValue.arrayRemove([currentUser!.uid])
                                      }, SetOptions(merge: true));

                                    }),
                                  );
                          },
                          ),
                    ),
                  ],
                );
              }
            }));
  }
}
