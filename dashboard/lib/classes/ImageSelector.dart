import 'package:image_picker/image_picker.dart';
import 'dart:io';
class ImageSelector {
  Future<File> selectImage() async {
    // ignore: deprecated_member_use
    return await ImagePicker.pickImage(source: ImageSource.gallery);
  }

}