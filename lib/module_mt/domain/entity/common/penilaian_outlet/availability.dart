import 'package:equatable/equatable.dart';

import 'kategories.dart';
import 'questions.dart';

class Availability extends Equatable {
  Kategories kategoriOperator;
  Kategories kategoriVF;
  Questions question;
  String? pathPhotoOperator;
  String? pathPhotoVF;

  Availability(
      {required this.kategoriOperator,
      required this.kategoriVF,
      required this.question});

  @override
  List<Object?> get props => [pathPhotoOperator, pathPhotoVF];
}
