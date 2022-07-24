import 'package:grocery_app/core/api_provider.dart';
import 'package:grocery_app/data/remote/routes.dart';

abstract class AuthDataSource {
  Future<Map<String, dynamic>> getToken(String phone, String otp);
  Future<void> registerPhone(String phone);
}

class AuthDataSourceImpl implements AuthDataSource {
  final ApiProvider apiProvider;

  AuthDataSourceImpl(this.apiProvider);

  @override
  Future<Map<String, dynamic>> getToken(String phone, String otp) {
    final data = apiProvider
        .post(AppRemoteRoutes.getToken, {'mobile': phone, 'token': otp});
    return data;
  }

  @override
  Future<void> registerPhone(String phone) async {
    apiProvider.post(AppRemoteRoutes.phone_auth, {'mobile': phone});
  }
}
