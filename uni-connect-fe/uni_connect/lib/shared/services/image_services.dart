import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

class ImageUploadService {
  static final ImagePicker _picker = ImagePicker();

  // Metodo per selezionare l'immagine
  Future<XFile?> pickImage() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        return XFile(image.path);
      }
    } catch (e) {
      print('Error picking image: $e');
    }
    return null;
  }

  // Metodo per ottenere il percorso di salvataggio
  Future<String> getSavePath(String email, String imageType) async {
    try {
      final String emailPrefix = email.split('@')[0];
      final String directoryPath = path.join('uni_connect','assets/images/people');
      print("Path della directory: "+directoryPath);
      final Directory? directory = await getApplicationDocumentsDirectory();
      print("Directory :"+directory!.path);
      if (!directory.existsSync()) {
        directory.createSync(recursive: true);
      }

      return path.join(directory.path, '$emailPrefix$imageType.jpg');
    } catch (e) {
      print('Error getting save path: $e');
      rethrow;
    }
  }

  // Metodo per salvare l'immagine
  Future<void> saveImage(XFile imageFile, String savePath) async {
    try {
      await imageFile.saveTo(savePath);
      print('Image saved at: $savePath');
    } catch (e) {
      print('Error saving image: $e');
      rethrow;
    }
  }

  // Metodo pubblico per l'upload dell'immagine del profilo
  Future<void> uploadProfileImage(String email) async {
    try {
      XFile? imageFile = await pickImage();
      if (imageFile != null) {
        final String savePath = await getSavePath(email, 'profile');
        await saveImage(imageFile, savePath);
      }
    } catch (e) {
      print('Error uploading profile image: $e');
    }
  }

  // Metodo pubblico per l'upload dell'immagine di copertina
  Future<void> uploadCoverImage(String email) async {
    try {
      XFile? imageFile = await pickImage();
      if (imageFile != null) {
        final String savePath = await getSavePath(email, 'cover');
        await saveImage(imageFile, savePath);
      }
    } catch (e) {
      print('Error uploading cover image: $e');
    }
  }
}
