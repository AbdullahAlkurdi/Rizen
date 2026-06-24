import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rizen/app.dart';
import 'package:rizen/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:rizen/features/auth/data/repositories/auth_repository.dart';

// ignore: avoid_implementing_value_equals
class FakeAuthRepository extends AuthRepository {
  FakeAuthRepository() : super(auth: null, googleSignIn: null);

  @override
  Stream<User?> authStateChanges() => Stream<User?>.value(null);

  @override
  Future<UserCredential> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async => throw UnimplementedError();

  @override
  Future<UserCredential> createUserWithEmailAndPassword({
    required String email,
    required String password,
    required String displayName,
  }) async => throw UnimplementedError();

  @override
  Future<UserCredential> signInWithGoogle() async => throw UnimplementedError();

  @override
  Future<void> signOut() async {}

  @override
  Future<void> sendPasswordResetEmail(String email) async {}
}

void main() {
  testWidgets('Rizen app smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(
      BlocProvider(
        create: (_) => AuthCubit(repository: FakeAuthRepository()),
        child: const RizenApp(),
      ),
    );

    await tester.pumpAndSettle(const Duration(seconds: 4));

    expect(find.text('Get Started'), findsOneWidget);
  });
}
