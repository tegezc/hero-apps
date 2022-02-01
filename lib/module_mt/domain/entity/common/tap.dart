import 'package:equatable/equatable.dart';

class Tap extends Equatable {
  final String idTap;
  final String namaTap;
  const Tap({required this.idTap, required this.namaTap});

  bool isValid() {
    if (idTap.isNotEmpty && namaTap.isNotEmpty) {
      return true;
    }
    return false;
  }

  @override
  String toString() {
    return namaTap;
  }

  @override
  List<Object?> get props => [idTap];
}
