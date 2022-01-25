import 'package:flutter/material.dart';
import 'package:hero/login/inputcodeverification.dart';
import 'package:hero/util/component/button/component_button.dart';
import 'package:hero/util/component/image/component_image.dart';
import 'package:hero/util/component/textfield/component_textfield.dart';

class ResetPassword extends StatefulWidget {
  static const routeName = '/resetpassword';
  const ResetPassword({Key? key}) : super(key: key);

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
        const PropertyImage.bgatas(),
        //   _bgbawah(m.height),
        const PropertyImage.bgbawah(),
        SizedBox(
          height: m.height,
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  const PropertyImage.textReset(),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: _label(
                        'Kode Verifikasi akan dikirim ke email terdaftar'),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  _emailPasswordWidget(),
                ],
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
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ButtonLogin('Kirim Kode Verifikasi', onTap: () {
                  Future.delayed(const Duration(milliseconds: 500), () {
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
