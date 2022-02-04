import 'package:equatable/equatable.dart';

import 'question.dart';

class Advokasi extends Equatable {
  List<Question> lquestions;

  Advokasi({required this.lquestions});

  @override
  List<Object?> get props => [lquestions];
}
