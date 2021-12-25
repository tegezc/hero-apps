import 'package:flutter/material.dart';
import 'package:hero/login/inputcodeverification.dart';
import 'package:hero/util/component/component_button.dart';
import 'package:hero/util/component/component_image.dart';
import 'package:hero/util/component/component_textfield.dart';

class ResetPassword extends StatefulWidget {
  static const routeName = '/resetpassword';
  ResetPassword();

  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _idTextController = TextEditingController();
  final TextStyle _labelStyle = TextStyle(color: Colors.grey[600]);

  @override
  void dispose() {
    _idTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size m = MediaQuery.of(context).size;
    return Scaffold(
        body: Stack(
      children: [
        //   _bgatas(),
        PropertyImage.bgatas(),
        //   _bgbawah(m.height),
        PropertyImage.bgbawah(),
        Container(
          height: m.height,
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 50,
                    ),
                    PropertyImage.textReset(),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: _label(
                          'Kode Verifikasi akan dikirim ke email terdaftar'),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    _emailPasswordWidget(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    ));
  }

  Widget _emailPasswordWidget() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            //  _entryField1("User Id", _idTextController),
            TextFieldLogin('Username', _idTextController),
            SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ButtonLogin('Kirim Kode Verifikasi', onTap: () {
                  new Future.delayed(const Duration(milliseconds: 500), () {
                    _handleResetPassword();
                    Navigator.pushNamed(
                      context,
                      InputCodeVerification.routeName,
                    );
                  });
                }),
                ButtonGray('Kembali ke Login', onTap: () {
                  Navigator.of(context).pop();
                }),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _label(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4.0),
      child: Text(
        text,
        style: _labelStyle,
      ),
    );
  }

  void _handleResetPassword() {}
}
