import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:getanywheels/consts/paths.dart';
import 'package:getanywheels/consts/loading_indicator.dart';
import 'package:getanywheels/services/firestore_services.dart';

import '../category_screen/vehicle_details.dart';

class SearchScreen extends StatelessWidget {
  final String? title;
  const SearchScreen({this.title, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightGrey,
      appBar: AppBar(
        title: title!.text.color(darkFontGrey).make(),
      ),
      body: FutureBuilder(
        future: FirestoreServices.searchWheels(title),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: loadingIndicator(),
            );
          } else if (snapshot.data!.docs.isEmpty) {
            return "No wheels found according to your search"
                .text
                .makeCentered();
          } else {
            var data = snapshot.data!.docs;
            ///Below is variable to search anything if available 
            var filtered = data
                .where(
                  (element) => element['w_name']
                      .toString()
                      .toLowerCase()
                      .contains(title!.toLowerCase()),
                )
                .toList();
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                  mainAxisExtent: 190,
                ),
                children: filtered
                    .mapIndexed((currentValue, index) => Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.network(
                              filtered[index]['w_imgs'][0],
                              width: 160,
                              fit: BoxFit.cover,
                            ),
                            const Spacer(),
                            "${filtered[index]['w_name']}"
                                .text
                                .fontFamily(bold)
                                .color(darkFontGrey)
                                .make(),
                            10.heightBox,
                            "${filtered[index]['w_price']}"
                                .text
                                .fontFamily(semibold)
                                .color(redColor)
                                .size(8)
                                .make(),
                          ],
                        )
                            .box
                            .white
                            .outerShadowLg
                            .margin(const EdgeInsets.symmetric(horizontal: 4))
                            .roundedSM
                            .padding(const EdgeInsets.all(12))
                            .make()
                            .onTap(() {
                          Get.to(() => VehiclesDetails(
                                title: "${filtered[index]['w_name']}",
                                data: filtered[index],
                              ));
                        }))
                    .toList(),
              ),
            );
          }
        },
      ),
    );
  }
}
