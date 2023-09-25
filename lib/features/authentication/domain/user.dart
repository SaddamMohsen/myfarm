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
}
