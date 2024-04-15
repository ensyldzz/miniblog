import 'dart:convert';
import 'package:blog_app/model/blog_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class BlogServices {
  final String apiUrl = "https://tobetoapi.halitkalayci.com/api/Articles";

  Future<List<BlogPost>> getBlog() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      debugPrint(data.toString());

      return data.map((json) => BlogPost.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load articles');
    }
  }
}
