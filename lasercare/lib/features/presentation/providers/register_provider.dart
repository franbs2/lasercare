import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../data/repositories/auth_firebase_repository_impl.dart';

class RegisterProvider with ChangeNotifier {
  bool _isLoading = false;
  String? _errorMessage;
  bool isSuccess = false;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<void> registerUser({
    required String name,
    required String email,
    required String cnpj,
    required String password,
  }) async {
    setLoading(true);
    _errorMessage = null;

    try {
      User? user = await AuthFirebaseRepositoryImpl().registerUser(
        name: name,
        email: email,
        cnpj: cnpj,
        password: password,
      );

      isSuccess = user != null;
      if (!isSuccess) {
        _errorMessage = 'Erro desconhecido ao registrar.';
      }
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      setLoading(false);
    }
  }
}
