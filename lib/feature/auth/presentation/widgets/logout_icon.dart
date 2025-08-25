import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/core/di/di_container.dart';
import 'package:untitled/feature/auth/presentation/bloc/logout_bloc.dart';

class LogoutIcon extends StatelessWidget {
  const LogoutIcon({required this.onSuccess, super.key});

  final VoidCallback onSuccess;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LogoutBloc>(
      create: (context) => DIContainer().get(),
      child: Builder(
        builder: (context) {
          return BlocListener<LogoutBloc, LogoutState>(
            listener: (context, state) {
              if (state is LogoutStateSuccess) {
                onSuccess();
              }
            },
            child: IconButton(
              onPressed: () {
                context.read<LogoutBloc>().add(LogoutEvent.logout());
              },
              icon: const Icon(Icons.logout),
            ),
          );
        },
      ),
    );
  }
}
