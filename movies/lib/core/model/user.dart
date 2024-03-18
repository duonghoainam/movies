class User {
  final int id;
  final String name;
  final String email;
  final List<String> favorites;

  const User.empty({
    this.id = -1,
    this.name = '',
    this.email = '',
    this.favorites = const [],
  });

//<editor-fold desc="Data Methods">
  const User({
    required this.id,
    required this.name,
    required this.email,
    required this.favorites,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          (other is User &&
              runtimeType == other.runtimeType &&
              id == other.id &&
              name == other.name &&
              email == other.email &&
              favorites == other.favorites);

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      email.hashCode ^
      favorites.hashCode;

  @override
  String toString() {
    return 'User{ id: $id, name: $name, email: $email, favorites: $favorites,}';
  }

  User copyWith({
    int? id,
    String? name,
    String? email,
    String? phone,
    List<String>? favorites,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      favorites: favorites ?? this.favorites,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'favorites': favorites,
    };
  }

  // factory User.fromMap(Map<String, dynamic> map) {
  //   return User(
  //     id: map['id'] as int,
  //     name: map['name'] as String,
  //     email: map['email'] as String,
  //     favorites: map['favorites'] == null
  //         ? []
  //         : (map['favorites'] as List)
  //         .map((e) => e.toString())
  //         .toList(),
  //   );
  // }

//</editor-fold>
}