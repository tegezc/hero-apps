import 'enumapp.dart';

class ItemUi {
  static List<ItemComboJenisLokasi> getcombojenislokasi() {
    List<ItemComboJenisLokasi> list = [];
    list.add(new ItemComboJenisLokasi(EnumJenisLokasi.poi, 'POI'));
    list.add(new ItemComboJenisLokasi(EnumJenisLokasi.sekolah, 'Sekolah'));
    list.add(new ItemComboJenisLokasi(EnumJenisLokasi.kampus, 'Kampus'));
    list.add(new ItemComboJenisLokasi(EnumJenisLokasi.fakultas, 'Fakultas'));
    return list;
  }

  // static Map<int, ItemComboJenisOutlet> getComboJenisOutlet() {
  //   Map<int, ItemComboJenisOutlet> map = new Map();
  //   map[1] = ItemComboJenisOutlet(EnumJenisOutlet.device, 'Device');
  //   map[2] = ItemComboJenisOutlet(EnumJenisOutlet.reguler, 'Reguler');
  //   map[3] = ItemComboJenisOutlet(EnumJenisOutlet.pareto, 'Pareto');
  //
  //   return map;
  // }

  static Map<int, JenjangSekolah> getJenjangSekolah() {
    Map<int, JenjangSekolah> map = new Map();
    map[1] = JenjangSekolah(EnumJenjangSekolah.SD, 'SD');
    map[2] = JenjangSekolah(EnumJenjangSekolah.SMP, 'SMP');
    map[3] = JenjangSekolah(EnumJenjangSekolah.SMA, 'SMA');
    map[4] = JenjangSekolah(EnumJenjangSekolah.PONPES, 'PONPES');

    return map;
  }

  static List<ItemComboStatusLokasi> getComboStatuslokasi() {
    List<ItemComboStatusLokasi> list = [];
    list.add(ItemComboStatusLokasi(EnumStatusTempat.open, 'Open'));
    list.add(ItemComboStatusLokasi(EnumStatusTempat.close, 'Close'));
    return list;
  }

  static List<String> getCombouniversitas() {
    List<String> list = [];
    list.add('Universitas Baturaja');
    list.add('Universitas Bina Darma');
    list.add('Universitas IBA');
    list.add('Universitas Islam Negeri Raden Fatah');
    list.add('Universitas Musi Rawas');
    list.add('Universitas Indo Global Mandiri');
    list.add('Universitas Kader Bangsa');
    list.add('Universitas Muhammadiyah Palembang');
    list.add('Universitas Palembang');
    list.add('Universitas PGRI Palembang');
    list.add('Universitas Sjakhyakirti');
    list.add('Universitas Tamansiswa');
    list.add('Universitas Tridinanti');
    list.add('Universitas Islam OKI');
    return list;
  }

  static List<ItemCellTab> dummyPOI() {
    List<ItemCellTab> list = [];
    list.add(ItemCellTab('Mall A', 'Nina', '23-09-2020', 'SF0001-01'));
    list.add(ItemCellTab('Mall A', 'Rizky', '23-09-2020', 'SF0001-02'));
    list.add(ItemCellTab('Mall A', 'Diana', '23-09-2020', 'SF0001-03'));
    list.add(ItemCellTab('Mall A', 'Endah', '23-09-2020', 'SF0001-04'));
    list.add(ItemCellTab('Mall A', 'Amelia', '23-09-2020', 'SF0001-05'));
    return list;
  }

  static List<ItemCellTab> dummySekolah() {
    List<ItemCellTab> list = [];
    list.add(ItemCellTab('Sekolah A', 'Nina', '23-09-2020', 'SF0001-01'));
    list.add(ItemCellTab('Sekolah A', 'Rizky', '23-09-2020', 'SF0001-02'));
    list.add(ItemCellTab('Sekolah A', 'Diana', '23-09-2020', 'SF0001-03'));
    list.add(ItemCellTab('Sekolah A', 'Endah', '23-09-2020', 'SF0001-04'));
    list.add(ItemCellTab('Sekolah A', 'Amelia', '23-09-2020', 'SF0001-05'));
    return list;
  }

  static List<ItemCellTab> dummyUnvirsitas() {
    List<ItemCellTab> list = [];
    list.add(ItemCellTab('Universitas A', 'Nina', '23-09-2020', 'SF0001-01'));
    list.add(ItemCellTab('Universitas A', 'Rizky', '23-09-2020', 'SF0001-02'));
    list.add(ItemCellTab('Universitas A', 'Diana', '23-09-2020', 'SF0001-03'));
    list.add(ItemCellTab('Universitas A', 'Endah', '23-09-2020', 'SF0001-04'));
    list.add(ItemCellTab('Universitas A', 'Amelia', '23-09-2020', 'SF0001-05'));
    return list;
  }

