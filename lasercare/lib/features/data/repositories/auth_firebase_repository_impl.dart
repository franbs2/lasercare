import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../core/error/firebase_auth_error.dart';
import '../../domain/repositories/auth_firebase_repository.dart';

class AuthFirebaseRepositoryImpl implements AuthFirebaseRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Future<User?> registerUser({
    required String name,
    required String email,
    required String cnpj,
    required String password,
  }) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await firestore.collection('users').doc(userCredential.user!.uid).set({
        'name': name,
        'email': email,
        'cnpj': cnpj,
      });

      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      FirebaseAuthErrorHandler.handleFirebaseAuthException(e);
    } on FirebaseException catch (e) {
      throw 'Erro ao cadastrar usuário: ${e.message}';
    } catch (e) {
      throw 'Erro desconhecido ao registrar usuário: $e';
    }
    return null;
  }
}
