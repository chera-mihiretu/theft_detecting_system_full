import 'package:theft_detecting_system/features/auth/domain/entities/user.dart';
import 'package:theft_detecting_system/features/auth/domain/repositories/auth_repository.dart';

class SignInWithGoogle {
  final AuthRepository repository;

  SignInWithGoogle(this.repository);

  Future<User> call() async {
    return await repository.signInWithGoogle();
  }
}
