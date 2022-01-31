import 'package:flutter/material.dart';

import '../../../config/configuration_sf.dart';
import '../../colorutil.dart';
import '../../dateutil.dart';
import '../label/component_label.dart';

/// komponen untuk login
class ButtonLogin extends StatefulWidget {
  final String text;
  final Function onTap;
  final bool? isfreshstate;

  const ButtonLogin(this.text,
      {Key? key, required this.onTap, this.isfreshstate})
      : super(key: key);

  @override
  _ButtonLoginState createState() => _ButtonLoginState();
}

class _ButtonLoginState extends State<ButtonLogin> {
  Widget? _widgetforanimationlogin;

  @override
  void initState() {
    _widgetforanimationlogin = _loginButton();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isfreshstate!) {
      _widgetforanimationlogin = _loginButton();
    }
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 100),
      // transitionBuilder: (Widget child, Animation<double> animation) {
      //   return ScaleTransition(child: child, scale: animation);
      // },
      child: _widgetforanimationlogin,
    );
  }

  Widget _loginButton() {
    return InkWell(
      onTap: () {
        setState(() {
          _widgetforanimationlogin = _loadingLogin();
        });
        widget.onTap();
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0, left: 2),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
          // alignment: Alignment.center,
          decoration: const BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.all(Radius.circular(8)),
            // boxShadow: <BoxShadow>[
            //   BoxShadow(
            //       color: Colors.blue,
            //       offset: Offset(2, 4),
            //       blurRadius: 5,
            //       spreadRadius: 2)
            // ],
          ),
          child: Text(
            widget.text,
            style: const TextStyle(fontSize: 14, color: Colors.white),
          ),
        ),
      ),
    );
  }

  Widget _loadingLogin() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        //  width: MediaQuery.of(context).size.width,
        width: 70,
        // height: 50,
        padding: const EdgeInsets.symmetric(vertical: 15),
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ),
        child: const CircularProgressIndicator(
          backgroundColor: Colors.white,
        ),
      ),
    );
  }
}

class ButtonGray extends StatelessWidget {
  final String text;
  final Function onTap;

  const ButtonGray(this.text, {Key? key, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, left: 2),
      child: GestureDetector(
        onTap: () {
          onTap();
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 14),
          // alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            border: Border.all(width: 1, color: Colors.grey[600]!),
          ),
          child: Text(
            text,
            style: TextStyle(fontSize: 14, color: Colors.grey[600]),
          ),
        ),
      ),
    );
  }
}

class ButtonRed extends StatelessWidget {
  final String text;
  final Function onTap;

