import 'package:flutter/material.dart';
import 'package:hero/util/component/image/component_image.dart';
import 'package:hero/util/component/loading/component_loading.dart';

class LoadingLoginPage extends StatefulWidget {
  const LoadingLoginPage({Key? key}) : super(key: key);

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
        const PropertyImage.bgatas(),
        const PropertyImage.bgbawah(),
        SizedBox(
          height: size.height,
          child: SingleChildScrollView(
            child: Form(
              child: Container(
                color: Colors.transparent,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 50,
                    ),
                    const PropertyImage.map(),
                    const SizedBox(
                      height: 30,
                    ),
                    const PropertyImage.textWelcome(),
                    const SizedBox(
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
            const LoadingTextFieldLogin(0.9),
            const SizedBox(
              height: 20,
            ),
            const LoadingTextFieldLogin(0.9),
            // _label('Password'),
            // _entryFieldPassword(_passwordTextController),
            const SizedBox(
              height: 12,
            ),
            //_animationLogin(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
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