  static List<ItemCellTab> dummyFakultas() {
    List<ItemCellTab> list = [];
    list.add(ItemCellTab(
        'Fakultas A Univ Indonesia', 'Nina', '23-09-2020', 'SF0001-01'));
    list.add(ItemCellTab(
        'Fakultas A Univ Indonesia', 'Rizky', '23-09-2020', 'SF0001-02'));
    list.add(ItemCellTab(
        'Fakultas A Univ Indonesia', 'Diana', '23-09-2020', 'SF0001-03'));
    list.add(ItemCellTab(
        'Fakultas A Univ Indonesia', 'Endah', '23-09-2020', 'SF0001-04'));
    list.add(ItemCellTab(
        'Fakultas A Univ Indonesia', 'Amelia', '23-09-2020', 'SF0001-05'));
    return list;
  }

  static List<ItemCellTab> dummyPOI1() {
    List<ItemCellTab> list = [];
    list.add(ItemCellTab('Mall A', 'Nina', '23-09-2020', 'SF0001-01'));
    list.add(ItemCellTab('Mall B', 'Rizky', '23-09-2020', 'SF0001-02'));
    list.add(ItemCellTab('Mall C', 'Diana', '23-09-2020', 'SF0001-03'));
    list.add(ItemCellTab('Mall D', 'Endah', '23-09-2020', 'SF0001-04'));
    list.add(ItemCellTab('Mall E', 'Amelia', '23-09-2020', 'SF0001-05'));
    return list;
  }

  static List<ItemCellTab> dummySekolah1() {
    List<ItemCellTab> list = [];
    list.add(ItemCellTab('Sekolah A', 'Nina', '23-09-2020', 'SF0001-01'));
    list.add(ItemCellTab('Sekolah B', 'Rizky', '23-09-2020', 'SF0001-02'));
    list.add(ItemCellTab('Sekolah C', 'Diana', '23-09-2020', 'SF0001-03'));
    list.add(ItemCellTab('Sekolah D', 'Endah', '23-09-2020', 'SF0001-04'));
    list.add(ItemCellTab('Sekolah E', 'Amelia', '23-09-2020', 'SF0001-05'));
    return list;
  }

  static List<ItemCellTab> dummyUnvirsitas1() {
    List<ItemCellTab> list = [];
    list.add(ItemCellTab('Universitas A', 'Nina', '23-09-2020', 'SF0001-01'));
    list.add(ItemCellTab('Universitas B', 'Rizky', '23-09-2020', 'SF0001-02'));
    list.add(ItemCellTab('Universitas C', 'Diana', '23-09-2020', 'SF0001-03'));
    list.add(ItemCellTab('Universitas D', 'Endah', '23-09-2020', 'SF0001-04'));
    list.add(ItemCellTab('Universitas E', 'Amelia', '23-09-2020', 'SF0001-05'));
    return list;
  }

  static List<ItemCellTab> dummyFakultas1() {
    List<ItemCellTab> list = [];
    list.add(
        ItemCellTab('Fakultas A Univ A', 'Nina', '23-09-2020', 'SF0001-01'));
    list.add(
        ItemCellTab('Fakultas A Univ B', 'Rizky', '23-09-2020', 'SF0001-02'));
    list.add(
        ItemCellTab('Fakultas A Univ C', 'Diana', '23-09-2020', 'SF0001-03'));
    list.add(
        ItemCellTab('Fakultas A Univ D', 'Endah', '23-09-2020', 'SF0001-04'));
    list.add(
        ItemCellTab('Fakultas A Univ E', 'Amelia', '23-09-2020', 'SF0001-05'));
    return list;
  }
}

class ItemComboJenisLokasi {
  EnumJenisLokasi enumJenisLokasi;
  String text;

  ItemComboJenisLokasi(this.enumJenisLokasi, this.text);
}

class ItemComboStatusLokasi {
  EnumStatusTempat enumStatusTempat;
  String text;

  ItemComboStatusLokasi(this.enumStatusTempat, this.text);
}

class ItemCellTab {
  String text1;
  String text2;
  String text3;
  String faktur;

  ItemCellTab(this.text1, this.text2, this.text3, this.faktur);
}

class JenjangSekolah {
  EnumJenjangSekolah enumJenjangSekolah;
  String text;
  JenjangSekolah(this.enumJenjangSekolah, this.text);

  int getIntJenjang() {
    switch (enumJenjangSekolah) {
      case EnumJenjangSekolah.SD:
        return 1;
      case EnumJenjangSekolah.SMP:
        return 2;
      case EnumJenjangSekolah.SMA:
        return 3;
      case EnumJenjangSekolah.PONPES:
        return 4;
      default:
        return -1;
    }
  }

  bool operator ==(dynamic other) =>
      other != null &&
      other is JenjangSekolah &&
      this.enumJenjangSekolah == other.enumJenjangSekolah;

  @override
  int get hashCode => super.hashCode;
}
