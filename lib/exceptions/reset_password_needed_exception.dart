class ResetPasswordNeededException implements Exception {
  final String jwt;
  ResetPasswordNeededException({required this.jwt});
}