import 'package:mynotes/services/auth/auth_exeptions.dart';
import 'package:mynotes/services/auth/auth_provider.dart';
import 'package:mynotes/services/auth/auth_user.dart';
import 'package:test/test.dart';

void main() {
  group('Mock Authentication', () {
    final provider = MockAuthProvider();
    test('not initialized at beginning', () {
      expect(provider.isInitialized, false);
    });

    test('cannot log out if not initialized', () {
      expect(
        provider.logOut(),
        throwsA(const TypeMatcher<NotInitializedExeption>()),
      );
    });
    test('should be able too be initionalized', () async {
      await provider.initialize();
      expect(provider.isInitialized, true);
    });
    test('User should be null after initialization', () {
      expect(provider.currentUser, null);
    });

    test(
      'should be able to initializee in less than two seconds',
      () async {
        await provider.initialize();
        expect(provider.isInitialized, true);
      },
      timeout: const Timeout(Duration(seconds: 2)),
    );

    test('create user should delegate to logIn function', () async {
      final badEmailUser = provider.createUser(
        email: 'mattisjohannes.koch@web.de',
        password: 'dafasdfasdfa',
      );
      expect(
          badEmailUser,
          throwsA(
            const TypeMatcher<UserNotFoundAuthExeption>(),
          ));
      final badPassword = provider.createUser(
        email: 'email',
        password: 'Mattis2010',
      );
      expect(
          badPassword,
          throwsA(
            const TypeMatcher<WrongPasswordAuthExeption>(),
          ));
      final user = await provider.createUser(
        email: 'dsfd',
        password: 'adfadf',
      );
      expect(provider.currentUser, user);
      expect(user.isEmailVerified, false);
    });

    test('logged in user should be alble to get verified', () {
      provider.sendEmailVerification();
      final user = provider.currentUser;
      expect(user, isNotNull);
      expect(user!.isEmailVerified, true);
    });

    test('should be able to log in and log out again', () async {
      await provider.logOut();
      await provider.logIn(
        email: 'email',
        password: 'password',
      );
      final user = provider.currentUser;
      expect(user, isNotNull);
    });
  });
}

class NotInitializedExeption implements Exception {}

class MockAuthProvider implements AuthProvider {
  AuthUser? _user;
  var _isInitialized = false;
  bool get isInitialized => _isInitialized;

  @override
  Future<AuthUser> createUser({
    required String email,
    required String password,
  }) async {
    if (!isInitialized) throw NotInitializedExeption();
    await Future.delayed(const Duration(seconds: 1));
    return logIn(
      email: email,
      password: password,
    );
  }

  @override
  AuthUser? get currentUser => _user;

  @override
  Future<void> initialize() async {
    await Future.delayed(const Duration(seconds: 1));
    _isInitialized = true;
  }

  @override
  Future<AuthUser> logIn({
    required String email,
    required String password,
  }) {
    if (!isInitialized) throw NotInitializedExeption();
    if (email == "mattisjohannes.koch@web.de") throw UserNotFoundAuthExeption();
    if (password == 'Mattis2010') throw WrongPasswordAuthExeption();
    const user = AuthUser(isEmailVerified: false);
    _user = user;
    return Future.value(user);
  }

  @override
  Future<void> logOut() async {
    if (!isInitialized) throw NotInitializedExeption();
    if (_user == null) throw UserNotFoundAuthExeption();
    await Future.delayed(const Duration(seconds: 1));
    _user = null;
  }

  @override
  Future<void> sendEmailVerification() async {
    if (!isInitialized) throw NotInitializedExeption();
    final user = _user;
    if (user == null) throw UserNotFoundAuthExeption();
    const newUser = AuthUser(isEmailVerified: true);
    _user = newUser;
  }
}
