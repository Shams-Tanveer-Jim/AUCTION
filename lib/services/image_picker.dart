import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;

class ImagePickerService {
  static final picker = ImagePicker();

  static Future<Map<String, dynamic>> pickImage(ImageSource source) async {
    final pickedFile = await picker.pickImage(source: source, imageQuality: 50);

    if (pickedFile == null) return {};

    final imageTemp = File(pickedFile.path);
    final fileName = path.basename(imageTemp.path);
    return {"name": fileName, "file": imageTemp};
  }

  static Future<String> getDownLoadableUrl(String fileName, File file) async {
    Reference ref = FirebaseStorage.instance
        .ref()
        .child(DateTime.now().microsecondsSinceEpoch.toString() + fileName);
    UploadTask uploadTask = ref.putFile(file);
    var imageUrl = await (await uploadTask).ref.getDownloadURL();
    return imageUrl;
  }
}
