import 'package:mwaslat/network/auth.dart';

class PersistenceManager implements AuthDataDelegate {
  @override
  String get accessToken => null;

  @override
  bool get isLoggedIn => false;
}