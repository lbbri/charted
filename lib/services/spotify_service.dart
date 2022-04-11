//import 'dart:async';
//import 'dart:convert' as convert;
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:oauth2/oauth2.dart' as oauth2;

import 'package:cloud_firestore/cloud_firestore.dart';

class SpotifyService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  SpotifyService();

  void testConnection() async {
    const clientId = "733e1c8e6ac243d5a7540c6ad1aaf335";
    const clientSecret = "db6abf47d51248e9b261d37da49b0fac";
    const redirect = "charted-login://callback";
    const scopes =
        "user-read-recently-played, user-library-read, playlist-read-private, user-read-private, user-read-email";

    var query = {
      'response_type': 'code',
      'client_id': clientId,
      'scope': scopes,
      'redirect_uri': redirect,
      'show_dialog': 'true',
    };

    var url = Uri.https("accounts.spotify.com", "/authorize");
    // Await the http get response, then decode the json-formatted response.
    //var response = await http.post(url);
    var response = await http.get(url, headers: query);

    if (response.statusCode == 200) {
      print('sucess');
      print(response.body);
      // final token = Uri.parse(response).queryParameters['token'];
      // final idk = oauth2.

    } else {
      print('failure');
      print(response.statusCode);
    }
  }
}



    // AUTH_URL = "https://accounts.spotify.com/api/token"
    // data = {
    //     "grant_type": "client_credentials",
    //     "client_id": os.getenv("SPOTIFY_CLIENT_ID"),
    //     "client_secret": os.getenv("SPOTIFY_CLIENT_SECRET"),
    // }
    // auth_response = requests.post(AUTH_URL, data)

    // auth_response_data = auth_response.json()
    // access_token = auth_response_data["access_token"]
    // return access_token
