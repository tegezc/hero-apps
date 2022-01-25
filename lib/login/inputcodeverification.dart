import 'package:flutter/material.dart';
import 'package:hero/util/component/button/component_button.dart';
import 'package:hero/util/component/image/component_image.dart';
import 'package:hero/util/component/textfield/component_textfield.dart';

class InputCodeVerification extends StatefulWidget {
  static const routeName = 'inputcodeverification';

  const InputCodeVerification({Key? key}) : super(key: key);

  @override
  _InputCodeVerificationState createState() => _InputCodeVerificationState();
}

class _InputCodeVerificationState extends State<InputCodeVerification> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final idTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  final _confirmpasswordTextController = TextEditingController();
  final TextStyle _labelStyle = TextStyle(color: Colors.grey[600]);

  Widget _emailPasswordWidget() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            //  _entryField1("Enter Code", idTextController),
            TextFieldLogin('Enter Kode Verifikasi', idTextController),
            const SizedBox(
              height: 15,
            ),
            //   _entryFieldPassword("Password", passwordTextController),
            TextFieldPassword('Password Baru', passwordTextController),
            const SizedBox(
              height: 15,
            ),
            TextFieldPassword(
                'Konfirmasi Password Baru', _confirmpasswordTextController),
            //     _entryFieldPassword("Confirm Password", _confirmpasswordTextController),
            const SizedBox(
              height: 12,
            ),
            //  _animationLogin(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ButtonLogin('Submit', onTap: () {
                  Future.delayed(const Duration(seconds: 1), () {
                    Navigator.popUntil(
                        context,
                        ModalRoute.withName(
                          '/',
                        ));
                  });
                }),
                ButtonGray('Kembali ke Login', onTap: () {
                  Navigator.popUntil(context, ModalRoute.withName('/'));
                }),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size m = MediaQuery.of(context).size;
    return Scaffold(
        body: Stack(
      children: [
        const PropertyImage.bgatas(),
        const PropertyImage.bgbawah(),
        SizedBox(
          height: m.height,
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Container(
                color: Colors.transparent,
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
                          'Kode Verifikasi sudah terkirim ke email terdaftar'),
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
        ),
      ],
    ));
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
}
