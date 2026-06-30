import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:file/file.dart' as file;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final String _credentialPath = '.rizen/credentials.json';
  
  Future<bool> isAuthenticated() async {
    try {
      final user = _auth.currentUser;
      if (user != null) return true;
      final creds = await _loadCredentials();
      if (creds != null) {
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }
  
  Future<void> login() async {
    print('🔐 RizenOS CLI Login');
    print('====================');
    print('Choose login method:');
    print('  1. Email/Password');
    print('  2. Google (requires browser)');
    print('');
    
    print('📧 Email login:');
    stdout.write('Email: ');
    final email = stdin.readLineSync() ?? '';
    stdout.write('Password: ');
    final password = stdin.readLineSync() ?? '';
    
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (userCredential.user != null) {
        await _saveCredentials();
        print('✅ Login successful!');
        print('   User: ${userCredential.user!.email}');
      }
    } catch (e) {
      print('❌ Login failed: $e');
    }
  }
  
  Future<void> logout() async {
    await _auth.signOut();
    await _deleteCredentials();
    print('✅ Logged out successfully');
  }
  
  Future<Map<String, dynamic>?> _loadCredentials() async {
    final file = File(_credentialPath);
    if (await file.exists()) {
      try {
        final content = await file.readAsString();
        return {'token': 'stored'};
      } catch (e) {
        return null;
      }
    }
    return null;
  }
  
  Future<void> _saveCredentials() async {
    final dir = Directory('.rizen');
    if (!await dir.exists()) {
      await dir.create(recursive: true);
    }
    final file = File(_credentialPath);
    await file.writeAsString('{"authenticated": true}');
  }
  
  Future<void> _deleteCredentials() async {
    final file = File(_credentialPath);
    if (await file.exists()) {
      await file.delete();
    }
  }
}
