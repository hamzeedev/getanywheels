import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:getanywheels/consts/paths.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

import 'views/splash_screen.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //used GetMaterialApp bcz of Getx...
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: appname,
      // themeMode: ThemeMode.dark,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.transparent,
        appBarTheme: const AppBarTheme(
          //setting same color for intire app
          iconTheme: IconThemeData(
            color: darkFontGrey,
          ),
          elevation: 0.0,
          backgroundColor: Colors.transparent
          ),
        fontFamily: regular,
      ),
      home:  
      const
      //OnBoardingScreen()
        SplashScreen()
      ,
    );
  }
}
