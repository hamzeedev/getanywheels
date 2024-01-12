import 'package:get/get.dart';
import 'package:getanywheels/consts/paths.dart';
import 'package:getanywheels/consts/lists.dart';
import 'package:getanywheels/consts/loading_indicator.dart';
import 'package:getanywheels/controllers/favourite_controller.dart';
import 'package:getanywheels/views/home/navigatin_bar.dart';
import 'package:getanywheels/views/widgets_common/our_button.dart';

class PaymentMethods extends StatelessWidget {
  const PaymentMethods({super.key});

  @override
  Widget build(BuildContext context) {
    //controller for payment methods...
    var controller = Get.find<FavouriteController>();

    return Obx(
      () => Scaffold(
        backgroundColor: whiteColor,
        bottomNavigationBar: SizedBox(
          height: 60,
          child: controller.confirmBooking.value
              ? Center(
                  child: loadingIndicator(),
                )
              : ourButton(
                  onPress: () async {
                    await controller.placeMyBooking(
                        bookingPaymentMethod:
                            paymentMethodsTxt[controller.paymentIndex.value],
                        totalAmount: controller.totalP.value);

                    await controller.clearFavourite();
                    VxToast.show(context, msg: "Wheel Booked Successfully");

                    Get.offAll(const Home());
                  },
                  color: redColor,
                  textColor: whiteColor,
                  title: "Confirm Booking",
                ),
        ),
        appBar: AppBar(
          title: "Choose Payment Method"
              .text
              .fontFamily(semibold)
              .color(darkFontGrey)
              .make(),
        ),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Obx(
            () => Column(
              children: List.generate(paymentMethodsImg.length, (index) {
                return GestureDetector(
                  onTap: () {
                    controller.changePaymentIndex(index);
                  },
                  child: Container(
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: controller.paymentIndex.value == index
                              ? redColor
                              : Colors.transparent,
                          width: 4,
                        )),
                    margin: const EdgeInsets.only(bottom: 12),
                    child: Stack(
                      alignment: Alignment.topRight,
                      children: [
                        Image.asset(
                          paymentMethodsImg[index],
                          width: double.infinity,
                          height: 160,
                          colorBlendMode: controller.paymentIndex.value == index
                              ? BlendMode.darken
                              : BlendMode.color,
                          color: controller.paymentIndex.value == index
                              ? Colors.black.withOpacity(0.3)
                              : Colors.transparent,
                          fit: BoxFit.cover,
                        ),
                        controller.paymentIndex.value == index
                            ? Transform.scale(
                                scale: 1.3,
                                child: Checkbox(
                                  activeColor: Colors.green,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  value: true,
                                  onChanged: (value) {},
                                ),
                              )
                            : Container(),
                        Positioned(
                            bottom: 10,
                            right: 10,
                            child: paymentMethodsTxt[index]
                                .text
                                .color(controller.paymentIndex.value == index
                                    ? whiteColor
                                    : darkFontGrey)
                                .fontFamily(semibold)
                                .size(16)
                                .make())
                      ],
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}
