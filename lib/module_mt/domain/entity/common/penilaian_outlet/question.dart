class Question {
  final String idPertanyaan;
  final String pertanyaan;
  bool isYes;

  Question(
      {required this.pertanyaan,
      required this.idPertanyaan,
      required this.isYes});

  bool isValiddd() {
    if (idPertanyaan.isNotEmpty && pertanyaan.isNotEmpty) {
      return true;
    }
    return false;
  }
}
