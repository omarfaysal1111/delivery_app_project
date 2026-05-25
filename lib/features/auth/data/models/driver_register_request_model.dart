class DriverRegisterRequestModel {
  const DriverRegisterRequestModel({
    required this.name,
    required this.phone,
    required this.email,
    required this.vehicleType,
    required this.vehicleNumber,
    required this.nationalId,
    this.profilePhotoUrl,
    this.driverLicensePhotoUrl,
    this.vehicleLicensePhotoUrl,
    this.nationalIdPhotoUrl,
  });

  final String name;
  final String phone;
  final String email;
  final String vehicleType;
  final String vehicleNumber;
  final String nationalId;
  final String? profilePhotoUrl;
  final String? driverLicensePhotoUrl;
  final String? vehicleLicensePhotoUrl;
  final String? nationalIdPhotoUrl;

  Map<String, dynamic> toJson() => {
    'name': name,
    'phone': phone,
    'email': email,
    'password': null,
    'vehicleType': vehicleType,
    'vehicleNumber': vehicleNumber,
    'nationalId': nationalId,
    'profilePhotoUrl': profilePhotoUrl,
    'driverLicensePhotoUrl': driverLicensePhotoUrl,
    'vehicleLicensePhotoUrl': vehicleLicensePhotoUrl,
    'nationalIdPhotoUrl': nationalIdPhotoUrl,
  };
}
