import 'package:flutter/material.dart';
import 'package:hero/util/component/component_image.dart';
import 'package:hero/util/component/component_loading.dart';

class LoadingLoginPage extends StatefulWidget {
  @override
  _LoadingLoginPageState createState() => _LoadingLoginPageState();
}

class _LoadingLoginPageState extends State<LoadingLoginPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: Stack(
      children: [
        PropertyImage.bgatas(),
        PropertyImage.bgbawah(),
        Container(
          height: size.height,
          child: SingleChildScrollView(
            child: Form(
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
                    PropertyImage.textWelcome(),
                    SizedBox(
                      height: 30,
                    ),
                    _contentForm(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    ));
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
            LoadingTextFieldLogin(0.9),
            SizedBox(
              height: 20,
            ),
            LoadingTextFieldLogin(0.9),
            // _label('Password'),
            // _entryFieldPassword(_passwordTextController),
            SizedBox(
              height: 12,
            ),
            //_animationLogin(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                LoadComponent1(45, 100),
                LoadComponent1(45, 120),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
