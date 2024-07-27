import 'package:flutter/services.dart';

import 'package:image_picker/image_picker.dart';

class ImageService {
  static final _picker = ImagePicker();

  static Future<Uint8List?> pickImageFromGallery() async {
    XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    return image != null ? await image.readAsBytes() : null;
  }

  static Future<Uint8List?> pickImageFromCamera() async {
    XFile? image = await _picker.pickImage(source: ImageSource.camera);
    return image != null ? await image.readAsBytes() : null;
  }
}
