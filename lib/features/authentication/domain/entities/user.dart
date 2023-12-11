//@freezd

class AppUser {
  final int uuid;
  final String? name;
  final String email;
  final int farmId;
  const AppUser(
      {required this.uuid,
      required this.name,
      required this.email,
      required this.farmId});

  factory AppUser.fromJson(Map<String, dynamic> json) {
    return AppUser(
      uuid: json['uid'],
      name: json['name'],
      email: json['email'],
      farmId: json['userMetadata']['farm_id'],
    );
  }
}
