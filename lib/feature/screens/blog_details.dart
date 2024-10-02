import 'package:blog_app/product/constants/constants.dart';
import 'package:blog_app/product/constants/colors_items.dart';
import 'package:blog_app/feature/screens/pages.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BlogDetails extends StatefulWidget {
  final String blogTitle;
  final String blogContent;
  final String imagePath;
  final String authorName;

  const BlogDetails(
      {super.key,
      required this.blogTitle,
      required this.blogContent,
      required this.imagePath,
      required this.authorName});

  @override
  State<BlogDetails> createState() => _BlogDetailsState();
}

class _BlogDetailsState extends State<BlogDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsItems.homeBackgroundColor,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.arrow_back_ios_rounded)),
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
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.only(left: 10, bottom: 5),
            height: 300,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              border: const Border(bottom: BorderSide(width: 10), top: BorderSide(width: 4)),
              borderRadius: const BorderRadius.only(bottomRight: Radius.circular(50), topLeft: Radius.circular(50)),
              image: DecorationImage(
                image: NetworkImage(
                  widget.imagePath,
                ),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.blogTitle,
                  style: GoogleFonts.poppins(
                    color: ColorsItems.themeColor,
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.person_rounded,
                      color: ColorsItems.themeColor,
                    ),
                    Text(
                      widget.authorName,
                      style: GoogleFonts.poppins(
                        color: ColorsItems.themeColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
              height: ScreenUtil.getHeight(context) * 0.50,
              width: ScreenUtil.getWidth(context),
              decoration: const BoxDecoration(
                border: Border(
                  top: BorderSide(width: 2, color: ColorsItems.themeColor),
                ),
              ),
              child: SingleChildScrollView(
                child: Text(
                  widget.blogContent,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
