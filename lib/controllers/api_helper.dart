import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../models/event_model.dart';

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

  //---------------------------------------------------------------------
  Future getEvents() async {
    String url = 'http://192.168.93.1:3333/event/';

    http.Response response = await http.get(Uri.parse(url));

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

  Future getEvent(int id) async {
   
     String url = 'http://192.168.93.1:3333/event/$id';

    http.Response response = await http.get(Uri.parse(url));
   
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

//----------------------------------------
  Future getTags() async {
    String url = 'http://192.168.93.1:3333/tag/';

    http.Response response = await http.get(Uri.parse(url));

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

  Future getTag(int id) async {
   
     String url = 'http://192.168.93.1:3333/tag/$id';

    http.Response response = await http.get(Uri.parse(url));
   
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

//--------------------------------------
 Future getCategorys() async {
    String url = 'http://192.168.93.1:3333/category/';

    http.Response response = await http.get(Uri.parse(url));

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

  Future getCategory(int id) async {
   
     String url = 'http://192.168.93.1:3333/category/$id';

    http.Response response = await http.get(Uri.parse(url));
   
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

//--------------------------------------------


 Future getReports() async {
    String url = 'http://192.168.93.1:3333/report/';

    http.Response response = await http.get(Uri.parse(url));

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

  Future getReport(int id) async {
   
     String url = 'http://192.168.93.1:3333/report/$id';

    http.Response response = await http.get(Uri.parse(url));
   
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
//------------------------------


 Future getImages() async {
    String url = 'http://192.168.93.1:3333/image/';

    http.Response response = await http.get(Uri.parse(url));

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

  Future getImage(int id) async {
   
     String url = 'http://192.168.93.1:3333/image/$id';

    http.Response response = await http.get(Uri.parse(url));
   
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


//   Future postEvent(Event event) async {
//     String url = 'http://192.168.93.1:3333/event/';
//     var uri = Uri.parse(url);
//     //http.Response response = await http.post(Uri.parse(url));

   
//     var jsonBody = jsonEncode({
//       "name": event.name,
//       "description": event.description,
//       "category_id": event.category_id,
//       "organizer_id": event.organizer_id,
//       "start_date": event.start_date,
//       "end_date": event.end_date,
//       "status": event.status,
//       "views": event.views,
//       "capacity": event.capacity,
//       "thanking_message": event.thanking_message,
//     });
//  debugPrint(jsonBody.toString());
//     http.Response response = await http.post(uri, body: 
//     {
//       "name": event.name,
//       "description": event.description,
//       "category_id": event.category_id.toString(),
//       "organizer_id": event.organizer_id.toString(),
//       "start_date": event.start_date,
//       "end_date": event.end_date,
//       "status": event.status,
//       "views": event.views.toString(),
//       "capacity": event.capacity.toString(),
//       "thanking_message": event.thanking_message,
//     }
    
    
//     );
    
//     switch (response.statusCode) {
//       case 201:
//         dynamic jsonObject = jsonDecode(response.body);
//         return jsonObject;
//       case 400:
//         throw "Bad Request";
//       case 401:
//         throw "Unauthrizied";
//       case 402:
//         throw "Payment Required";
//       case 403:
//         throw "Forbidden";
//       case 404:
//         throw "Not Found";
//       case 500:
//         throw "Server Error :(";
//       default:
//        debugPrint(response.statusCode.toString());
//         throw "Server Error :(";
//     }
//   }
}

  // {
        
  //       "name": "My Live Event",
  //       "description": "This is my live event",
  //       "category_id": 2,
  //       "organizer_id": 1,
  //       "start_date": "2023-03-07T03:00:00.000Z",
  //       "end_date": "2023-03-08T11:00:00.000Z",
  //       "status": "available",
  //       "views": 0,
  //       "capacity": 100,
  //       "thanking_message": "Thank you for attending my live event",
  //       "images": []
  //   },

  //    {"name":"New Event",
  //    "description":"A new event",
  //    "category_id":1,
  //    "organizer_id":1,
  //    "start_date":"DateTime.now() as String",
  //    "end_date":" DateTime.now() as String",
  //    "status":"Pending",
  //    "views":0,
  //    "capacity":100,
  //    "thanking_message":"Thank you for registering!"}