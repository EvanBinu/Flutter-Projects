import 'package:http/http.dart' as http;
import 'dart:convert';

class NetWorkHelper {
  NetWorkHelper(this.url);

  final String url;

  Future<dynamic> getData() async {
    Uri uri = Uri.parse(url);  // Convert String to Uri
    http.Response response = await http.get(uri);

    if (response.statusCode == 200) {
      String data = response.body;
      return jsonDecode(data);  // Decode and return JSON data
    } else {
      throw Exception("Failed to load data: ${response.statusCode}");
    }
  }
}
