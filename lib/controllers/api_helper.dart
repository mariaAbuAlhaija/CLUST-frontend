import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ApiHelper {
  String domain = "192.168.107.202:3333";
  // 192.168.8.120 - 192.168.67.249
  Future get(String path, {body}) async {
    Uri uri = Uri.http(domain, path, body);
    var token = await getToken();
    var headers = {"Authorization": token};
    var response = await http.get(uri, headers: headers);
    return responsing(response);
  }

  Future post(String path, {body}) async {
    print(body.toString());
    Uri uri = Uri.http(domain, path);
    var response = await http.post(uri, body: body);
    return responsing(response);
  }

  Future postAuth(String path, {Map<String, dynamic>? body}) async {
    Uri uri = Uri.http(domain, path);

    var token = await getToken();
    var headers = {"Authorization": token};
    var response = await http.post(uri, body: body, headers: headers);
    return responsing(response);
  }

  Future put(String path, Map body) async {
    Uri uri = Uri.http(domain, path);
    var token = await getToken();
    var headers = {"Authorization": token};
    var response = await http.put(uri, body: body, headers: headers);
    return responsing(response);
  }

  Future delete(String path) async {
    Uri uri = Uri.http(domain, path);
    var response = await http.delete(uri);
    return responsing(response);
  }

  Future<String> getToken() async {
    var storage = FlutterSecureStorage();
    String result = await storage.read(key: "token") as String;
    return result;
  }

  Future uploadImageDio(File file, urlPath) async {
    final dio = Dio();

    var token = await getToken();
    var headers = {"Authorization": token};

    FormData formData = FormData.fromMap({
      "image_file": await MultipartFile.fromFile(file.path,
          filename: file.path.split("/").last)
    });
    print("object");
    Response response = await dio.post(
      'http://$domain$urlPath',
      data: formData,
      options: Options(
        followRedirects: false,
        validateStatus: (status) {
          return status! < 500;
        },
        headers: headers,
      ),
    );
    print("$response");
  }

  Future uploadImage(File file, urlPath) async {
    var token = await getToken();
    var headers = {"Authorization": token};

    Uri uri = Uri.http(domain, urlPath);

    // FormData formData = FormData.fromMap({
    //   "image_file": await MultipartFile.fromFile(file.path,
    //       filename: file.path.split("/").last)
    // });
    // var response = await http.post(
    //   uri,
    //   body: {'image': formData},
    // );
    var request = http.MultipartRequest('POST', uri);
    request.files.add(await http.MultipartFile.fromPath('image', file.path));

    var response = await request.send();
    var responseBody = await response.stream.bytesToString();
    print(responseBody);
    return (jsonDecode(responseBody));
  }

  responsing(http.Response response) {
    switch (response.statusCode) {
      case 200:
        dynamic jsonObject = jsonDecode(response.body);
        return jsonObject;
      case 400:
        throw "${response.statusCode}: Bad Request\nResponse Body\n${response.body}";
      case 401:
        throw "${response.statusCode}: Unauthrizied\nResponse Body\n${response.body}";
      case 402:
        throw "${response.statusCode}: Payment Required\nResponse Body\n${response.body}";
      case 403:
        throw "${response.statusCode}: Forbidden\nResponse Body\n${response.body}";
      case 404:
        throw "${response.statusCode}: Not Found\nResponse Body\n${response.body}";
      case 500:
        throw "${response.statusCode}: Server Error :(\nResponse Body\n${response.body}";
      default:
        throw "${response.statusCode}: Server Error :(\nResponse Body\n${response.body}";
    }
  }
}
