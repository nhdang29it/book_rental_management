import 'dart:convert';
import 'package:http/http.dart' as http;

class ElasticService {

  ElasticService({required this.baseUrl, required this.index, required this.type});

  final String baseUrl ;
  final String index ;
  final String type;



  Future<http.Response> searchBooks(String query) async {

    final response = await http.post(
        Uri.https(baseUrl, '$index/$type'),
        headers: <String, String>{
          'Content-type': 'application/json',
          'Authorization': 'apiKey ckNUN0M0b0JHYmVOZlNaMHExeGg6SFByS1JzeWRTRWFhaGZ4S2RId0xIZw=='
        },
      body: jsonEncode({
        "_source": {},
        "query": {
          "bool": {
            "must": [
              {
                "query_string": {
                  "query": query
                }
              }
            ]
          }
        },

        "from": 0,
        "sort": [
          {
            "_score": "desc"
          }
        ]
      })
    );
    return response;
  }

  Future<dynamic> getAllBooks() async {
    final response = await http.post(
        Uri.https(baseUrl, '$index/$type'),
        headers: <String, String>{
          'Content-type': 'application/json',
          'Authorization': 'apiKey ckNUN0M0b0JHYmVOZlNaMHExeGg6SFByS1JzeWRTRWFhaGZ4S2RId0xIZw=='
        },
        body: jsonEncode({
          "query": {
            "match_all": {}
          }
        })
    );
    return jsonDecode(utf8.decode(response.bodyBytes));
  }

  Future<dynamic> getBookByType(String loai) async {
    final response = await http.post(
        Uri.https(baseUrl, '$index/_search'),
        headers: <String, String>{
          'Content-type': 'application/json',
          'Authorization': 'apiKey ckNUN0M0b0JHYmVOZlNaMHExeGg6SFByS1JzeWRTRWFhaGZ4S2RId0xIZw=='
        },
        body: jsonEncode({
          "query": {
            "bool": {
              "must": [
                {
                  "match_all": {}
                }
              ],
              "filter": [
                {
                  "term": {
                    "type": loai
                  }
                }
              ]
            }
          }
        })
    );
    return jsonDecode(utf8.decode(response.bodyBytes));
  }

  Future<dynamic> getBookWithSize(int size) async {
    final response = await http.post(
        Uri.https(baseUrl, '$index/$type'),
        headers: <String, String>{
          'Content-type': 'application/json',
          'Authorization': 'apiKey ckNUN0M0b0JHYmVOZlNaMHExeGg6SFByS1JzeWRTRWFhaGZ4S2RId0xIZw=='
        },
        body: jsonEncode({
          "query": {
            "match_all": {}
          },
          "size": size
        })
    );
    return jsonDecode(utf8.decode(response.bodyBytes));
  }

}