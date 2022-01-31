class Account {
  final String email;
  final String token;
  final String level;
  final String idDidvisi;
  final String nama;

  Account(
      {required this.email,
      required this.token,
      required this.level,
      required this.idDidvisi,
      required this.nama});
  bool isValid() {
    if (email.isNotEmpty &&
        token.isNotEmpty &&
        level.isNotEmpty &&
        idDidvisi.isNotEmpty &&
        nama.isNotEmpty) {
      return true;
    }
    return false;
  }
}
