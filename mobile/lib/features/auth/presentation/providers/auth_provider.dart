import 'package:flutter/foundation.dart';
import 'package:theft_detecting_system/features/auth/domain/entities/user.dart';
import 'package:theft_detecting_system/features/auth/domain/usecases/get_current_user.dart';
import 'package:theft_detecting_system/features/auth/domain/usecases/sign_in_with_google.dart';
import 'package:theft_detecting_system/features/auth/domain/usecases/sign_out.dart';

class AuthProvider extends ChangeNotifier {
  final SignInWithGoogle _signInWithGoogle;
  final SignOut _signOut;
  final GetCurrentUser _getCurrentUser;

  AuthProvider({
    required SignInWithGoogle signInWithGoogle,
    required SignOut signOut,
    required GetCurrentUser getCurrentUser,
  })  : _signInWithGoogle = signInWithGoogle,
        _signOut = signOut,
        _getCurrentUser = getCurrentUser;

  User? _user;
  bool _isLoading = false;
  String? _error;

  User? get user => _user;
  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get isAuthenticated => _user != null;

  Future<void> signInWithGoogle() async {
    _setLoading(true);
    _clearError();

    try {
      _user = await _signInWithGoogle();
      notifyListeners();
    } catch (e) {
      _setError('Sign in failed: ${e.toString()}');
    } finally {
      _setLoading(false);
    }
  }

  Future<void> signOut() async {
    _setLoading(true);
    _clearError();

    try {
      await _signOut();
      _user = null;
      notifyListeners();
    } catch (e) {
      _setError('Sign out failed: ${e.toString()}');
    } finally {
      _setLoading(false);
    }
  }

  Future<void> getCurrentUser() async {
    _setLoading(true);
    _clearError();

    try {
      _user = await _getCurrentUser();
      notifyListeners();
    } catch (e) {
      _setError('Failed to get current user: ${e.toString()}');
    } finally {
      _setLoading(false);
    }
  }

  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void _setError(String error) {
    _error = error;
    notifyListeners();
  }

  void _clearError() {
    _error = null;
    notifyListeners();
  }
}
