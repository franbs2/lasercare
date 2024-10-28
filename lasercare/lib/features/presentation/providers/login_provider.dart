import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lasercare/features/data/repositories/auth_firebase_repository_impl.dart';

class LoginProvider with ChangeNotifier {
  bool _isLoading = false;
  String? _errorMessage;
  bool isSuccess = false;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get isSucess => isSuccess;

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<void> loginUser(
    String email,
    String password,
  ) async {
    setLoading(true);
    _errorMessage = null;

    try {
      User? user = await AuthFirebaseRepositoryImpl().loginUser(
        email: email,
        password: password,
      );
      isSuccess = user != null;
      if (!isSuccess) {
        _errorMessage = 'Erro desconhecido ao logar.';
      }
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      setLoading(false);
    }
  }
}
