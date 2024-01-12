import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:getanywheels/consts/paths.dart';
import 'package:getanywheels/consts/loading_indicator.dart';
import 'package:getanywheels/controllers/wheels_controller.dart';
import 'package:getanywheels/services/firestore_services.dart';
import 'package:getanywheels/views/category_screen/vehicle_details.dart';

class CategoryDetails extends StatefulWidget {
  final String? title;
  const CategoryDetails({Key? key, required this.title}) : super(key: key);

  @override
  State<CategoryDetails> createState() => _CategoryDetailsState();
}

class _CategoryDetailsState extends State<CategoryDetails> {
  @override
  void initState() {
    super.initState();

    switchCategory(widget.title);
  }

  switchCategory(title) {
    if (controller.subcat.contains(title)) {
      wheelMethod = FirestoreServices.getSubCategoryWheels(title);
    } else {
      wheelMethod = FirestoreServices.getWheels(title);
    }
  }

  var controller = Get.put(ProductController());
  dynamic wheelMethod;

  @override
  Widget build(BuildContext context) {
    return 
    // bgWidget(
    //     child: 
        Scaffold(
          backgroundColor: whiteColor,
            appBar: AppBar(
              title: widget.title!.text.color(myOrange).fontFamily(bold).make(),
            ),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ///SingleChildScrollView is out of StreamBuilder bcz it will always shown
                SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(
                        controller.subcat.length,
                        //yaha categories ki oper wali sub categories show hun gi
                        (index) => "${controller.subcat[index]}"
                                .text
                                .size(12)
                                .fontFamily(semibold)
                                .color(darkFontGrey)
                                .makeCentered()
                                .box
                                .orange200
                                .rounded
                                .size(120, 60)
                                .margin(const EdgeInsets.symmetric(horizontal: 4))
                                .make()
                                .onTap(() {
                              switchCategory("${controller.subcat[index]}");
                              setState(() {
                                
                              });
                            })),
                  ),
                ),
                20.heightBox,
                StreamBuilder(
                    stream: wheelMethod,
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (!snapshot.hasData) {
                        return Expanded(
                          child: Center(
                            child: loadingIndicator(),
                          ),
                        );
                      } else if (snapshot.data!.docs.isEmpty) {
                        return Expanded(
                          child:
                              "No Wheels found !".text.color(darkFontGrey).makeCentered(),
                        );
                      } else {
                        var data = snapshot.data!.docs;
                        return
                            //items container....

                            Expanded(
                                child: GridView.builder(
                                    shrinkWrap: true,
                                    itemCount: data.length,
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      mainAxisExtent: 220,
                                      mainAxisSpacing: 8,
                                      crossAxisSpacing: 8,
                                    ),
                                    itemBuilder: (context, index) {
                                      return Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Image.network(
                                            //this line of code is fetcing image from database...
                                            data[index]['w_imgs'][0],
                                            height: 130,
                                            width: 1500,
                                            fit: BoxFit.cover,
                                          )
                                              .box
                                              .roundedSM
                                              .clip(Clip.antiAlias)
                                              .make(),
                                          const Spacer(),
                                          //this line of code is fetcing name from database...
                                          "${data[index]['w_name']}"
                                              .text
                                              .fontFamily(bold)
                                              .color(darkFontGrey)
                                              .make(),
                                          10.heightBox,
                                          //this line of code is fetcing name from database...
                                          "${data[index]['w_price']} Rs"
                                              
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
                                          .shadowMd
                                          .padding(const EdgeInsets.all(12))
                                          .make()
                                          .onTap(() {
                                        controller.checkIfFav(data[index]);
                                        Get.to(() => VehiclesDetails(
                                            title: "${data[index]['w_name']}",
                                            data: data[index]));
                                        // Get.back();
                                      });
                                    }));
                      }
                    }),
              ],
            )
            );
            // );
  }
}
