import 'package:grocery_app/core/usecase.dart';
import 'package:grocery_app/domain/repository/auth_data_repository.dart';

class AuthRegisterUseCase extends UseCase<void, String> {
  final AuthDataRepository repository;

  AuthRegisterUseCase(this.repository);

  @override
  Future<void> call(String params) {
    return repository.registerPhone(params);
  }
}
