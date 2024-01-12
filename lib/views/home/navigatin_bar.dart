import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:getanywheels/consts/paths.dart';
import 'package:getanywheels/controllers/home_controller.dart';
import 'package:getanywheels/views/booking/proceed_bookin_screen.dart';
import 'package:getanywheels/views/category_screen/category_screen.dart';
import 'package:getanywheels/views/home/home_screen.dart';
import 'package:getanywheels/views/account/profile_screen.dart/profile_screen.dart';
import 'package:getanywheels/views/widgets_common/exit_dialog.dart';


class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    //init home controller...
    var controller = Get.put(HomeController());

    var navbarItem = [
      BottomNavigationBarItem(
          icon: Image.asset(
            icHome,
            width: 26,
            color: fontGrey,
          ),
          label: home),
      BottomNavigationBarItem(
          icon: Image.asset(
            icCategories,
            width: 26,
            color: fontGrey,
          ),
          label: categories),
      BottomNavigationBarItem(
          icon: Image.asset(
            icOrders,
            width: 26,
            color: fontGrey,
          ),
          label: bookings),
      BottomNavigationBarItem(
          icon: 
          Image.asset(
            icProfile,
            width: 26,
            color: fontGrey,
            
            
          ),
          label: account),
    ];

    var navBody = [
      const HomeScreen(),
      const CategoryScreen(),
      const ProceedBookingScreen(),
      const ProfileScreen(),
    ];

//this willpopscope popup message before exiting.....
    return WillPopScope(
      onWillPop: () async {
        showDialog(
          barrierDismissible: false,
          context: context, 
          builder: (context) => exitDialog(context));
        return false;
      },
      child: Scaffold(
        body: Column(
          children: [
            Obx(() => Expanded(
                  child: navBody.elementAt(controller.currentNavIndex.value),
                )),
          ],
        ),
        bottomNavigationBar: Obx(
          () => BottomNavigationBar(
            currentIndex: controller.currentNavIndex.value,
            selectedItemColor: myOrange,
            selectedLabelStyle: const TextStyle(fontFamily: bold), 
            type: BottomNavigationBarType.fixed,
            backgroundColor: whiteColor,
            items: navbarItem,
            onTap: (value) {
              controller.currentNavIndex.value = value;
            },
          ),
        ),
      ),
    );
  }
}
