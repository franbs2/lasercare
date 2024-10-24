import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthProvider with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> registerUser({
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
    } on FirebaseException catch (e) {
      throw Exception(
          'Erro ao adicionar dados do usuário no Firestore: ${e.message}');
    } catch (e) {
      throw Exception('Erro desconhecido ao registrar usuário.');
    }
  }
}
