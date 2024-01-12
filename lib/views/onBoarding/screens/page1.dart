import 'package:getanywheels/consts/paths.dart';

class PageOne extends StatelessWidget {
  const PageOne({super.key});

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
          const SizedBox(
            height: 160,
          ),
          Center(
            child: SizedBox(
              width: 400,
              child: Image.asset("assets/images/wor_splash1.png"),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          "Welcome to Wheels on Rent, Let’s hire!"
              .text
              .fontFamily(bold)
              .color(fontGrey)
              .make()
        ],
      ),
    );
  }
}
