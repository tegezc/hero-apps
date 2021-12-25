import 'package:flutter/material.dart';
import 'package:hero/model/enumapp.dart';
import 'package:hero/model/lokasi/owner.dart';
import 'package:hero/model/lokasi/pic.dart';
import 'package:hero/util/component/component_label.dart';

class ViewPageIdentitas extends StatelessWidget {
  final EnumPicOwner enumPicOwner;
  final Pic? pic;
  final Owner? owner;
  ViewPageIdentitas(this.enumPicOwner, {this.pic, this.owner});
  @override
  Widget build(BuildContext context) {
    String? nama = '-';
    String? nohp = '-';
    String tglLahir = '-';
    String? hobi = '-';
    String? fb = '-';
    String? ig = '-';

    if (enumPicOwner == EnumPicOwner.owner && owner != null) {
      nama = owner!.getNama();
      nohp = owner!.getNohp();
      tglLahir = owner!.getTglLahir();
      hobi = owner!.getHobi();
      fb = owner!.getFb();
      ig = owner!.getIg();
    } else if (pic != null) {
      nama = pic!.getNama();
      nohp = pic!.getNohp();
      tglLahir = pic!.getTglLahir();
      hobi = pic!.getHobi();
      fb = pic!.getFb();
      ig = pic!.getIg();
    }
    return Container(
      child: Form(
        autovalidateMode: AutovalidateMode.always,
        child: new ListView(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          children: <Widget>[
            SizedBox(height: 20.0),
            Label2row('Nama:', nama),
            _spasi(),
            Label2row('No Telp:', nohp),
            _spasi(),
            Label2row('Tanggal Lahir:', tglLahir),
            _spasi(),
            Label2row('Hobi:', hobi),
            _spasi(),
            Label2row('Account Facebook:', fb),
            _spasi(),
            Label2row('Account Instagram:', ig),
            _spasi(),
            SizedBox(
              height: 150.0,
            ),
          ],
        ),
      ),
    );
  }

  Widget _spasi() {
    return Column(
      children: [
        SizedBox(height: 12),
        Divider(),
      ],
    );
  }
}
