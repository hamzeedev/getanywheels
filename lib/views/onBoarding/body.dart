import 'package:get/get.dart';
import 'package:getanywheels/consts/paths.dart';
import 'package:getanywheels/views/auth/login_screen.dart';
import 'package:getanywheels/views/onBoarding/screens/page1.dart';
import 'package:getanywheels/views/onBoarding/screens/page2.dart';
import 'package:getanywheels/views/onBoarding/screens/page3.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

PageController controller = PageController();
bool onLastPage = false;

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        PageView(
          controller: controller,
          onPageChanged: (index){
            setState(() {
              onLastPage = (index == 2);
            });
          },
          children: const [PageOne(), PageTwo(), PageThree()],
        ),
        Container(
            alignment: const Alignment(0, 0.75),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                 onLastPage 
               ? 
                GestureDetector(
                   onTap: (){

                    
                    
                  },
                  child: const Text(" "))
                  :

                 GestureDetector(
                  onTap: (){
                    controller.jumpToPage(2,);
                  },
                  child: "Skip".text.fontFamily(bold).color(fontGrey).make()
                  ),
                SmoothPageIndicator(controller: controller,count: 3,),
               
               onLastPage 
               ? 
                GestureDetector(
                   onTap: (){

                     Get.to(() => const LoginScreen());
                    
                  },
                  child: "Continue".text.fontFamily(bold).color(fontGrey).make()
                  )
                  :
                  GestureDetector(
                   onTap: (){
                    controller.nextPage(duration: const Duration(milliseconds: 500), curve: Curves.easeInCubic);
                  },
                  child: "Next".text.fontFamily(bold).color(fontGrey).make()
                  ),
              ],
            ))
      ]),
    );
  }
}
