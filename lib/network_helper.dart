import 'package:http/http.dart' as http;
import 'dart:convert';

class networkHelper {
  String url;
  networkHelper({required this.url});
  dynamic fetchData() async {
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = await jsonDecode(response.body);
        print(data);
        print("succssess");
        return data;

        // process the data here
      } else {
        print("unsucsseful");

        // handle the error case
      }
    } catch (error) {
      print("errooorrr");
      print(error);

      // handle any exceptions thrown during the request
    }
  }
}
