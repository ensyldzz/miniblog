import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:blog_app/product/models/blog_model.dart';
import 'package:blog_app/product/services/blog_services.dart';
import 'package:image_picker/image_picker.dart';

class BlogStateNotifier extends StateNotifier<AsyncValue<List<BlogModel>>> {
  final BlogServices _blogServices;

  BlogStateNotifier(this._blogServices) : super(const AsyncValue.loading()) {
    getBlogs(); // İlk başta blogları yükleyelim
  }

  // Tüm blogları yükleme
  Future<void> getBlogs() async {
    await _handleAsyncOperation(() async {
      final blogs = await _blogServices.getBlog();
      state = AsyncValue.data(blogs);
    });
  }

  // Yeni bir blog ekleme
  Future<void> addBlog(BlogModel blog) async {
    await _handleAsyncOperation(() async {
      final addedBlog = await _blogServices.addBlog(blog);
      state = state.whenData((blogs) => [...blogs, addedBlog]);
    });
  }

  // Blog güncelleme
  Future<void> updateBlog(BlogModel updatedBlog, String id) async {
    await _handleAsyncOperation(() async {
      final updated = await _blogServices.updateBlog(updatedBlog, id);
      state = state.whenData((blogs) {
        return blogs.map((blog) => blog.id == id ? updated : blog).toList();
      });
    });
  }

  // Blog silme
  Future<void> deleteBlog(String id) async {
    await _handleAsyncOperation(() async {
      await _blogServices.deleteBlog(id);
      state = state.whenData((blogs) {
        return blogs.where((blog) => blog.id != id).toList();
      });
    });
  }

  // Asenkron işlemleri merkezi olarak yönetmek için yardımcı fonksiyon
  Future<void> _handleAsyncOperation(Future<void> Function() operation) async {
    try {
      await operation();
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }

  // Blog oluşturma
  Future<void> createBlog({
    required String title,
    required String content,
    required String author,
    XFile? selectedImage,
  }) async {
    await _handleAsyncOperation(() async {
      final success = await _blogServices.createBlog(
        title: title,
        content: content,
        author: author,
        selectedImage: selectedImage,
      );

      if (success) {
        // Yeni blog eklendiğinde mevcut blogları tekrar yükleyin
        getBlogs(); // veya mevcut blog listesini güncelleyin
      }
    });
  }
}

// Riverpod Provider'ları
final blogServiceProvider = Provider<BlogServices>((ref) {
  return BlogServices();
});

final blogNotifierProvider = StateNotifierProvider<BlogStateNotifier, AsyncValue<List<BlogModel>>>((ref) {
  final blogServices = ref.watch(blogServiceProvider);
  return BlogStateNotifier(blogServices);
});
