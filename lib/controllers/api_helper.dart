import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ApiHelper {
  String domain = "192.168.1.24:3333";

  Future get(String path) async {
    Uri uri = Uri.http(domain, path);
    var response = await http.get(uri);
    return responsing(response);
  }

  Future post(String path, {body}) async {
    print(body.toString());
    Uri uri = Uri.http(domain, path);
    var response = await http.post(uri,
        headers: {"Content-Type": "application/json"}, body: body);
    return responsing(response);
  }

  Future put(String path, Map body) async {
    Uri uri = Uri.http(domain, path);
    var response = await http.put(uri, body: body);
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

  responsing(http.Response response) {
    switch (response.statusCode) {
      case 200:
        dynamic jsonObject = jsonDecode(response.body);
        return jsonObject;
      case 400:
        throw "Bad Request";
      case 401:
        throw "Unauthrizied";
      case 402:
        throw "Payment Required";
      case 403:
        throw "Forbidden";
      case 404:
        throw "Not Found";
      case 500:
        throw "Server Error :(";
      default:
        throw "Server Error :(";
    }
  }
}
