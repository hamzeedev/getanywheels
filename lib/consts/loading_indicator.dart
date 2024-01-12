import 'package:getanywheels/consts/paths.dart';

Widget loadingIndicator (){
  return const CircularProgressIndicator(
    valueColor: AlwaysStoppedAnimation(redColor) ,
  );
}