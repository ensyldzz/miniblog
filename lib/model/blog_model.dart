class BlogPost {
  final String id;
  final String title;
  final String content;
  final String thumbnail;
  final String author;

  BlogPost({
    required this.id,
    required this.title,
    required this.content,
    required this.thumbnail,
    required this.author,
  });

  factory BlogPost.fromJson(Map<String, dynamic> json) {
    return BlogPost(
      id: json['id'],
      title: json['title'],
      content: json['content'],
      thumbnail: json['thumbnail'],
      author: json['author'],
    );
  }
}
