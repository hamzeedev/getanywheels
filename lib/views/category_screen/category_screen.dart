//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:getanywheels/consts/paths.dart';
import 'package:getanywheels/consts/lists.dart';
import 'package:getanywheels/controllers/wheels_controller.dart';
import 'package:getanywheels/views/category_screen/categories_details.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {

    var controller = Get.put(ProductController());




    return 
    // bgWidget(
    //   child:
       Scaffold(
        backgroundColor: whiteColor,
        appBar: AppBar(
          title: categories.text.fontFamily(bold).color(myBlack).make(),
          automaticallyImplyLeading: false,
        ),
        body: Container(
          padding: const EdgeInsets.all(12),
          child: GridView.builder(
              shrinkWrap: true,
              itemCount: 6,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                  mainAxisExtent: 150),
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Image.asset(
                      categoryImages[index],
                      height: 110,
                      width: 200,
                      fit: BoxFit.contain,
                    ),
                    0.heightBox,
                    categoriesList[index].text.size(22).color(myOrange).align(TextAlign.center).fontFamily(bold).make(),
                  ],
                ).box.white.rounded.clip(Clip.antiAlias).outerShadowXl.make().onTap(() {
                  controller.getSubCategories(categoriesList[index]);
                  Get.to(()=> CategoryDetails(title: categoriesList[index]));

                });
              }),
        ),
      );
    // );
  }
}
