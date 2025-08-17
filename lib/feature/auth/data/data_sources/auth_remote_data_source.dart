import 'package:supabase_flutter/supabase_flutter.dart' hide User;
import 'package:untitled/core/exception/exceptions.dart';
import 'package:untitled/feature/auth/data/model/user_model.dart';

abstract interface class AuthRemoteDataSource {
  Session? get currentSession;

  Future<void> logout();

  Future<UserModel> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  });

  Future<UserModel> loginUpWithEmailPassword({
    required String email,
    required String password,
  });
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  AuthRemoteDataSourceImpl(this.supabaseClient);

  final SupabaseClient supabaseClient;

  @override
  Future<UserModel> loginUpWithEmailPassword({
    required String email,
    required String password,
  }) async {
    try {
      final response = await supabaseClient.auth.signInWithPassword(
        password: password,
        email: email,
      );
      if (response.user == null) {
        throw ServerException('User exception');
      }
      return UserModel.fromJson(response.user!.toJson());
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<UserModel> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final response = await supabaseClient.auth.signUp(
        password: password,
        email: email,
        data: {'name': name},
      );
      if (response.user == null) {
        throw ServerException('User exception');
      }
      return UserModel.fromJson(response.user!.toJson());
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Session? get currentSession => supabaseClient.auth.currentSession;

  @override
  Future<void> logout() async {
    return supabaseClient.auth.signOut();
  }
}
