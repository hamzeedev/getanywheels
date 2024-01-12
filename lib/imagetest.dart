import 'dart:io';

import 'package:getanywheels/consts/paths.dart';
import 'package:image_picker/image_picker.dart';

class UploadImageTest extends StatefulWidget {
  const UploadImageTest({super.key});

  @override
  State<UploadImageTest> createState() => _UploadImageTestState();
}

class _UploadImageTestState extends State<UploadImageTest> {
  File? image;
  final picker = ImagePicker();

  Future getImageGallery() async {
    final pickedFile =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 80);
    setState(() {
      if (pickedFile != null) {
        image = File(pickedFile.path);
      } else {
        print('no image picked');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: redColor,
      appBar: AppBar(
        title: const Text("Uploading image"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: InkWell(
                onTap: () {
                  getImageGallery();
                },
                child: Container(
                  height: 200,
                  width: 200,
                  decoration: BoxDecoration(
                      border: Border.all(
                    color: Colors.black,
                  )),
                  child: const Center(
                    child: Icon(Icons.image),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 39,
            ),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(shape: const StadiumBorder()),
              child: const Text('Upload'),
            )
          ],
        ),
      ),
    );
  }
}
