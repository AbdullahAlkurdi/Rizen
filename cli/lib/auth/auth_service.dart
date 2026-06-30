import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';

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
    stdout.writeln('🔐 RizenOS CLI Login');
    stdout.writeln('====================');
    stdout.writeln('Choose login method:');
    stdout.writeln('  1. Email/Password');
    stdout.writeln('  2. Google (requires browser)');
    stdout.writeln('');
    
    stdout.writeln('📧 Email login:');
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
        stdout.writeln('✅ Login successful!');
        stdout.writeln('   User: ${userCredential.user!.email}');
      }
    } catch (e) {
      stderr.writeln('❌ Login failed: $e');
    }
  }
  
  Future<void> logout() async {
    await _auth.signOut();
    await _deleteCredentials();
    stdout.writeln('✅ Logged out successfully');
  }
  
  Future<Map<String, dynamic>?> _loadCredentials() async {
    final file = File(_credentialPath);
    if (await file.exists()) {
      await file.readAsString();
      return {'token': 'stored'};
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
