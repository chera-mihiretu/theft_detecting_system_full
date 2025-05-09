import 'package:theft_detecting_system/features/auth/domain/entities/user.dart';
import 'package:theft_detecting_system/features/auth/domain/repositories/auth_repository.dart';

class GetCurrentUser {
  final AuthRepository repository;

  GetCurrentUser(this.repository);

  Future<User?> call() async {
    return await repository.getCurrentUser();
  }
}
