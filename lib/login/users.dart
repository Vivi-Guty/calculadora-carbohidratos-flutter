class User {
  String email;
  String username;
  String password;

  User({required this.email, required this.username, required this.password});

  // Método para validar las credenciales del usuario
  static User validateLogin(String? email, String? password, List<User> users) {
    for (var user in users) {
      if (user.email == email && user.password == password) {
        return user;
      }
    }
    return User(email: '', username: '', password: '');
  }

  // Método para recuperar usuario por email
  static User? findByEmail(String email, List<User> users) {
    return users.firstWhere((user) => user.email == email,
        orElse: () => User(email: '', username: '', password: ''));
  }
}
