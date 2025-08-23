class Blog {
  Blog({
    required this.id,
    required this.title,
    required this.content,
    required this.createdAt,
  });

  final int id;
  final String? title;
  final String content;
  final DateTime? createdAt;

  @override
  String toString() {
    return 'Blog(id: $id, title: $title, content: $content, createdAt: $createdAt)';
  }
}
