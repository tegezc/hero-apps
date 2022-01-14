import 'dart:convert';

class Operator {
  String idserver;
  String nama;
  Operator({required this.idserver, required this.nama});

  bool isValid() {
    if (idserver == null || nama == null) {
      return false;
    }
    return true;
  }

  Map<String, dynamic> toMap() {
    return {'id': idserver, 'provider': nama};
  }

  var contohmap = {"id": "1", "provider": "telkomsel"};

  factory Operator.fromMap(Map<String, dynamic> map) {
    return Operator(
      idserver: map['id'],
      nama: map['provider'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Operator.fromJson(String source) =>
      Operator.fromMap(json.decode(source));
}
