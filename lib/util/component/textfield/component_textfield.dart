import 'package:flutter/material.dart';

class TextFieldLogin extends StatefulWidget {
  final String text;
  final TextEditingController controller;

  TextFieldLogin(this.text, this.controller);

  @override
  _TextFieldLoginState createState() => _TextFieldLoginState();
}

class _TextFieldLoginState extends State<TextFieldLogin> {
  // * Before
  final TextStyle _labelStyle = TextStyle(color: Colors.grey[600]);
  // * After
  // final TextStyle _labelStyle = TextStyle(color: Color(0xFF644193));
  final TextStyle _textfieldStyle = TextStyle(fontSize: 14);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _label(widget.text),
        _entryField(widget.controller),
      ],
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

  Widget _entryField(TextEditingController controller) {
    return TextFormField(
      style: _textfieldStyle,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      onSaved: (str) {},
      validator: (value) {
        return null;
      },
      maxLines: 1,
      controller: controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
        // labelText: text,
        isDense: true,
      ),
    );
  }
}

class TextFieldPassword extends StatefulWidget {
  final String text;
  final TextEditingController controller;

  TextFieldPassword(this.text, this.controller);

  @override
  _TextFieldPasswordState createState() => _TextFieldPasswordState();
}

class _TextFieldPasswordState extends State<TextFieldPassword> {
  late bool _isHidePassword;
  final TextStyle _labelStyle = TextStyle(color: Colors.grey[600]);
  final TextStyle _textfieldStyle = TextStyle(fontSize: 14);

  @override
  void initState() {
    _isHidePassword = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _label(widget.text),
        _entryFieldPassword(widget.controller),
      ],
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

  Widget _entryFieldPassword(TextEditingController controller) {
    return TextFormField(
      style: _textfieldStyle,
      controller: controller,
      obscureText: _isHidePassword,
      autofocus: false,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
        // hintText: text,
        suffixIcon: GestureDetector(
          onTap: () {
            _togglePasswordVisibility();
          },
          child: Icon(
            _isHidePassword ? Icons.visibility_off : Icons.visibility,
            color: _isHidePassword ? Colors.grey : Colors.blue,
          ),
        ),
        isDense: true,
      ),
    );
  }

  void _togglePasswordVisibility() {
    setState(() {
      _isHidePassword = !_isHidePassword;
    });
  }
}

class TextFieldNumberOnly extends StatefulWidget {
  final String text;
  final TextEditingController? controller;
  final Function(String)? onChanged;
  final bool enable;

  TextFieldNumberOnly(this.text, this.controller,
      {this.onChanged, this.enable = true});

  @override
  _TextFieldNumberOnlyState createState() => _TextFieldNumberOnlyState();
}

class _TextFieldNumberOnlyState extends State<TextFieldNumberOnly> {
  final TextStyle _labelStyle = TextStyle(color: Colors.black);
  final TextStyle _textfieldStyle = TextStyle(fontSize: 14);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _label(widget.text),
        _entryField(widget.controller),
      ],
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

  Widget _entryField(TextEditingController? controller) {
    return TextFormField(
      enabled: widget.enable,
      style: _textfieldStyle,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      onSaved: (str) {},
      validator: (value) {
        return null;
      },
      onChanged: (str) {
        if (widget.onChanged != null) {
          widget.onChanged!(str);
        }
      },
      maxLines: 1,
      controller: controller,
      keyboardType: TextInputType.number,
      decoration: const InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
        // labelText: text,
        isDense: true,
      ),
    );
  }
}

class TextFieldNormal extends StatefulWidget {
  final String? strLabel;
  final TextEditingController controller;
  final bool enable;
  final Function? onChange;
  TextFieldNormal(this.strLabel, this.controller,
      {Key? key, this.enable = true, this.onChange})
      : super(key: key);
  @override
  _TextFieldNormalState createState() => _TextFieldNormalState();
}

class _TextFieldNormalState extends State<TextFieldNormal> {
  String _label = '';

  @override
  void initState() {
    _label = '${widget.strLabel}';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final TextStyle style = TextStyle(fontSize: 14);
    return TextFormField(
      style: style,
      enabled: widget.enable,
      onChanged: (str) {
        if (widget.onChange != null) {
          widget.onChange!(str);
        }
      },
      controller: widget.controller,
      decoration: InputDecoration(
        labelText: _label,
      ),
    );
  }
}

class TextFieldNormalNumberOnly extends StatefulWidget {
  final String? strLabel;
  final TextEditingController controller;
  final Function? onChange;
  final bool enable;
  TextFieldNormalNumberOnly(
    this.strLabel,
    this.controller, {
    Key? key,
    this.enable = true,
    this.onChange,
  }) : super(key: key);
  @override
  _TextFieldNormalNumberOnlyState createState() =>
      _TextFieldNormalNumberOnlyState();
}

class _TextFieldNormalNumberOnlyState extends State<TextFieldNormalNumberOnly> {
  String _label = '';

  @override
  void initState() {
    _label = '${widget.strLabel}';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final TextStyle style = TextStyle(fontSize: 14);
    return TextFormField(
      style: style,
      enabled: widget.enable,
      onChanged: (str) {
        if (widget.onChange != null) {
          widget.onChange!(str);
        }
      },
      controller: widget.controller,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: _label,
      ),
    );
  }
}
