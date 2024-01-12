

import '../../consts/paths.dart';

Widget applogoWidget(){
  //note:- you can do it also with container
  //we are using velocity x


  return Image.asset(worAppLogo).box.white.size(140, 140).padding(const EdgeInsets.all(0)).rounded.make();
}