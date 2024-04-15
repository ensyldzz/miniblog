import 'package:blog_app/pages/pages.dart';
import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final String blogTitle;
  final String blogContent;
  final String imagePath;
  final String authorName;
  final bool isLastAdded;
  const CustomCard({
    super.key,
    this.isLastAdded = false,
    required this.blogTitle,
    required this.blogContent,
    required this.imagePath,
    required this.authorName,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
      child: Card(
        color: const Color.fromARGB(255, 124, 77, 255),
        child: ListTile(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BlogDetails(
                    blogTitle: blogTitle, blogContent: blogContent, imagePath: imagePath, authorName: authorName),
              ),
            );
          },
          title: Text(blogTitle),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                blogContent,
                maxLines: 4,
              ),
              Text(
                authorName,
                style: const TextStyle(color: Colors.white),
              )
            ],
          ),
          leading: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 2),
                  borderRadius: BorderRadiusDirectional.circular(10),
                  image: DecorationImage(image: NetworkImage(imagePath), fit: BoxFit.cover)),
              height: 100,
              width: 100,
            ),
          ),
          trailing: const Icon(Icons.chevron_right),
        ),
      ),
    );
  }
}
