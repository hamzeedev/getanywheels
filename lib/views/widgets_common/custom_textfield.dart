import 'package:getanywheels/consts/paths.dart';

Widget customTextField({String? title, String? hint, controller, isPass, keyType, picon, siocn}){
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      title!.text.color(myOrange).fontFamily(semibold).size(16).make(),
      5.heightBox,
      TextFormField(

        obscureText: isPass,
        controller: controller,
        keyboardType: keyType,
        
        
       
        decoration: InputDecoration(
          prefixIcon:  picon,
          suffixIcon: siocn,
          hintStyle: const TextStyle(
            fontFamily: semibold,
            color: textfieldGrey,
          ),
          hintText: hint,
          isDense: true,
          fillColor: lightGrey,
          filled:  true,
          border: InputBorder.none,
          focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: myOrange))
        ),
      ),
      10.heightBox,
    ],
  );
}