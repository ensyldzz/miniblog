class BlogModel {
  final String id;
  final String title;
  final String content;
  final String thumbnail;
  final String author;

  BlogModel({
    required this.id,
    required this.title,
    required this.content,
    required this.thumbnail,
    required this.author,
  });

  factory BlogModel.fromJson(Map<String, dynamic> json) {
    return BlogModel(
      id: json['id'],
      title: json['title'],
      content: json['content'],
      thumbnail: json['thumbnail'],
      author: json['author'],
    );
  }
}
