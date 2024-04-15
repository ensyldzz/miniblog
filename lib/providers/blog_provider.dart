import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:blog_app/model/blog_model.dart'; // BlogPost model dosyanızın yolu
import 'package:blog_app/services/blog_services.dart'; // Servis dosyanızın yolu

final blogServiceProvider = Provider<BlogServices>((ref) {
  return BlogServices();
});

final blogProvider = FutureProvider<List<BlogPost>>((ref) async {
  final blogServices = ref.watch(blogServiceProvider);
  return blogServices.getBlog();
});
