import 'package:flutter/material.dart';
import 'package:hero/http/login/httplogin.dart';
import 'package:hero/model/profile.dart';
import 'package:hero/util/component/component_button.dart';
import 'package:hero/util/component/component_image_new.dart';
import 'package:hero/util/component/component_label.dart';
import 'package:hero/util/component/component_textfield.dart';
import 'package:hero/util/constapp/accountcontroller.dart';

class LoginPage extends StatefulWidget {
  final Function callbackSuccessLogin;

  LoginPage(this.callbackSuccessLogin);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _idTextController = TextEditingController();
  final _passwordTextController = TextEditingController();
  late bool _isloading;
  late bool _isShowLoginGagal;

  @override
  void initState() {
    _isShowLoginGagal = false;
    _isloading = false;
    super.initState();
  }

  @override
  void dispose() {
    _idTextController.dispose();
    _passwordTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: Stack(children: [
      PropertyImage.bgbawah(),
      Container(
        height: size.height,
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Container(
              color: Colors.transparent,
              child: Column(
                children: [
                  SizedBox(
                    height: 50,
                  ),
                  PropertyImage.map(),
                  SizedBox(
                    height: 30,
                  ),
                  // PropertyImage.textWelcome(),
                  // SizedBox(
                  //   height: 30,
                  // ),
                  _contentForm(),
                ],
              ),
            ),
          ),
        ),
      ),
    ]));
  }

  Widget _contentForm() {
    return Center(
      child: FractionallySizedBox(
        widthFactor: 0.9,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // _label('Username'),
            // _entryField1(_idTextController),
            TextFieldLogin('Username', _idTextController),
            SizedBox(
              height: 20,
            ),
            TextFieldPassword('Password', _passwordTextController),
            // _label('Password'),
            // _entryFieldPassword(_passwordTextController),
            _isShowLoginGagal ? _ketLoginGagal() : Container(),
            SizedBox(
              height: 12,
            ),
            //_animationLogin(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _isloading
                    ? ButtonAppLoading()
                    : ButtonAppSolid('Login', onTap: () {
                        setState(() {
                          _isloading = true;
                        });
                        Future.delayed(const Duration(milliseconds: 500), () {
                          _proseslogin();
                        });
                      }),
                // ButtonRed('Reset Password', onTap: () {
                //   Navigator.pushNamed(
                //     context,
                //     ResetPassword.routeName,
                //   );
                // }),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _ketLoginGagal() {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
      child: LabelAppMiring.size3(
        'Username atau Password salah.',
        color: Colors.red,
      ),
    );
  }

  void _proseslogin() {
    _extractJsonLogin().then((value) {
      if (value) {
        widget.callbackSuccessLogin();
      } else {
        setState(() {
          _isShowLoginGagal = true;
          _isloading = false;
        });
      }
    });
  }

  Future<bool> _extractJsonLogin() async {
    String username = _idTextController.text;
    String password = _passwordTextController.text;
    HttpLogin httpLogin = HttpLogin();
    Map<String, dynamic>? map = await httpLogin.login(username, password);
    if (map != null) {
      Profile profile = Profile.fromJson(map);
      bool successSet = false;
      if (profile.isValid()) {
        successSet = await AccountHore.setProfile(profile);
      }
      return successSet;
    }
    return false;
  }
}
