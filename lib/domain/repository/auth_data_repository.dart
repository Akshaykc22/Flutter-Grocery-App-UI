abstract class AuthDataRepository {
  Future<Map<String, dynamic>> getToken(String phone, String otp);
  Future<void> registerPhone(String phone);
}
