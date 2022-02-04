import 'package:equatable/equatable.dart';

class Question extends Equatable {
  final String idPertanyaan;
  final String pertanyaan;
  bool? isYes;

  Question({required this.pertanyaan, required this.idPertanyaan, this.isYes});

  bool isValid() {
    if (idPertanyaan.isNotEmpty && pertanyaan.isNotEmpty) {
      return true;
    }
    return false;
  }

  @override
  List<Object?> get props => [idPertanyaan, isYes];
}
