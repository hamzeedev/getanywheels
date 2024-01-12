import 'package:get/get.dart';
import 'package:getanywheels/consts/paths.dart';
import 'package:getanywheels/views/category_screen/categories_details.dart';

Widget featureButton({String? title, icon}) {
  return Row(
    children: [
      Image.asset(
        icon!,
        width: 50,
        fit: BoxFit.fill,
      ),
      10.widthBox,
      title!.text.fontFamily(semibold).color(darkFontGrey).make(),
    ],
  )
      .box
      .width(200)
      .margin(const EdgeInsets.symmetric(horizontal: 4))
      .white
      .padding(const EdgeInsets.all(4))
      .roundedSM
      .outerShadowSm
      .make()
      .onTap(() {
        Get.to(()=> CategoryDetails(title: title));
      });
}
