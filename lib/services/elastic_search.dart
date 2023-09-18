import 'dart:convert';
import 'package:http/http.dart' as http;

class ElasticService {

  ElasticService({required this.baseUrl, required this.index});

  final String baseUrl ;
  final String index ;



  Future<http.Response> searchBooks(String query) async {

    var response = await http.post(
        Uri.https(baseUrl, '$index/_search'),
        headers: <String, String>{
          'Content-type': 'application/json',
          'Authorization': 'apiKey ckNUN0M0b0JHYmVOZlNaMHExeGg6SFByS1JzeWRTRWFhaGZ4S2RId0xIZw=='
        },
      body: jsonEncode({
        "query": {
          "multi_match": {
            "query": query,
            "fields": ["team", "user"]
          }
        }
      })
    );
    return response;
  }

}