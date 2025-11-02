class SingInResponse {
  final String accessToken;
  final String refreshToken;
  final int expiresIn;
  final String country;

  SingInResponse({
    required this.accessToken,
    required this.refreshToken,
    required this.expiresIn,
    required this.country,
  });

  factory SingInResponse.fromMap(Map<String, dynamic> value) {
    return SingInResponse(
      accessToken: value['access_token'] ?? '',
      refreshToken: value['refresh_token'] ?? '',
      expiresIn: value['expires_in'] ?? 0,
      country: value['country'] ?? '',
    );
  }
}
