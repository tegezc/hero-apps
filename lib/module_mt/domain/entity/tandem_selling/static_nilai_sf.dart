class NilaiSf {
  final String id;
  final String desc;
  final String nilai;
  NilaiSf(this.id, this.nilai, this.desc);

  bool isValid() {
    if (id.isEmpty || desc.isEmpty || nilai.isEmpty) {
      return false;
    }
    return true;
  }
}
