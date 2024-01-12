import 'package:get/get.dart';
import 'package:getanywheels/consts/paths.dart';
import 'package:getanywheels/controllers/favourite_controller.dart';
import 'package:getanywheels/views/booking/payment_method.dart';
import 'package:getanywheels/views/widgets_common/custom_textfield.dart';
import 'package:getanywheels/views/widgets_common/our_button.dart';

class UserAdressInfoScreen extends StatelessWidget {
  const UserAdressInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<FavouriteController>();

    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: "User Address and Info"
            .text
            .fontFamily(semibold)
            .color(darkFontGrey)
            .make(),
      ),
      bottomNavigationBar: SizedBox(
        height: 60,
        child: ourButton(
          onPress: () {
            // && controller.cityController.text.length < 16 && controller.stateController.text.length < 12 && controller.phoneController.text.length == 11 
            if (controller.addressController.text.length >10 ) {

              Get.to(()=> const PaymentMethods());

            } else {
              VxToast.show(context, msg: "Please fill the form Properly");
            }
          },
          color: myOrange,
          textColor: whiteColor,
          title: "Continue",
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            customTextField(
                hint: "Address",
                isPass: false,
                title: "Address",
                controller: controller.addressController),
            customTextField(
                hint: "City",
                isPass: false,
                title: "City",
                controller: controller.cityController),
            customTextField(
                hint: "State",
                isPass: false,
                title: "State",
                controller: controller.stateController),
            customTextField(
                hint: "Postal Code",
                isPass: false,
                title: "Postal Code",
                controller: controller.postalcodeController,
                // keyType: TextInputType.number
                ),
            customTextField(
                hint: "Phone",
                isPass: false,
                title: "Phone",
                controller: controller.phoneController,
                // keyType: TextInputType.number
                ),
          ],
        ),
      ),
    );
  }
}

