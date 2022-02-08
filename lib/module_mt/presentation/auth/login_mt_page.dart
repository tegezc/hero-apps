import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hero/module_mt/presentation/auth/bloc/auth_cubit.dart';
import 'package:hero/util/component/button/component_button.dart';
import 'package:hero/util/component/image/component_image_new.dart';
import 'package:hero/util/component/label/component_label.dart';
import 'package:hero/util/component/textfield/component_textfield.dart';

class LoginPageMt extends StatefulWidget {
  const LoginPageMt({Key? key}) : super(key: key);

  @override
  _LoginPageMtState createState() => _LoginPageMtState();
}

class _LoginPageMtState extends State<LoginPageMt> {
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
        const PropertyImage.bgbawah(),
        SizedBox(
          height: size.height,
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Container(
                color: Colors.transparent,
                child: Column(
                  children: [
                    SizedBox(
                      height: size.height * 0.15,
                    ),
                    const PropertyImage.map(),
                    const SizedBox(
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
        )
      ]),
    );
  }

  Widget _contentForm() {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        return Center(
          child: FractionallySizedBox(
            widthFactor: 0.9,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // _label('Username'),
                // _entryField1(_idTextController),
                TextFieldLogin('Username', _idTextController),
                const SizedBox(
                  height: 20,
                ),
                TextFieldPassword('Password', _passwordTextController),
                // _label('Password'),
                // _entryFieldPassword(_passwordTextController),
                _isShowLoginGagal ? _ketLoginGagal() : Container(),
                const SizedBox(
                  height: 12,
                ),
                //_animationLogin(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _isloading
                        ? const ButtonAppLoading()
                        : ButtonAppSolid('Login', onTap: () {
                            setState(() {
                              _isloading = true;
                            });
                            // String id = _idTextController.text;
                            // String password = _passwordTextController.text;
                            String id = 'REG001-1';
                            String password = 'REG001-CO';
                            context.read<AuthCubit>().login(id, password);
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
      },
    );
  }

  Widget _ketLoginGagal() {
    return const Padding(
      padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
      child: LabelAppMiring.size3(
        'Login gagal.',
        color: Colors.red,
      ),
    );
  }
}
