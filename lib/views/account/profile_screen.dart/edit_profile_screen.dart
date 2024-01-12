import 'dart:io';

import 'package:get/get.dart';
import 'package:getanywheels/consts/paths.dart';
import 'package:getanywheels/controllers/profile_controller.dart';
import 'package:getanywheels/views/widgets_common/custom_textfield.dart';
import 'package:getanywheels/views/widgets_common/our_button.dart';

class EditProfileScreen extends StatelessWidget {
  final dynamic data;

  const EditProfileScreen({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProfileController>();

    return
        // bgWidget(
        //     child:
        Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(),
      body: Obx(
        () => Column(
          mainAxisSize: MainAxisSize.min,
          children: [
//IMAGE....
            //if data image url and controller path is empty....
            data['imageUrl'] == '' && controller.profilImgPath.isEmpty
                ? Image.asset(
                    profilePic1,
                    width: 80,
                    fit: BoxFit.cover,
                  ).box.roundedFull.clip(Clip.antiAlias).make()
                //if data is not empty but controller path is empty....
                : data['imageUrl'] != '' && controller.profilImgPath.isEmpty
                    ? Image.network(
                        data['imageUrl'],
                        width: 100,
                        fit: BoxFit.cover,
                      ).box.roundedFull.clip(Clip.antiAlias).make()
                    //if both are empty.....
                    : Image.file(
                        File(controller.profilImgPath.value),
                        width: 100,
                        fit: BoxFit.cover,
                      ).box.roundedFull.clip(Clip.antiAlias).make(),
            10.heightBox,
            ourButton(
                color: myOrange,
                onPress: () {
                  controller.changeImage(context);
                },
                textColor: whiteColor,
                title: "Change"),
            20.heightBox,
            const Divider(
              color: myOrange,
            ),
            20.heightBox,
            customTextField(
                controller: controller.nameController,
                hint: nameHint,
                title: name,
                isPass: false),
            10.heightBox,
            customTextField(
                controller: controller.oldpassController,
                hint: passwordHint,
                title: oldpass,
                isPass: true),
            10.heightBox,
            customTextField(
                controller: controller.newpassController,
                hint: passwordHint,
                title: newpass,
                isPass: true),
            20.heightBox,
            controller.isloading.value
                ? const CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(redColor),
                  )
                : SizedBox(
                    width: context.screenWidth - 60,
                    child: ourButton(
                      color: myOrange,
                      onPress: () async {
                        controller.isloading(true);

                        // await controller.uploadProfileImage();
                        // await controller.updateProfile(
                        //   imgUrl: controller.profileImageLink,
                        //   name: controller.nameController.text,
                        //   password: controller.oldpassController.text,
                        // );
                        //  await controller.changeAuthPassword(
                        //   email: data['email'],
                        //   password: controller.oldpassController.text,
                        //   newpassword: controller.newpassController.text,
                        // );
                        // if image is not selected .....
                        ///YAHA MAIN ERROR THA ME YAHA isNotEmpty ki jgha isEmpty use kar raha tha...
                        if (controller.profilImgPath.value.isNotEmpty) {
                          await controller.uploadProfileImage();
                        } else {
                          controller.profileImageLink = data['imageUrl'];
                        }
                        //if old password matches data base...
                        if (data['password'] ==
                            controller.oldpassController.text) {
                          await controller.changeAuthPassword(
                            email: data['email'],
                            password: controller.oldpassController.text,
                            newpassword: controller.newpassController.text,
                          );
                          await controller.updateProfile(
                            imgUrl: controller.profileImageLink,
                            name: controller.nameController.text,
                            password: controller.newpassController.text,
                          );
                          VxToast.show(context, msg: "Updated");
                        } else {
                          VxToast.show(context, msg: "Worng old password");
                          controller.isloading(false);
                        }
                      },
                      textColor: whiteColor,
                      title: "Save",
                    )),
          ],
        )
            .box
            .white
            .shadowSm
            .padding(const EdgeInsets.all(16))
            .margin(const EdgeInsets.only(top: 50, left: 12, right: 12))
            .rounded
            .make(),
      ),
    );
  }
}
