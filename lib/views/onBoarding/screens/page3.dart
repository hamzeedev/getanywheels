import 'package:getanywheels/consts/paths.dart';

class PageThree extends StatelessWidget {
  const PageThree({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          "WHEELS ON RENT"
              .text
              .center
              .fontFamily(bold)
              .size(24)
              .color(myOrange)
              .make(),
          Center(
            child: SizedBox(
              width: 400,
              child: Image.asset("assets/images/wor_splash3.png"),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          "We show the easy way to hire vehicles. \nJust stay at home with us"
              .text
              .center
              .fontFamily(bold)
              .color(fontGrey)
              .make()
        ],
      ),
    );
  }
}
