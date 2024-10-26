import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthFirebaseRepository {
  Future<User?> registerUser({
    required String name,
    required String email,
    required String cnpj,
    required String password,
  });
}
