class Content {
  final String name;
  final String content;

  Content({
    required this.name,
    required this.content,
  });

  factory Content.fromJson(Map<String, dynamic> json) {
    return Content(
      name: json['name'],
      content: json['content'],
    );
  }
}
