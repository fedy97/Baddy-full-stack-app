...
import 'package:firebase_storage/firebase_storage.dart';
...

class Apis {
  ...
  static Future<String> uploadImage(
      {@required PickedFile image,
      @required String username,
      @required int timestamp,
      @required String jwt}) async {
    try {
      File imageFile = File(image.path);
      String path = _createPath(username, timestamp.toString());
      final storageRef = FirebaseStorage.instance.ref().child(path); 
      await storageRef.putFile(imageFile);
      final url = await storageRef.getDownloadURL();
      var dio = Dio();
      await dio.patch(URL + usersRoute + "/updateDetails",
          data: {"photo": url},
          options: Options(headers: {'Authorization': 'Bearer $jwt'}));
      return url;
    } on DioError catch (e) {
      print(e.response);
      return "default.jpg";
    } catch (e) {
      print(e);
      return "default.jpg";
    }
  }

  static String _createPath(String username, String timestamp) {
    //mail/timestampRecord/imagesList
    return "$username/$timestamp/" + "photo.jpg";
  }
  ...
}
