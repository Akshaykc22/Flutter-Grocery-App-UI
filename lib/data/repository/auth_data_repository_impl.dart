import 'package:grocery_app/data/remote/data_source/auth_data_source.dart';
import 'package:grocery_app/domain/repository/auth_data_repository.dart';

class AuthDataRepositoryImpl extends AuthDataRepository {
  final AuthDataSource dataSource;

  AuthDataRepositoryImpl(this.dataSource);

  @override
  Future<Map<String, dynamic>> getToken(String phone, String otp) {
    return dataSource.getToken(phone, otp);
  }

  @override
  Future<void> registerPhone(String phone) {
    return dataSource.registerPhone(phone);
  }
}
