import 'package:blog_app/model/blog_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class BlogProvider extends ChangeNotifier {
  final String apiUrl = "https://intent-kit-16.hasura.app/api/rest/blogs";
  final String hasuraAccessKey =
      "32qR4KmXOIpsGPQKMqEJHGJS27G5s7HdSKO3gdtQd2kv5e852SiYwWNfxkZOBuQ6";
      
  Future<List<Blog>> fetchBlogs() async {
    final response = await http.get(
      Uri.parse(apiUrl),
      headers: {
        'x-hasura-access-key': hasuraAccessKey,
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> blogsData = data['blogs'];

      return blogsData
          .map((json) => Blog.fromJson(json))
          .toList(); // Return the list of blogs.
    } else {
      throw Exception('Failed to load blogs');
    }
  }
}
