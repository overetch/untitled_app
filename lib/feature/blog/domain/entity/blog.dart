class Blog {
  Blog({
    required this.title,
    required this.content,
    required this.createdAt,
  });

  final String? title;
  final String content;
  final DateTime? createdAt;

  @override
  String toString() {
    return 'Blog(title: $title, content: $content, createdAt: $createdAt)';
  }
}
