import 'dart:io';

abstract class ISplashRepository {
  Future<bool> checkConnectivity();
}

class SplashRepository extends ISplashRepository {
  @override
  Future<bool> checkConnectivity() async {
    try {
      final result = await InternetAddress.lookup('www.flaticon.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      return false;
    }
  }
}
