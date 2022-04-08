import 'package:equatable/equatable.dart';

class AppUser extends Equatable {
  final String uid;
  final String? email;
  final String? name;

  final String? pictureUrl;

  const AppUser({
    required this.uid,
    this.email,
    this.name,
    this.pictureUrl,
  });

  /// Empty user which represents an unauthenticated user.
  static const empty = AppUser(uid: '');

  /// Convenience getter to determine whether the current user is empty.
  bool get isEmpty => this == AppUser.empty;

  /// Convenience getter to determine whether the current user is not empty.
  bool get isNotEmpty => this != AppUser.empty;

  @override
  List<Object?> get props {
    return [
      uid,
      email,
      name,
      pictureUrl,
    ];
  }
}