  const ButtonRed(this.text, {Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, left: 2),
      child: GestureDetector(
        onTap: () {
          onTap();
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 14),
          // alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.red[600]!,
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            // border: Border.all(width: 1, color: Colors.red[600]!),
          ),
          child: Text(
            text,
            style: const TextStyle(
                fontSize: 14, color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}

/// komponen utama
class ButtonApp extends StatefulWidget {
  final Function onTap;
  final String? text;
  final Color? bgColor;
  final EnumWarnaButton enumWarnaButton;
  final bool enable;

  const ButtonApp.red(this.text, this.onTap,
      {Key? key, this.enable = true, this.bgColor = Colors.transparent})
      : enumWarnaButton = EnumWarnaButton.red,
        super(key: key);

  const ButtonApp.blue(this.text, this.onTap,
      {Key? key, this.enable = true, this.bgColor = Colors.transparent})
      : enumWarnaButton = EnumWarnaButton.blue,
        super(key: key);

  const ButtonApp.yellow(this.text, this.onTap,
      {Key? key, this.enable = true, this.bgColor = Colors.transparent})
      : enumWarnaButton = EnumWarnaButton.yellow,
        super(key: key);

  const ButtonApp.green(this.text, this.onTap,
      {Key? key, this.enable = true, this.bgColor = Colors.transparent})
      : enumWarnaButton = EnumWarnaButton.green,
        super(key: key);

  const ButtonApp.black(this.text, this.onTap,
      {Key? key, this.enable = true, this.bgColor = Colors.transparent})
      : enumWarnaButton = EnumWarnaButton.black,
        super(key: key);

  const ButtonApp.white(this.text, this.onTap,
      {Key? key, this.enable = true, this.bgColor = Colors.transparent})
      : enumWarnaButton = EnumWarnaButton.white,
        super(key: key);

  @override
  _ButtonAppState createState() => _ButtonAppState();
}

class _ButtonAppState extends State<ButtonApp> {
  Color? _color;

  @override
  void initState() {
    switch (widget.enumWarnaButton) {
      case EnumWarnaButton.blue:
        _color = Colors.blue;
        break;
      case EnumWarnaButton.red:
        _color = Colors.red;
        break;
      case EnumWarnaButton.yellow:
        _color = const Color(0xFFFF7F50);
        break;
      case EnumWarnaButton.green:
        _color = Colors.green;
        break;
      case EnumWarnaButton.black:
        _color = Colors.black;
        break;
      case EnumWarnaButton.white:
        _color = Colors.white;
        break;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final TextStyle style =
        TextStyle(color: widget.enable ? _color : Colors.grey, fontSize: 12);
    return OutlinedButton(
      onPressed: widget.enable
          ? () {
              widget.onTap();
            }
          : null,
      child: Text(
        widget.text!,
        style: style,
      ),
      style: OutlinedButton.styleFrom(
        backgroundColor: widget.bgColor,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0)),
        // backgroundColor: Colors.white,
        primary: _color,
        side: BorderSide(color: _color!, width: 0.5),
      ),
    );
  }
}

class ButtonCustome extends StatelessWidget {
  final String text;
  final Function onTap;
  const ButtonCustome({Key? key, required this.text, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    const TextStyle style = TextStyle(color: Colors.red, fontSize: 12);
    return OutlinedButton(
      onPressed: () {
        onTap();
      },
      child: Text(
        text,
        style: style,
      ),
      style: OutlinedButton.styleFrom(
        backgroundColor: Colors.white,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0)),
        // backgroundColor: Colors.white,
        //primary: Colors.,
        side: const BorderSide(color: Colors.black, width: 1),
      ),
    );
  }
}

class ButtonMenu extends StatefulWidget {
  final Function onTap;
  final String text;
  final IconData icon;
  final double height;
  final double width;
  final double iconSize;
  final bool? enable;

  const ButtonMenu(this.icon, this.text, this.onTap,
      {Key? key,
      this.height = 110,
      this.width = 140,
      this.iconSize = 60,
      this.enable = true})
      : super(key: key);

  @override
  _ButtonMenuState createState() => _ButtonMenuState();
}

class _ButtonMenuState extends State<ButtonMenu> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.enable! ? widget.onTap() : ph('');
      },
      child: Container(
        height: widget.height,
        width: widget.width,
        margin: const EdgeInsets.all(8.0),
        padding: const EdgeInsets.all(3.0),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              widget.icon,
              size: widget.iconSize,
              color: widget.enable! ? Colors.black : Colors.grey,
            ),
            const SizedBox(
              height: 10,
            ),
            LabelApp.size1(
              widget.text,
              color: widget.enable! ? Colors.black : Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}

