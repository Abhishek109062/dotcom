import 'dart:convert';
import 'dart:io';

import 'package:dot_com/constants.dart';
import 'package:dot_com/core/error/failure.dart';
import 'package:fpdart/fpdart.dart';
import 'package:image_picker/image_picker.dart';
import "package:http/http.dart" as http;
import 'package:shared_preferences/shared_preferences.dart';

Future<Either<Failure, File>> getImageFromGallery() async {
  try {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      File image = File(pickedFile.path);

      int fileSize = await image.length();
      double fileSizeInMb = fileSize / (1024 * 1024); // Convert bytes to MB

      if (fileSizeInMb > 5) {
        return left(Failure('Image size exceeds 5 MB limit'));
      }
      return right(image);
    }
    return left(Failure(""));
  } catch (err) {
    return left(Failure("Something went wrong"));
  }
}

Future<Either<Failure, String>> uploadImage(File image) async {
  try {
    final url = Uri.parse('${ApiConstants.baseUrl}/dotcom/upload/file');
    final request = http.MultipartRequest("POST", url);
    final file = await http.MultipartFile.fromPath("file", image.path);
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String accessToken = prefs.getString('token')!;
    request.files.add(file);
    request.headers["Authorization"] = "Bearer $accessToken";
    request.headers["Content-Type"] = "multipart/form-data";
    final response = await request.send();
    final responseString = await response.stream.bytesToString();
    if (response.statusCode == 200) {
      return right(jsonDecode(responseString));
    }
    return left(Failure("Upload Failed. Please Try Again"));
  } catch (err) {
    return left(Failure("Upload Failed. Please Try Again"));
  }
}
