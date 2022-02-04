import 'package:flutter/material.dart';
import 'package:hero/model/enumapp.dart';
import 'package:hero/model/lokasi/owner.dart';
import 'package:hero/model/lokasi/pic.dart';
import 'package:hero/util/component/button/component_button.dart';
import 'package:hero/util/component/textfield/component_textfield.dart';

import 'bloc/controllowner.dart';
import 'bloc/controllpic.dart';

class PageIdentitas extends StatefulWidget {
  final EnumPicOwner enumPicOwner;
  final ControllPic? controllPic;
  final ControllOwner? controllOwner;

  PageIdentitas(this.enumPicOwner, {this.controllPic, this.controllOwner});

  @override
  _PageIdentitasState createState() => _PageIdentitasState();
}

class _PageIdentitasState extends State<PageIdentitas> {
  final GlobalKey<FormState> _formKeyValue = GlobalKey<FormState>();
  final TextEditingController _cnama = TextEditingController();
  final TextEditingController _cnotelp = TextEditingController();
  final TextEditingController _chobi = TextEditingController();
  final TextEditingController _cfb = TextEditingController();
  final TextEditingController _cig = TextEditingController();

  DateTime? _currentTgl;

  @override
  void initState() {
    super.initState();
  }

  void _setValue() {
    if (widget.enumPicOwner == EnumPicOwner.owner &&
        widget.controllOwner != null) {
      Owner? owner = widget.controllOwner!.getOwner();
      if (owner != null) {
        _cnama.text = owner.nama == null ? '' : owner.nama!;
        _cnotelp.text = owner.nohp == null ? '' : owner.nohp!;
        _chobi.text = owner.hobi == null ? '' : owner.hobi!;
        _cfb.text = owner.fb == null ? '' : owner.fb!;
        _cig.text = owner.ig == null ? '' : owner.ig!;
        _currentTgl = owner.tglLahir;
        widget.controllOwner!.setTglLahir(_currentTgl);
      }
    } else if (widget.enumPicOwner == EnumPicOwner.pic &&
        widget.controllPic != null) {
      Pic? pic = widget.controllPic!.getPic();
      if (pic != null) {
        _cnama.text = pic.nama == null ? '' : pic.nama!;
        _cnotelp.text = pic.nohp == null ? '' : pic.nohp!;
        _chobi.text = pic.hobi == null ? '' : pic.hobi!;
        _cfb.text = pic.fb == null ? '' : pic.fb!;
        _cig.text = pic.ig == null ? '' : pic.ig!;
        _currentTgl = pic.tglLahir;
        widget.controllPic!.setTglLahir(_currentTgl);
      }
    }
  }

  @override
  void dispose() {
    _cnama.dispose();
    _cnotelp.dispose();
    _chobi.dispose();
    _cfb.dispose();
    _cig.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String? labelNama;
    String? labelnohp;
    String? labelTglLahir;
    if (widget.enumPicOwner == EnumPicOwner.owner) {
      labelNama = 'Nama *';
      labelnohp = 'No Telp *';
      labelTglLahir = 'Tgl Lahir *';
    } else if (widget.enumPicOwner == EnumPicOwner.pic) {
      labelNama = 'Nama';
      labelnohp = 'No Telp';
      labelTglLahir = 'Tgl Lahir';
    }
    _setValue();
    return Form(
      key: _formKeyValue,
      autovalidateMode: AutovalidateMode.always,
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        children: <Widget>[
          const SizedBox(height: 20.0),
          TextFieldNormal(
            labelNama,
            _cnama,
            onChange: (str) {
              if (widget.enumPicOwner == EnumPicOwner.owner) {
                widget.controllOwner!.setNamaOwner(str);
              } else {
                widget.controllPic!.setNamaPic(str);
              }
            },
          ),
          TextFieldNormalNumberOnly(
            labelnohp,
            _cnotelp,
            onChange: (str) {
              if (widget.enumPicOwner == EnumPicOwner.owner) {
                widget.controllOwner!.setNoHp(str);
              } else {
                widget.controllPic!.setNoHp(str);
              }
            },
          ),
          const SizedBox(
            height: 8,
          ),
          ButtonAppTanggal(
            labelTglLahir,
            _currentTgl,
            onTap: () {
              _datePicker();
            },
          ),
          TextFieldNormal(
            'Hobi',
            _chobi,
            onChange: (str) {
              if (widget.enumPicOwner == EnumPicOwner.owner) {
                widget.controllOwner!.setHobi(str);
              } else {
                widget.controllPic!.setHobi(str);
              }
            },
          ),
          TextFieldNormal(
            'Akun Facebook',
            _cfb,
            onChange: (str) {
              if (widget.enumPicOwner == EnumPicOwner.owner) {
                widget.controllOwner!.setFb(str);
              } else {
                widget.controllPic!.setFb(str);
              }
            },
          ),
          TextFieldNormal(
            'Akun Instagram',
            _cig,
            onChange: (str) {
              if (widget.enumPicOwner == EnumPicOwner.owner) {
                widget.controllOwner!.setIg(str);
              } else {
                widget.controllPic!.setIg(str);
              }
            },
          ),
          const SizedBox(
            height: 150.0,
          ),
        ],
      ),
    );
  }

  // Widget _spasi() {
  //   return SizedBox(
  //     height: 8,
  //   );
  // }

  void _datePicker() async {
    DateTime? initialDt;
    if (_currentTgl != null) {
      bool isafter = _currentTgl!.isBefore(DateTime(1900, 1, 1));
      initialDt = isafter ? DateTime(2000, 1, 1) : _currentTgl;
    } else {
      initialDt = DateTime(2000, 1, 1);
    }
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDt!,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      if (widget.enumPicOwner == EnumPicOwner.owner) {
        widget.controllOwner!.setTglLahir(picked);
      } else {
        widget.controllPic!.setTglLahir(picked);
      }
      setState(() {
        _currentTgl = picked;
      });
    }
  }
}
