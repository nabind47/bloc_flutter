import 'dart:developer';

import 'package:bloc_flutter/features/posts/models/posts_model.dart';
import 'package:http/http.dart' as http;

class PostsRepo {
  static Future<List<PostsModel>> fetchPosts() async {
    var client = http.Client();

    try {
      var response = await client
          .get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));

      final posts = postsModelFromJson(response.body);
      return posts;
    } catch (e) {
      log(e.toString());
      return [];
    }
  }

  static Future<bool> addPost() async {
    var client = http.Client();

    try {
      var response = await client
          .post(Uri.parse('https://jsonplaceholder.typicode.com/posts'), body: {
        "title": "Posting data",
        "body": "Post is not completed",
        "userId": "34"
      });

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      log(e.toString());
      return false;
    }
  }
}
