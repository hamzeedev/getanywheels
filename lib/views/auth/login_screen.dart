import 'package:get/get.dart';
import 'package:getanywheels/consts/paths.dart';
import 'package:getanywheels/controllers/auth_controllers.dart';
import 'package:getanywheels/views/auth/signup_screen.dart';
import 'package:getanywheels/views/home/navigatin_bar.dart';
import 'package:getanywheels/views/widgets_common/applogo_widget.dart';
import 'package:getanywheels/views/widgets_common/custom_textfield.dart';
import 'package:getanywheels/views/widgets_common/our_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool passwordObsecured = true;
  @override
  Widget build(BuildContext context) {
    var controller = Get.put(AuthController());
    return Scaffold(
      backgroundColor: whiteColor,
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(
          children: [
            (context.screenHeight * 0.10).heightBox,
            applogoWidget(),
            15.heightBox,
            "Log in to $appname"
                .text
                .fontFamily(bold)
                .color(myOrange)
                .size(18)
                .make(),
            15.heightBox,
            Obx(
              () => Column(
                children: [
                  customTextField(
                      picon: const Icon(
                        Icons.email,
                        color: Color(0xffEE9120),
                      ),
                      hint: emailHint,
                      title: email,
                      isPass: false,
                      controller: controller.emailController),

                  customTextField(
                      hint: passwordHint,
                      title: password,
                      isPass: passwordObsecured,
                      picon: const Icon(
                        Icons.password,
                        color: Color(0xffEE9120),
                      ),
                      //PASSWORD VISIBILITY....
                      siocn: IconButton(
                          color: passwordObsecured ? myBlack : myOrange,
                          onPressed: () {
                            setState(() {
                              passwordObsecured = !passwordObsecured;
                            });
                          },
                          icon: Icon(
                            passwordObsecured
                                ? Icons.visibility_off
                                : Icons.visibility,
                          )),
                      controller: controller.passwordController),
                  // Align(
                  //   alignment: Alignment.centerRight,
                  //   child: TextButton(
                  //       onPressed: () {}, child: forgetPass.text.bold.color(fontGrey).make()),
                  // ),
                  10.heightBox,
                  //login button...
                  controller.isloading.value
                      ? const CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(myOrange),
                        )
                      : ourButton(
                          color: myOrange,
                          title: login,
                          textColor: whiteColor,
                          onPress: () async {
                            controller.isloading(true);
                            await controller
                                .loginMethod(context: context)
                                .then((value) {
                              if (value != null) {
                                VxToast.show(context, msg: loggedin);
                                Get.offAll(() => const Home());
                              } else {
                                controller.isloading(false);
                              }
                            });
                          }).box.width(context.screenWidth - 50).make(),
                  6.heightBox,
                  or.text.color(fontGrey).make(),
                  6.heightBox,
                  //google button...
                  // SizedBox(
                  //   width: double.infinity,
                  //   child: OutlinedButton.icon(
                  //     icon: Image.asset(
                  //       icGoogleLogo,
                  //       width: 30,
                  //     ),
                  //     onPressed: (){}, 
                  //     label: const Text(loginwitG, style: TextStyle(color: fontGrey),) 
                  //     ),
                  // ),
                  // 10.heightBox,
                  TextButton(
                    onPressed: (){
                      Get.to(() => const SignupScreen());
                    }, 
                    child: const Text.rich(
                      TextSpan(
                        text: donthaveaccount,
                        style: TextStyle(color: fontGrey,fontFamily: bold),
                        children: [
                          TextSpan(
                            text: signup,
                            style: TextStyle(color: myOrange, fontFamily: bold)
                          )
                        ]
                        
                      )

                    )
                    )
                
                  
                ],
              )
                  .box
                  .white
                  .rounded
                  .padding(const EdgeInsets.all(14))
                  .width(context.screenWidth - 40)
                  .shadowSm
                  .make(),
            ),
          ],
        ),
      ),
    );
  }
}
