class User {
  String email;
  String username;
  String password;
  bool isPremium;

  User(
      {required this.email,
      required this.username,
      required this.password,
      this.isPremium = false});

  // Métodos para convertir el User a Map y desde Map
  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'username': username,
      'password': password,
      'isPremium': isPremium,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      email: map['email'] ?? '',
      username: map['username'] ?? '',
      password: map['password'] ?? '',
      isPremium: map['isPremium'] ?? false,
    );
  }

  // Método para validar las credenciales del usuario
  static User validateLogin(String? email, String? password, List<User> users) {
    for (var user in users) {
      if (user.email == email && user.password == password) {
        return user;
      }
    }
    return User(email: '', username: '', password: '', isPremium: false);
  }

  // Método para recuperar usuario por email
  static User? findByEmail(String email, List<User> users) {
    return users.firstWhere((user) => user.email == email,
        orElse: () =>
            User(email: '', username: '', password: '', isPremium: false));
  }
}
