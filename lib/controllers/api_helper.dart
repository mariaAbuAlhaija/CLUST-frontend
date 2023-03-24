import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiHelper {
  ApiHelper({required this.domain});
  String domain = "jsonplaceholder.typicode.com";

  //! functions down are kept as examples
  Future getPosts() async {
    Uri uri = Uri.https(domain, "posts");
    var response = await http.get(uri);
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

  Future getPost(int id) async {
    Uri uri = Uri.https("jsonplaceholder.typicode.com", "posts/$id");
    var response = await http.get(uri);
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

  Future getcomments(int id) async {
    Uri uri = Uri.https("jsonplaceholder.typicode.com", "posts/$id/comments");
    var response = await http.get(uri);
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
