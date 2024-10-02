import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:blog_app/product/models/blog_model.dart'; // BlogPost model dosyanızın yolu
import 'package:blog_app/product/services/blog_services.dart'; // Servis dosyanızın yolu

final blogServiceProvider = Provider<BlogServices>((ref) {
  return BlogServices();
});

final blogProvider = FutureProvider<List<BlogModel>>((ref) async {
  final blogServices = ref.watch(blogServiceProvider);
  return blogServices.getBlog();
});
