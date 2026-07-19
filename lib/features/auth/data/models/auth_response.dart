class AuthResponse {
  final String accessToken;
  final String refreshToken;
  final String tokenType;
  final String userId;
  final String? email;
  final String phone;
  final String firstName;
  final String lastName;
  final String fullName;
  final String role;
  final bool newUser;

  const AuthResponse({
    required this.accessToken,
    required this.refreshToken,
    required this.tokenType,
    required this.userId,
    this.email,
    required this.phone,
    required this.firstName,
    required this.lastName,
    required this.fullName,
    required this.role,
    required this.newUser,
  });

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(
      accessToken: json['accessToken'] as String? ?? '',
      refreshToken: json['refreshToken'] as String? ?? '',
      tokenType: json['tokenType'] as String? ?? '',
      userId: json['userId'] as String? ?? '',
      email: json['email'] as String?,
      phone: json['phone'] as String? ?? '',
      firstName: json['firstName'] as String? ?? '',
      lastName: json['lastName'] as String? ?? '',
      fullName: json['fullName'] as String? ?? '',
      role: json['role'] as String? ?? '',
      newUser: json['newUser'] as bool? ?? false,
    );
  }
}
