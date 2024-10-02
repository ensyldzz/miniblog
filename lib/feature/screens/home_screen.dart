import 'package:blog_app/product/constants/colors_items.dart';
import 'package:blog_app/feature/screens/pages.dart';
import 'package:blog_app/product/services/blog_state_notifier.dart';
import 'package:blog_app/product/widgets/custom_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsItems.homeBackgroundColor,
      appBar: AppBar(
        title: const Text('Hoşgeldiniz'),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.edit_square,
              size: 30,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const BlogEditScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Consumer(
          builder: (context, ref, child) {
            final blogs = ref.watch(blogNotifierProvider);
            return blogs.when(
              loading: () => const Center(
                child: CircularProgressIndicator(),
              ),
              error: (error, stackTrace) => Center(child: Text('Error: $error')),
              data: (blogs) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        'Blog Yazıları',
                        style: GoogleFonts.poppins(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemBuilder: (ctx, index) => CustomCard(
                            blogTitle: blogs[index].title,
                            blogContent: blogs[index].content,
                            imagePath: blogs[index].thumbnail,
                            authorName: blogs[index].author),
                        itemCount: blogs.length,
                      ),
                    ),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}
