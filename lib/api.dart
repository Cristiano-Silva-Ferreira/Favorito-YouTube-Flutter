import 'dart:convert';

import 'package:http/http.dart' as http;

import 'models/video.dart';

const API_KEY = 'AIzaSyDFZLDvp7LzxKmjk0GkgoIr7bOQHzsxekk';

class Api {

  String _searchText;
  String _nextToken;

  Future<List<Video>> search(String searchText) async {

    _searchText = searchText;
   
    http.Response response = await http.get(
      Uri.parse(
        'https://www.googleapis.com/youtube/v3/search?part=snippet&q=$searchText&type=video&key=$API_KEY&maxResults=10'
      )
    );

    return decode(response);
  }

  List<Video> decode(http.Response response) {
    if(response.statusCode == 200) { // data returned OK
      var decoded = json.decode(response.body);

      _nextToken = decoded['nextPageToken'];

      List<Video> videosList = decoded['items'].map<Video>(
        (item) => Video.fromJson(item)
      ).toList();

      return videosList;
    } else {
      throw Exception('Failed to load videos!');
    }
  }

  Future<List<Video>> nextPage() async {   
    http.Response response = await http.get(
      Uri.parse(
        'https://www.googleapis.com/youtube/v3/search?part=snippet&q=$_searchText&type=video&key=$API_KEY&maxResults=10&pageToken=$_nextToken'
      )
    );

    return decode(response);
  }

}