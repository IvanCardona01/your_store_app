class UserModel {
  final int? id;
  final String email;
  final String password;
  final String firstName;
  final String lastName;
  final String? phone;
  final String? address;
  final String? city;
  final String? country;

  UserModel({
    this.id,
    required this.email,
    required this.password,
    required this.firstName,
    required this.lastName,
    this.phone,
    this.address,
    this.city,
    this.country,
  });

  UserModel copyWith({
    int? id,
    String? email,
    String? password,
    String? firstName,
    String? lastName,
    String? phone,
    String? address,
    String? city,
    String? country,
  }) {
    return UserModel(
      id: id ?? this.id,
      email: email ?? this.email,
      password: password ?? this.password,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      city: city ?? this.city,
      country: country ?? this.country,
    );
  }
}
