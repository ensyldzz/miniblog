import 'dart:convert';
import 'package:blog_app/product/models/blog_model.dart';
import 'package:http/http.dart' as http;

class BlogServices {
  final String url = "https://tobetoapi.halitkalayci.com/api/Articles";

  Future<List<BlogModel>> getBlog() async {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => BlogModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load articles');
    }
  }

  Future<BlogModel> addBlog(BlogModel blog) async {
    final response = await http.post(Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'id': blog.id,
          'title': blog.title,
          'content': blog.content,
          'thumbnail': blog.thumbnail,
          'author': blog.author,
        }));
    if (response.statusCode == 201) {
      return BlogModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create blog');
    }
  }

  Future<BlogModel> updateBlog(BlogModel blog, String id) async {
    final response = await http.put(Uri.parse('$url/$id'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'id': blog.id,
          'title': blog.title,
          'content': blog.content,
          'thumbnail': blog.thumbnail,
          'author': blog.author,
        }));
    if (response.statusCode == 200) {
      return BlogModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to update');
    }
  }

  Future<void> deleteBlog(String id) async {
    final response = await http.delete(Uri.parse('$url/$id'));
    if (response.statusCode != 204) {
      throw Exception('Failed to delete blog');
    }
  }
}
