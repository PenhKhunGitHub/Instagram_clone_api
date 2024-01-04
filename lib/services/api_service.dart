import 'dart:io';
import 'package:dio/dio.dart';

const String baseUrl = 'http://127.0.0.1:8000/api';

class APIService {
  final Dio dio = Dio(BaseOptions(baseUrl: baseUrl, 
  headers: {
    HttpHeaders.acceptHeader: 'application/json',
    HttpHeaders.contentTypeHeader: 'application/json',
  }));

  Future<bool> registerUser(
      {required String name,
      required String email,
      required String password,
      File? profileImage}) async {
    try {
      var formdata = FormData.fromMap({
        "name": name,
        "email": email,
        "password": password,
        "password_confirmation": password,
        "profile_image": profileImage != null
            ? MultipartFile.fromFile(profileImage.path,filename: profileImage.path.split('/').last)
            : null
      });
      final response = await dio.post('/register',
          data: formdata,
          options: Options(
            headers: {"Accept": "application/json"},
            validateStatus: (status) {
              return status! < 500; // Include 422 as a valid status
            },
          )
      );
      print(response.data);
      if (response.statusCode == 200) {
        return true;
      }
      return false;
    } catch (e) {
      throw Exception(e);
    }
  }
}
