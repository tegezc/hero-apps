import 'package:flutter/material.dart';
import 'package:hero/model/lokasi/lokasimodel.dart';
import 'package:hero/util/component/button/component_button.dart';
import 'package:hero/util/component/label/component_label.dart';

import 'bloc/abstractbloclokasi.dart';

class ScaffoldLocation extends StatelessWidget {
  final Widget body;
  final String? title;
  final String? textBtn;
  final Function? onTap;
  final PreferredSizeWidget? bottom;

  const ScaffoldLocation(
      {Key? key,
      required this.body,
      required this.title,
      this.textBtn,
      this.bottom,
      this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red[600],
        iconTheme: const IconThemeData(
          color: Colors.white, //change your color here
        ),
        title: Container(
          alignment: Alignment.center,
          child: Text(title!,
              style: const TextStyle(
                color: Colors.white,
              )),
        ),
        actions: <Widget>[
          Container(
            margin: const EdgeInsets.all(15),
            child: ButtonApp.black(
              textBtn,
              () {
                onTap!();
              },
              bgColor: Colors.white,
            ),
          ),
        ],
        bottom: bottom,
      ),
      body: body,
    );
  }
}

class ScaffoldLocView extends StatelessWidget {
  final Widget body;
  final String? title;
  final PreferredSizeWidget? bottom;

  const ScaffoldLocView(
      {Key? key, required this.body, required this.title, this.bottom})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red[600],
        iconTheme: const IconThemeData(
          color: Colors.white, //change your color here
        ),
        title: Center(
          child: Text(title!,
              style: const TextStyle(
                color: Colors.white,
              )),
        ),
        bottom: bottom,
      ),
      body: body,
    );
  }
}

class FormAlamat extends StatefulWidget {
  final ControllLokasi? controllLokasi;
  final DataLokasiAlamat? dataLokasiAlamat;

  const FormAlamat(this.controllLokasi, this.dataLokasiAlamat, {Key? key})
      : super(key: key);

  @override
  _FormAlamatState createState() => _FormAlamatState();
}

class _FormAlamatState extends State<FormAlamat> {
  List<Provinsi>? _lprov;
  List<Kecamatan>? _lkec;
  List<Kabupaten>? _lkab;
  List<Kelurahan>? _lkel;

  Provinsi? _currentProv;
  Kabupaten? _currentKab;
  Kecamatan? _currentKec;
  Kelurahan? _currentKelurahan;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    DataLokasiAlamat dl = widget.dataLokasiAlamat!;

    _lprov = dl.lprov;
    _lkec = dl.lkec;
    _lkab = dl.lkab;
    _lkel = dl.lkel;

    _currentProv = dl.currentProv;
    _currentKab = dl.currentKab;
    _currentKec = dl.currentKec;
    _currentKelurahan = dl.currentKelurahan;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 2.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              LabelAppRich.size3(
                'Provinsi ',
                color: Colors.grey[700],
              ),
              DropdownButton(
                onTap: () {
                  FocusScope.of(context).unfocus();
                },
                items: _lprov == null
                    ? null
                    : _lprov!
                        .map((value) => DropdownMenuItem(
                              child: LabelBlack.size2(value.nama),
                              value: value,
                            ))
                        .toList(),
                onChanged: (dynamic prov) {
                  widget.controllLokasi!.comboProvPicked(prov);
                },
                value: _currentProv,
                isExpanded: false,
                hint: const LabelBlack.size2('Pilih Provinsi'),
              )
            ],
          ),
        ),
        _spasi(),
        Padding(
          padding: const EdgeInsets.only(left: 2.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              LabelAppRich.size3(
                'Kabupaten ',
                color: Colors.grey[700],
              ),
              DropdownButton(
                onTap: () {
                  FocusScope.of(context).unfocus();
                },
                items: _lkab == null
                    ? null
                    : _lkab!
                        .map((value) => DropdownMenuItem(
                              child: LabelBlack.size2(value.nama),
                              value: value,
                            ))
                        .toList(),
                onChanged: (dynamic kab) {
                  widget.controllLokasi!.comboKabPicked(kab);
                },
                value: _currentKab,
                isExpanded: false,
                hint: const LabelBlack.size2('Pilih Kabupaten'),
              )
            ],
          ),
        ),
        _spasi(),
        Padding(
          padding: const EdgeInsets.only(left: 2.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              LabelAppRich.size3(
                'Kecamatan ',
                color: Colors.grey[700],
              ),
              DropdownButton(
                onTap: () {
                  FocusScope.of(context).unfocus();
                },
                items: _lkec == null
                    ? null
                    : _lkec!
                        .map((value) => DropdownMenuItem(
                              child: Text(
                                value.nama!,
                                style: const TextStyle(color: Colors.black),
                              ),
                              value: value,
                            ))
                        .toList(),
                onChanged: (dynamic kec) {
                  widget.controllLokasi!.comboKecPicked(kec);
                },
                value: _currentKec,
                isExpanded: false,
                hint: const LabelBlack.size2('Pilih Kecamatan'),
              )
            ],
          ),
        ),
        _spasi(),
        Padding(
          padding: const EdgeInsets.only(left: 2.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              LabelAppRich.size3(
                'Kelurahan ',
                color: Colors.grey[700],
              ),
              DropdownButton(
                onTap: () {
                  FocusScope.of(context).unfocus();
                },
                items: _lkel == null
                    ? null
                    : _lkel!
                        .map((value) => DropdownMenuItem(
                              child: Text(
                                value.nama!,
                                style: const TextStyle(color: Colors.black),
                              ),
                              value: value,
                            ))
                        .toList(),
                onChanged: (dynamic kel) {
                  widget.controllLokasi!.comboKelPicked(kel);
                },
                value: _currentKelurahan,
                isExpanded: false,
                hint: const LabelBlack.size2('Pilih Kelurahan'),
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget _spasi() {
    return const SizedBox(
      height: 8,
    );
  }
}
