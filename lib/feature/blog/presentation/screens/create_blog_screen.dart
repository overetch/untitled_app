import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/core/di/di_container.dart';
import 'package:untitled/feature/blog/domain/entity/blog.dart';
import 'package:untitled/feature/blog/presentation/bloc/utility_blog_bloc.dart';
import 'package:untitled/feature/blog/presentation/bloc/get_blog_bloc.dart';

class CreateBlogScreen extends StatelessWidget {
  const CreateBlogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<BlogUtilityBloc>(
      create: (context) => DIContainer().get(),
      child: const _CreateBlogScreen(),
    );
  }
}

class _CreateBlogScreen extends StatefulWidget {
  const _CreateBlogScreen({super.key});

  @override
  State<_CreateBlogScreen> createState() => _CreateBlogScreenState();
}

class _CreateBlogScreenState extends State<_CreateBlogScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: BlocConsumer<BlogUtilityBloc, BlogUtilityState>(
            listener: (context, state) {},
            builder: (context, state) {
              return Column(
                children: [
                  TextFormField(
                    decoration: const InputDecoration(
                      hintText: 'Title',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a title';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      hintText: 'Content',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some content';
                      }
                      return null;
                    },
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        context.read<BlogUtilityBloc>().add(
                          BlogUtilityEvent.createBlog(
                            title: _titleController.text.trim(),
                            description: _contentController.text.trim(),
                          ),
                        );
                      }
                    },
                    child: const Text('Create'),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }
}
