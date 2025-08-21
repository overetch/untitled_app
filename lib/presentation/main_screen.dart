import 'package:flutter/material.dart';
import 'package:untitled/core/di/di_container.dart';
import 'package:untitled/feature/blog/data/repository/blog_repository_impl.dart';
import 'package:untitled/feature/blog/domain/entity/blog.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const _MainScreen();
  }
}

class _MainScreen extends StatefulWidget {
  const _MainScreen({super.key});

  @override
  State<_MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<_MainScreen> {
  @override
  void initState() {
    test();
    super.initState();
  }

  void test() async {
    BlogRepositoryImpl blogRepo = BlogRepositoryImpl(DIContainer().get());
    final blogs = await blogRepo.getBlogs();
    blogs.fold((error) {}, (data) {
      print('blogs: $data');
    });

    // final int = await blogRepo.saveBlog(
    //   Blog(title: 'title', content: 'content', createdAt: DateTime.now()),
    // );
    // print('saving: $int');

    final blogsAfter = await blogRepo.getBlogs();
    blogs.fold((error) {
      print('error: $error');
    }, (data) {
      print('blogs: $data');
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Untitled'),
      ),
      body: Container(),
    );
  }
}
