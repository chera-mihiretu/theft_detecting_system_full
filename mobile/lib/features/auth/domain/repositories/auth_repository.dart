import 'package:theft_detecting_system/features/auth/domain/entities/user.dart';

abstract class AuthRepository {
  Future<User> signInWithGoogle();
  Future<void> signOut();
  Future<User?> getCurrentUser();
  Stream<User?> get authStateChanges;
}
