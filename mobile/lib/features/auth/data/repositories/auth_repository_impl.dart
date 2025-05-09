import 'package:theft_detecting_system/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:theft_detecting_system/features/auth/domain/entities/user.dart';
import 'package:theft_detecting_system/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl({required this.remoteDataSource});

  @override
  Future<User> signInWithGoogle() async {
    return await remoteDataSource.signInWithGoogle();
  }

  @override
  Future<void> signOut() async {
    await remoteDataSource.signOut();
  }

  @override
  Future<User?> getCurrentUser() async {
    return await remoteDataSource.getCurrentUser();
  }

  @override
  Stream<User?> get authStateChanges => remoteDataSource.authStateChanges;
}