class ButtonAppSolid extends StatelessWidget {
  final String text;
  final Function onTap;
  const ButtonAppSolid(this.text, {Key? key, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _loginButton();
  }

  Widget _loginButton() {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0, left: 2),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
          // alignment: Alignment.center,
          decoration: const BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          child: Center(
            child: Text(
              text,
              style: const TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}

class ButtonAppTanggal extends StatelessWidget {
  final String? label;
  final DateTime? dt;
  final Function onTap;
  const ButtonAppTanggal(this.label, this.dt, {Key? key, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _loginButton();
  }

  Widget _loginButton() {
    String strDate = DateUtility.dateToStringDdMmYyyy(dt);
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, left: 2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LabelBlack.size2(label),
          const SizedBox(
            height: 4,
          ),
          GestureDetector(
            onTap: () {
              onTap();
            },
            child: Container(
              // padding: EdgeInsets.symmetric(vertical: 2, horizontal: 20),
              // alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                border: Border.all(color: Colors.black),
              ),
              child: ListTile(
                title: Text(
                  strDate,
                  style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                trailing: const Icon(
                  Icons.calendar_today,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ButtonTglVer1 extends StatelessWidget {
  final String label;
  final DateTime? dt;
  final double width;
  final Function onTap;
  const ButtonTglVer1(this.width, this.label, this.dt,
      {Key? key, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _layout();
  }

  Widget _layout() {
    String strDate = DateUtility.dateToStringDdMmYyyy(dt);
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, left: 2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LabelBlack.size2(label),
          const SizedBox(
            height: 4,
          ),
          GestureDetector(
            onTap: () {
              onTap();
            },
            child: Container(
              width: width,
              // padding: EdgeInsets.symmetric(vertical: 2, horizontal: 20),
              // alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                border: Border.all(color: Colors.blue),
              ),
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      strDate,
                      style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    const Icon(
                      Icons.calendar_today,
                      color: Colors.black,
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ButtonAppLoading extends StatelessWidget {
  const ButtonAppLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _loadingLogin();
  }

  Widget _loadingLogin() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        //  width: MediaQuery.of(context).size.width,
        width: 70,
        // height: 50,
        padding: const EdgeInsets.symmetric(vertical: 15),
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ),
        child: const CircularProgressIndicator(
          backgroundColor: Colors.white,
        ),
      ),
    );
  }
}

class ButtonClockIn extends StatelessWidget {
  final String text;
  final Function onTap;
  final Color? borderColor;
  const ButtonClockIn(
      {Key? key, required this.text, required this.onTap, this.borderColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _loginButton();
  }

  Widget _loginButton() {
    Color _borderColor = borderColor ?? Colors.white;
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0, left: 10, right: 10),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 5),
          // alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.all(Radius.circular(30)),
            border: Border.all(
              color: _borderColor,
              width: 0.5,
            ),
            // boxShadow: <BoxShadow>[
            //   BoxShadow(
            //       color: Colors.blue,
            //       offset: Offset(2, 4),
            //       blurRadius: 5,
            //       spreadRadius: 2)
            // ],
          ),
          child: Center(
            child: Text(
              text,
              style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}

class ButtonClockInGradient extends StatelessWidget {
  final String text;
  final Function onTap;
  const ButtonClockInGradient(
      {Key? key, required this.text, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buttonGradient();
  }

  Widget _buttonGradient() {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0, left: 5, right: 5),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 5),
          // alignment: Alignment.center,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.all(Radius.circular(30)),
              border: Border.all(
                color: Colors.white,
                width: 0.5,
              ),
              gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    HexColor('#cccccc'),
                    HexColor("#F2F2F2"),
                    HexColor("#DBDBDB"),
                    HexColor("#EAEAEA")
                  ])),
          child: Center(
            child: Text(
              text,
              style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}

class ButtonStrectWidth extends StatelessWidget {
  final String text;
  final Function onTap;
  final bool isenable;
  final Color buttonColor;
  const ButtonStrectWidth(
      {Key? key,
      required this.buttonColor,
      required this.text,
      required this.onTap,
      required this.isenable})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color? color = isenable ? buttonColor : Colors.grey[400];
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
        // backgroundColor: Colors.white,
        primary: buttonColor,
        side: BorderSide(color: color!, width: 0.5),
        minimumSize: const Size.fromHeight(
            40), // fromHeight use double.infinity as width and 40 is the height
      ),
      onPressed: isenable
          ? () {
              onTap();
            }
          : null,
      child: Text(
        text,
        style: const TextStyle(fontSize: 11, color: Colors.white),
      ),
    );
  }
}

enum EnumButtonMenu {
  distribution,
  merchandise,
  promotion,
  survey,
  ambilphoto,
  clockin
}

enum EnumWarnaButton { blue, red, yellow, green, black, white }
