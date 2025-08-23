import 'dart:math';

import 'package:flutter/material.dart';

class BlogListItem extends StatelessWidget {
  const BlogListItem({
    required this.description,
    required this.onTap,
    this.maxLength = null,
    this.title,
    super.key,
  });

  final String? title;
  final String description;
  final VoidCallback onTap;
  final int? maxLength;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: title == null ? null : Text(title!),
        subtitle: Text(
          description.substring(
            0,
            min(description.length, maxLength ?? description.length),
          ),
        ),
        onTap: onTap,
      ),
    );
  }
}
