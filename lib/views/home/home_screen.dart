import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:getanywheels/consts/paths.dart';
import 'package:getanywheels/consts/loading_indicator.dart';
import 'package:getanywheels/controllers/home_controller.dart';
import 'package:getanywheels/services/firestore_services.dart';
import 'package:getanywheels/views/category_screen/vehicle_details.dart';

import 'package:getanywheels/views/home/components/featured_button.dart';
import 'package:getanywheels/views/home/search_screen.dart';
import 'package:getanywheels/views/widgets_common/home_buttons.dart';

import '../../consts/lists.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<HomeController>();
    return Container(
      padding: const EdgeInsets.all(12),
      color: lightGrey,
      width: context.screenWidth,
      height: context.screenHeight,
      child: SafeArea(
          child: Column(
        children: [
          ///SEARCH bar....
          Container(
            alignment: Alignment.center,
            height: 40,
            color: lightGrey,
            child: TextFormField(
              controller: controller.searchController,
              decoration: InputDecoration(
                suffixIconColor: myOrange,
                border: InputBorder.none,
                suffixIcon: const Icon(Icons.search).onTap(() {
                  if (controller.searchController.text.isNotEmptyAndNotNull) {
                    Get.to(() => SearchScreen(
                          title: controller.searchController.text,
                        ));
                  }
                }),
                filled: true,
                fillColor: whiteColor,
                hintText: searchanything,
                hintStyle: const TextStyle(color: textfieldGrey),
              ),
            ),
          ),

          10.heightBox,
          //creating 2nd cloumn for screen data
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  //1st swipers....
                  VxSwiper.builder(
                      aspectRatio: 16 / 9,
                      autoPlay: true,
                      autoPlayAnimationDuration: const Duration(seconds: 2),
                      autoPlayCurve: Curves.easeInToLinear,
                      height: 150,
                      enlargeCenterPage: true,
                      itemCount: slider2List.length,
                      itemBuilder: (context, index) {
                        return Image.asset(
                          slider2List[index],
                          fit: BoxFit.fill,
                        )
                            .box
                            .rounded
                            .clip(Clip.antiAlias)
                            .margin(const EdgeInsets.symmetric(horizontal: 6))
                            .make();
                      }),

                  20.heightBox,

                  // //Buttons (deal & drivers)....
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //   children: List.generate(
                  //       2,
                  //       (index) => homeButtons(
                  //             height: context.screenHeight * 0.10,
                  //             width: context.screenWidth / 2.5,
                  //             icon: index == 0 ? icAgency : icIndividual,
                  //             title: index == 0 ? agencies : worDrivers,
                  //           )),
                  // ),

                  20.heightBox,
                  //TEXT (feature categories)....
                  Align(
                    alignment: Alignment.centerLeft,
                    child: featuredCategories.text
                        .color(darkFontGrey)
                        .size(18)
                        .fontFamily(semibold)
                        .make(),
                  ),
                  10.heightBox,
                  //featured categories....
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(
                          2,
                          (index) => Column(
                                children: [
                                  featureButton(
                                      icon: featuredImages1[index],
                                      title: featuredTitles1[index]),
                                  10.heightBox,
                                  featureButton(
                                      icon: featuredImages2[index],
                                      title: featuredTitles2[index]),
                                ],
                              )).toList(),
                    ),
                  ),

                  //2nd swiper....

                  // VxSwiper.builder(
                  //     aspectRatio: 16 / 9,
                  //     autoPlay: true,
                  //     autoPlayAnimationDuration: const Duration(seconds: 2),
                  //     autoPlayCurve: Curves.easeInToLinear,
                  //     height: 150,
                  //     enlargeCenterPage: true,
                  //     itemCount: slider2List.length,
                  //     itemBuilder: (context, index) {
                  //       return Image.asset(
                  //         slider2List[index],
                  //         fit: BoxFit.fill,
                  //       )
                  //           .box
                  //           .rounded
                  //           .clip(Clip.antiAlias)
                  //           .margin(const EdgeInsets.symmetric(horizontal: 6))
                  //           .make();
                  //     }),

                  0.heightBox,

                  // Buttons (Category)....
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //   children: List.generate(
                  //       3,
                  //       (index) => homeButtons(
                  //             height: context.screenHeight * 0.12,
                  //             width: context.screenWidth / 3.5,
                  //             icon: index == 0
                  //                 ? icTopCategories
                  //                 : index == 1
                  //                     ? icBrands
                  //                     : icTopSeller,
                  //             title: index == 0
                  //                 ? topWheels
                  //                 : index == 1
                  //                     ? brand
                  //                     : topAgency,
                  //           )),
                  // ),

                  // 20.heightBox,

                  // //featured categories....
                  // SingleChildScrollView(
                  //   scrollDirection: Axis.horizontal,
                  //   child: Row(
                  //     children: List.generate(
                  //         3,
                  //         (index) => Column(
                  //               children: [
                  //                 featureButton(
                  //                     icon: featuredImages1[index],
                  //                     title: featuredTitles1[index]),
                  //                 10.heightBox,
                  //                 featureButton(
                  //                     icon: featuredImages2[index],
                  //                     title: featuredTitles2[index]),
                  //               ],
                  //             )).toList(),
                  //   ),
                  // ),

                  20.heightBox,

                  //Featured Wheels
                  Container(
                    padding: const EdgeInsets.all(12),
                    width: double.infinity,
                    decoration: const BoxDecoration(color: myOrange),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //TEXT (feature Wheels)....
                        featuredWheels.text.white
                            .size(18)
                            .fontFamily(bold)
                            .make(),

                        10.heightBox,

                        ///FEATURED WHEELS....
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
                                              "${featuredData[index]['w_price']} Rs"
                                                  .text
                                                  .fontFamily(semibold)
                                                  .color(myOrange)
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
                      ],
                    ),
                  ),

                  //3rd swiper...
                  20.heightBox,
                  VxSwiper.builder(
                      aspectRatio: 16 / 9,
                      autoPlay: true,
                      autoPlayCurve: Curves.easeInToLinear,
                      autoPlayAnimationDuration: const Duration(seconds: 2),
                      height: 130,
                      enlargeCenterPage: true,
                      itemCount: slider1List.length,
                      itemBuilder: (context, index) {
                        return Image.asset(
                          slider1List[index],
                          fit: BoxFit.fill,
                        )
                            .box
                            .rounded
                            .clip(Clip.antiAlias)
                            .margin(const EdgeInsets.symmetric(horizontal: 6))
                            .make();
                      }),

                  //all products...
                  20.heightBox,
                  Align(
                    alignment: Alignment.centerLeft,
                    child: "All Wheels"
                        .text
                        .fontFamily(bold)
                        .color(darkFontGrey)
                        .size(18)
                        .make(),
                  ),
                  20.heightBox,
                  StreamBuilder(
                      stream: FirestoreServices.allWheels(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (!snapshot.hasData) {
                          return loadingIndicator();
                        } else {
                          var allwheelsdata = snapshot.data!.docs;
                          return GridView.builder(
                              //the given line of code combine its scroll wit main scroll you can remove it according to need
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: allwheelsdata.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: 8,
                                crossAxisSpacing: 8,
                                mainAxisExtent: 160,
                              ),
                              itemBuilder: (context, index) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Image.network(
                                      allwheelsdata[index]['w_imgs'][0],
                                      width: 110,
                                      fit: BoxFit.cover,
                                    ),
                                    const Spacer(),
                                    "${allwheelsdata[index]['w_name']}"
                                        .text
                                        .fontFamily(bold)
                                        .color(darkFontGrey)
                                        .make(),
                                    10.heightBox,
                                    "${allwheelsdata[index]['w_price']} Rs"
                                        .text
                                        .fontFamily(semibold)
                                        .color(myOrange)
                                        .size(8)
                                        .make(),
                                  ],
                                )
                                    .box
                                    .white
                                    .margin(const EdgeInsets.symmetric(
                                        horizontal: 4))
                                    .roundedSM
                                    .padding(const EdgeInsets.all(12))
                                    .make()
                                    .onTap(() {
                                  Get.to(() => VehiclesDetails(
                                        title:
                                            "${allwheelsdata[index]['w_name']}",
                                        data: allwheelsdata[index],
                                      ));
                                });
                              });
                        }
                      }),
                ],
              ),
            ),
          )
        ],
      )),
    );
  }
}
