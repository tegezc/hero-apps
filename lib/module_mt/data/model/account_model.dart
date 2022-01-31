import 'package:hero/module_mt/domain/entity/auth/account.dart';

class AccountModel extends Account {
  AccountModel(
      {required String email,
      required String idDiv,
      required String level,
      required String nama,
      required String token})
      : super(
            email: email,
            idDidvisi: idDiv,
            level: level,
            nama: nama,
            token: token);

  factory AccountModel.fromAccount(Account account) {
    return AccountModel(
        email: account.email,
        idDiv: account.idDidvisi,
        level: account.level,
        nama: account.nama,
        token: account.token);
  }

  factory AccountModel.fromListString(List<String> lstring) {
    return AccountModel(
        email: lstring[0],
        idDiv: lstring[1],
        level: lstring[2],
        nama: lstring[3],
        token: lstring[4]);
  }

  List<String> toListString() {
    return [email, idDidvisi, level, nama, token];
  }

  factory AccountModel.fromJson(Map<String, dynamic> json) {
    return AccountModel(
        email: json['id'] ?? '',
        idDiv: json['id_divisi'] ?? '',
        level: json['role'] ?? '',
        nama: json['nama'] ?? '',
        token: json['token'] ?? '');
  }
}
