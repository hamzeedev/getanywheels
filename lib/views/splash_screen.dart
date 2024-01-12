import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:getanywheels/controllers/splash_controller.dart';
import 'package:getanywheels/views/home/navigatin_bar.dart';
import 'package:getanywheels/views/onBoarding/body.dart';

import '../consts/paths.dart';
class SplashScreen extends StatefulWidget {
  
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  //creating method to change screen
  changeScreen(){
    Future.delayed( const Duration(seconds: 5), (){
      //using getX
      // Get.to(()=>  const LoginScreen());

      auth.authStateChanges().listen((User? user) {
        if (user == null && mounted) {
          Get.to(() => const OnBoardingScreen());
        } else {
          Get.to(()=> const Home());
        }
       });

    });
  }

@override
  void initState() {
    changeScreen();
    super.initState();
  }
  final splashController = Get.put(SplashScreenController());

  @override
  Widget build(BuildContext context) {
     splashController.startAnimation();

    return Scaffold(
        backgroundColor: myWhite,
        body: Stack(
          children: [
            //arrow...
            Obx(
              () => AnimatedPositioned(
                  duration: const Duration(milliseconds: 1600),
                  top: splashController.animate.value ? 0 : -180,
                  left: splashController.animate.value ? 0 : -180,
                  child: Align(
                      alignment: Alignment.topLeft,
                      child: Image.asset(
                        icSplashBg,
                        width: 280,
                      ))),
            ),
            //logo....
            Obx(
              () => AnimatedPositioned(
                  duration: const Duration(milliseconds: 1600),
                  bottom: splashController.animate.value ? 450 : 400,
                  left: 120,
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 2400),
                    opacity: splashController.animate.value ? 1 : 0,
                    child: Align(
                        alignment: Alignment.topLeft,
                        child: Image.asset(
                          worAppLogo,
                          width: 180,
                        )),
                  )),
            ),
            // TEXT app name...
            Obx(
              () => AnimatedPositioned(
                  duration: const Duration(milliseconds: 1600),
                  bottom: 380,
                  left: splashController.animate.value ? 134 : 0,
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 2400),
                    opacity: splashController.animate.value ? 1 : 0,
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          appname,
                          style: TextStyle(fontFamily: bold, fontSize: 22),
                        ),
                      ],
                    ),
                  )),
            ),
            // TEXT slang...
            Obx(
              () => AnimatedPositioned(
                  duration: const Duration(milliseconds: 1600),
                  bottom: 360,
                  right: splashController.animate.value ? 80 : 0,
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 2400),
                    opacity: splashController.animate.value ? 1 : 0,
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          appslang,
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  )),
            ),
            // TEXT version...
             Obx(
              () => AnimatedPositioned(
                  duration: const Duration(milliseconds: 1600),
                  bottom: splashController.animate.value ? 340 : 240,
                  right: 170,
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 2400),
                    opacity: splashController.animate.value ? 1 : 0,
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          appversion,
                          style: TextStyle(fontSize: 14, color: fontGrey),
                        ),
                      ],
                    ),
                  )),
            ),
            // TEXT credits...
            Obx(
              () => AnimatedPositioned(
                  duration: const Duration(milliseconds: 1600),
                  bottom: splashController.animate.value ? 40 : 0,
                  right: 142,
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 2400),
                    opacity: splashController.animate.value ? 1 : 0,
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          credits,
                          style: TextStyle(fontSize: 16, color: fontGrey),
                        ),
                      ],
                    ),
                  )),
            ),
          ],
        ));

  }
}