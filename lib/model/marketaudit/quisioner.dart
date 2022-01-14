import 'dart:convert';

class Quisioner {
  String? idhistorypjp;
  String? namaPelanggan;
  String? opTelp;
  String? msisdnTelp;
  String? opInternet;
  String? msisdnInternet;

  String? opDigital;
  String? msisdnDigital;
  String? frekBeliPaket;
  String? kuotaPerBulan;
  String? pulsaPerbulan;

  Quisioner({
    this.idhistorypjp,
    this.namaPelanggan,
    this.opTelp,
    this.msisdnTelp,
    this.opInternet,
    this.msisdnInternet,
    this.opDigital,
    this.msisdnDigital,
    this.frekBeliPaket,
    this.kuotaPerBulan,
    this.pulsaPerbulan,
  });

  Map<String, dynamic> toMap() {
    return {
      'id_history_pjp': idhistorypjp,
      'nama_pelanggan': namaPelanggan,
      'op_telepon': opTelp,
      'msisdn_telepon': msisdnTelp,
      'op_internet': opInternet,
      'msisdn_internet': msisdnInternet,
      'op_digital': opDigital,
      'msisdn_digital': msisdnDigital,
      'frekuensi_beli_paket': frekBeliPaket,
      'kuota_per_bulan': kuotaPerBulan,
      'pulsa_per_bulan': pulsaPerbulan,
    };
  }

  var contohmap = {
    "id_history_pjp": "54",
    "nama_pelanggan": "NOFY",
    "op_telepon": "1",
    "msisdn_telepon": "081166225566",
    "op_internet": "1",
    "msisdn_internet": "08572827282",
    "op_digital": "1",
    "msisdn_digital": "081166225566",
    "frekuensi_beli_paket": "1",
    "kuota_per_bulan": "10",
    "pulsa_per_bulan": "100000"
  };

  factory Quisioner.fromMap(Map<String, dynamic> map) {
    return Quisioner(
      idhistorypjp: map['id_history_pjp'],
      namaPelanggan: map['nama_pelanggan'],
      opTelp: map['op_telepon'],
      msisdnTelp: map['msisdn_telepon'],
      opInternet: map['op_internet'],
      msisdnInternet: map['msisdn_internet'],
      opDigital: map['op_digital'],
      msisdnDigital: map['msisdn_digital'],
      frekBeliPaket: map['frekuensi_beli_paket'],
      kuotaPerBulan: map['kuota_per_bulan'],
      pulsaPerbulan: map['pulsa_per_bulan'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Quisioner.fromJson(String source) =>
      Quisioner.fromMap(json.decode(source));
}
