import 'package:flutter/material.dart';

import '../dateutil.dart';
import 'component_label.dart';

/// komponen untuk login
class ButtonLogin extends StatefulWidget {
  final String text;
  final Function onTap;
  final bool? isfreshstate;

  ButtonLogin(this.text, {required this.onTap, this.isfreshstate});

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
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
          // alignment: Alignment.center,
          decoration: BoxDecoration(
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
            style: TextStyle(fontSize: 14, color: Colors.white),
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
        padding: EdgeInsets.symmetric(vertical: 15),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ),
        child: CircularProgressIndicator(
          backgroundColor: Colors.white,
        ),
      ),
    );
  }
}

class ButtonGray extends StatelessWidget {
  final String text;
  final Function onTap;

  ButtonGray(this.text, {required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, left: 2),
      child: GestureDetector(
        onTap: () {
          onTap();
        },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 14),
          // alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(8)),
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

  ButtonRed(this.text, {required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, left: 2),
      child: GestureDetector(
        onTap: () {
          onTap();
        },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 14),
          // alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.red[600]!,
            borderRadius: BorderRadius.all(Radius.circular(8)),
            // border: Border.all(width: 1, color: Colors.red[600]!),
          ),
          child: Text(
              text,
              style: const TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
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
  final EnumWarnaButton enumWarnaButton;
  final bool enable;

  ButtonApp.red(this.text, this.onTap, {this.enable = true})
      : enumWarnaButton = EnumWarnaButton.red;

  ButtonApp.blue(this.text, this.onTap, {this.enable = true})
      : enumWarnaButton = EnumWarnaButton.blue;

  ButtonApp.yellow(this.text, this.onTap, {this.enable = true})
      : enumWarnaButton = EnumWarnaButton.yellow;

  ButtonApp.green(this.text, this.onTap, {this.enable = true})
      : enumWarnaButton = EnumWarnaButton.green;

  ButtonApp.black(this.text, this.onTap, {this.enable = true})
      : enumWarnaButton = EnumWarnaButton.black;

  ButtonApp.white(this.text, this.onTap, {this.enable = true})
      : enumWarnaButton = EnumWarnaButton.white;

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
        _color = Color(0xFFFF7F50);
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
    // return OutlineButton(
    //   child: Text(
    //     widget.text,
    //     style: style,
    //   ),
    //   onPressed: widget.enable
    //       ? () {
    //           widget.onTap();
    //         }
    //       : null,
    //   borderSide: BorderSide(
    //     color: widget.enable ? _color : Colors.grey, //Color of the border
    //     style: BorderStyle.solid, //Style of the border
    //     width: 0.7, //width of the border
    //   ),
    // );
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
        shape: new RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(30.0)
        ),
        // backgroundColor: Colors.white,
        primary: _color,
        side: BorderSide(color: _color!, width: 0.5),
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

  ButtonMenu(this.icon, this.text, this.onTap,
      {this.height = 110,
      this.width = 140,
      this.iconSize = 60,
      this.enable = true});

  @override
  _ButtonMenuState createState() => _ButtonMenuState();
}

class _ButtonMenuState extends State<ButtonMenu> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.enable! ? widget.onTap() : print('');
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
            SizedBox(
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
  ButtonAppSolid(this.text, {required this.onTap});

  @override
  Widget build(BuildContext context) {
    return _loginButton();
  }

  Widget _loginButton() {
    return InkWell(
      onTap: () {
        this.onTap();
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0, left: 2),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
          // alignment: Alignment.center,
          decoration: BoxDecoration(
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
          child: Center(
            child: Text(
              this.text,
              style: TextStyle(
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
  ButtonAppTanggal(this.label, this.dt, {required this.onTap});

  @override
  Widget build(BuildContext context) {
    return _loginButton();
  }

  Widget _loginButton() {
    String strDate = DateUtility.dateToStringDdMmYyyy(this.dt);
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, left: 2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LabelBlack.size2(label),
          SizedBox(
            height: 4,
          ),
          GestureDetector(
            onTap: () {
              this.onTap();
            },
            child: Container(
              // padding: EdgeInsets.symmetric(vertical: 2, horizontal: 20),
              // alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(8)),
                border: Border.all(color: Colors.black),
              ),
              child: ListTile(
                title: Text(
                  strDate,
                  style: TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                trailing: Icon(
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
  ButtonTglVer1(this.width, this.label, this.dt, {required this.onTap});

  @override
  Widget build(BuildContext context) {
    return _layout();
  }

  Widget _layout() {
    String strDate = DateUtility.dateToStringDdMmYyyy(this.dt);
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, left: 2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LabelBlack.size2(label),
          SizedBox(
            height: 4,
          ),
          GestureDetector(
            onTap: () {
              this.onTap();
            },
            child: Container(
              width: width,
              // padding: EdgeInsets.symmetric(vertical: 2, horizontal: 20),
              // alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(8)),
                border: Border.all(color: Colors.blue),
              ),
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      strDate,
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    Icon(
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
        padding: EdgeInsets.symmetric(vertical: 15),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ),
        child: CircularProgressIndicator(
          backgroundColor: Colors.white,
        ),
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
