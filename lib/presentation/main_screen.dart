import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:untitled/core/di/di_container.dart';
import 'package:untitled/core/routing/routing.dart';
import 'package:untitled/feature/blog/domain/entity/blog.dart';
import 'package:untitled/feature/blog/presentation/bloc/blog_bloc.dart';
import 'package:untitled/feature/blog/presentation/widgets/blog_list_item.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DIContainer().get<BlogBloc>()..add(BlogEvent.load()),
      child: const _MainScreen(),
    );
  }
}

class _MainScreen extends StatefulWidget {
  const _MainScreen({super.key});

  @override
  State<_MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<_MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Untitled'),
        actions: [
          IconButton(
            onPressed: () {
              context.go(blogCreateRoute);
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: BlocBuilder<BlogBloc, BlogState>(
        builder: (context, state) {
          return switch (state) {
            BlogLoading() => const Center(child: CircularProgressIndicator()),
            BlogError(:var error) => Text(error),
            BlogLoaded(:var blogs) when blogs.isEmpty => _emptyView(),
            BlogLoaded(:var blogs) => _blogList(blogs),
          };
        },
      ),
    );
  }

  Widget _emptyView() {
    return const Center(
      child: Text(
        'There are no blogs\nclick on "+" to create one!',
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _blogList(List<Blog> blogs) {
    return ListView.builder(
      itemBuilder: (ctx, index) {
        return BlogListItem(
          title: blogs[index].title,
          description: blogs[index].content,
          onTap: () {

          },
        );
      },
      itemCount: blogs.length,
    );
  }
}
