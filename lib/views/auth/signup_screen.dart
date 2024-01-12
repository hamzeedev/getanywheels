import 'package:get/get.dart';
import 'package:getanywheels/consts/paths.dart';
import 'package:getanywheels/controllers/auth_controllers.dart';
import 'package:getanywheels/views/home/navigatin_bar.dart';
import 'package:getanywheels/views/widgets_common/applogo_widget.dart';

import '../widgets_common/custom_textfield.dart';
import '../widgets_common/our_button.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool? isCheck = false;

  //controllers...
  var controller = Get.put(AuthController());

  //text controller...
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var passwordRetypeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(
          children: [
            (context.screenHeight * 0.08).heightBox,
            applogoWidget(),
            15.heightBox,
            "Join $appname as a user"
                .text
                .fontFamily(semibold)
                .color(myOrange)
                .size(18)
                .make(),
            15.heightBox,
            Obx(
              () => Column(
                children: [
                  customTextField(
                      hint: nameHint,
                      title: name,
                      controller: nameController,
                      isPass: false),
                  customTextField(
                      hint: emailHint,
                      title: email,
                      controller: emailController,
                      isPass: false),
                  customTextField(
                      hint: passwordHint,
                      title: password,
                      controller: passwordController,
                      isPass: true),
                  customTextField(
                      hint: passwordHint,
                      title: retypePassword,
                      controller: passwordRetypeController,
                      isPass: true),
                  // Align(
                  //   alignment: Alignment.centerRight,
                  //   child: TextButton(
                  //       onPressed: () {}, child: forgetPass.text.make()),
                  // ),
                  Row(
                    children: [
                      Checkbox(
                          activeColor: myOrange,
                          checkColor: whiteColor,
                          value: isCheck,
                          onChanged: (newValue) {
                            setState(() {
                              isCheck = newValue;
                            });
                          }),
                      10.heightBox,
                      Expanded(
                        child: RichText(
                            text: const TextSpan(children: [
                          TextSpan(
                            text: "I agree to the",
                            style: TextStyle(
                              fontFamily: regular,
                              color: fontGrey,
                            ),
                          ),
                          TextSpan(
                              text: termAndCond,
                              style: TextStyle(
                                fontFamily: bold,
                                color: myOrange,
                              )),
                          TextSpan(
                              text: " & ",
                              style: TextStyle(
                                fontFamily: regular,
                                color: fontGrey,
                              )),
                          TextSpan(
                              text: privacyPolicy,
                              style: TextStyle(
                                fontFamily: bold,
                                color: myOrange,
                              )),
                        ])),
                      ),
                    ],
                  ),
                  15.heightBox,
                  //SIGN_UP button...
                  controller.isloading.value
                      ? const CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(redColor),
                        )
                      : ourButton(
                          color: isCheck == true ? myOrange : lightGrey,
                          title: signup,
                          textColor: whiteColor,
                          //applying check condition on checkbox....
                          onPress: () async {
                            if (isCheck != false) {
                              controller.isloading(true);
                              try {
                                await controller
                                    .signupMethod(
                                        context: context,
                                        email: emailController.text,
                                        password: passwordController.text)
                                    .then((value) {
                                  return controller.storeUserData(
                                    email: emailController.text,
                                    password: passwordController.text,
                                    name: nameController.text,
                                  );
                                }).then((value) {
                                  VxToast.show(context, msg: loggedin);
                                  Get.offAll(() => const Home());
                                });
                              } catch (e) {
                                auth.signOut();
                                VxToast.show(context, msg: e.toString());
                                controller.isloading(false);
                              }
                            }
                          },
                        ).box.width(context.screenWidth - 50).make(),
                  10.heightBox,

                  // wrapping with gesture dedector of velocity x...
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      alreadyHaveAccount.text.color(fontGrey).make(),
                      login.text
                          .fontFamily(bold)
                          .color(myOrange)
                          .make()
                          .onTap(() {
                        Get.back();
                      })
                    ],
                  )
                ],
              )
                  .box
                  .white
                  .rounded
                  .padding(const EdgeInsets.all(16))
                  .width(context.screenWidth - 70)
                  .shadowSm
                  .make(),
            ),
          ],
        ),
      ),
    );
  }
}
