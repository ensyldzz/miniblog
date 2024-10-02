import 'dart:convert';
import 'package:blog_app/product/models/blog_model.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

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

  Future<bool> createBlog({
    required String title,
    required String content,
    required String author,
    XFile? selectedImage,
  }) async {
    Uri url = Uri.parse("https://tobetoapi.halitkalayci.com/api/Articles");

    var request = http.MultipartRequest("POST", url);
    request.fields["Title"] = title;
    request.fields["Content"] = content;
    request.fields["Author"] = author;

    if (selectedImage != null) {
      final file = await http.MultipartFile.fromPath("File", selectedImage.path);
      request.files.add(file);
    } else {
      throw Exception('Resim seçilmedi!');
    }

    final response = await request.send();

    return response.statusCode == 201; // Başarılı eklenme durumunu döner
  }
}
