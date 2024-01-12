import 'package:getanywheels/consts/paths.dart';

class PageTwo extends StatelessWidget {
  const PageTwo({super.key});

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
            height: 130,
          ),
          Center(
            child: SizedBox(
              width: 400,
              child: Image.asset("assets/images/wor_splash2.png"),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          "We help people to digitalise\nthere rental bussines around Pakistan"
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
