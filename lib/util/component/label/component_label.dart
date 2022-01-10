import 'package:flutter/material.dart';

class LabelGray extends StatelessWidget {
  final String text;

  LabelGray(this.text);

  final TextStyle _labelStyle = TextStyle(color: Colors.grey[600]);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: _labelStyle,
    );
  }
}

class LabelBlack extends StatelessWidget {
  final String? text;
  final double _fontsize;
  final bool bold;
  LabelBlack.title(this.text, {this.bold = false}) : _fontsize = 20.0;
  LabelBlack.size1(this.text, {this.bold = false}) : _fontsize = 16.0;
  LabelBlack.size2(this.text, {this.bold = false}) : _fontsize = 14.0;
  LabelBlack.size3(this.text, {this.bold = false}) : _fontsize = 12.0;
  LabelBlack.size4(this.text, {this.bold = false}) : _fontsize = 10.0;

  @override
  Widget build(BuildContext context) {
    TextStyle _labelStyle = TextStyle(
        color: Colors.black,
        fontSize: _fontsize,
        fontWeight: FontWeight.normal);
    if (this.bold) {
      _labelStyle = TextStyle(
          color: Colors.black,
          fontSize: _fontsize,
          fontWeight: FontWeight.bold);
    }

    return Text(
      text!,
      maxLines: 5,
      style: _labelStyle,
    );
  }
}

class LabelWhite extends StatelessWidget {
  final String? text;
  final double _fontsize;
  final bool bold;
  LabelWhite.title(this.text, {this.bold = false}) : _fontsize = 20.0;
  LabelWhite.size1(this.text, {this.bold = false}) : _fontsize = 16.0;
  LabelWhite.size2(this.text, {this.bold = false}) : _fontsize = 14.0;
  LabelWhite.size3(this.text, {this.bold = false}) : _fontsize = 12.0;
  LabelWhite.size4(this.text, {this.bold = false}) : _fontsize = 10.0;

  @override
  Widget build(BuildContext context) {
    TextStyle _labelStyle = TextStyle(
        color: Colors.white,
        fontSize: _fontsize,
        fontWeight: FontWeight.normal);
    if (this.bold) {
      _labelStyle = TextStyle(
          color: Colors.white,
          fontSize: _fontsize,
          fontWeight: FontWeight.bold);
    }

    return Text(
      text!,
      maxLines: 5,
      style: _labelStyle,
    );
  }
}

class LabelApp extends StatelessWidget {
  final String? text;
  final double fontsize;
  final bool bold;
  final Color color;
  LabelApp.title(this.text, {this.bold = false, this.color = Colors.black})
      : fontsize = 20.0;
  LabelApp.size1(this.text, {this.bold = false, this.color = Colors.black})
      : fontsize = 16.0;
  LabelApp.size2(this.text, {this.bold = false, this.color = Colors.black})
      : fontsize = 14.0;
  LabelApp.size3(this.text, {this.bold = false, this.color = Colors.black})
      : fontsize = 12.0;
  LabelApp.size4(this.text, {this.bold = false, this.color = Colors.black})
      : fontsize = 10.0;
  LabelApp.flexSize(this.text,
      {this.bold = false, this.color = Colors.black, this.fontsize = 12});

  @override
  Widget build(BuildContext context) {
    TextStyle _labelStyle = TextStyle(
        color: this.color, fontSize: fontsize, fontWeight: FontWeight.normal);
    if (this.bold) {
      _labelStyle = TextStyle(
          color: this.color, fontSize: fontsize, fontWeight: FontWeight.bold);
    }

    return Text(
      text!,
      maxLines: 2,
      style: _labelStyle,
    );
  }
}

class LabelAppMiring extends StatelessWidget {
  final String text;
  final double fontsize;
  final bool bold;
  final Color? color;
  final TextAlign textAlign;
  LabelAppMiring.title(this.text,
      {this.bold = false,
      this.color = Colors.black,
      this.textAlign = TextAlign.left})
      : fontsize = 20.0;
  LabelAppMiring.size1(this.text,
      {this.bold = false,
      this.color = Colors.black,
      this.textAlign = TextAlign.left})
      : fontsize = 16.0;
  LabelAppMiring.size2(this.text,
      {this.bold = false,
      this.color = Colors.black,
      this.textAlign = TextAlign.left})
      : fontsize = 14.0;
  LabelAppMiring.size3(this.text,
      {this.bold = false,
      this.color = Colors.black,
      this.textAlign = TextAlign.left})
      : fontsize = 12.0;
  LabelAppMiring.size4(this.text,
      {this.bold = false,
      this.color = Colors.black,
      this.textAlign = TextAlign.left})
      : fontsize = 10.0;
  LabelAppMiring.flexSize(this.text,
      {this.bold = false,
      this.color = Colors.black,
      this.fontsize = 12,
      this.textAlign = TextAlign.left});

  @override
  Widget build(BuildContext context) {
    TextStyle _labelStyle = TextStyle(
        color: this.color,
        fontSize: fontsize,
        fontWeight: FontWeight.normal,
        fontStyle: FontStyle.italic);
    if (this.bold) {
      _labelStyle = TextStyle(
          color: this.color,
          fontSize: fontsize,
          fontWeight: FontWeight.bold,
          fontStyle: FontStyle.italic);
    }

    return Text(
      text,
      textAlign: textAlign,
      maxLines: 2,
      style: _labelStyle,
    );
  }
}

class Label2row extends StatelessWidget {
  final String text1;
  final String? text2;
  Label2row(this.text1, this.text2);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LabelApp.size2(
            text1,
            color: Colors.grey,
          ),
          SizedBox(
            height: 4,
          ),
          LabelApp.size1(text2),
        ],
      ),
    );
  }
}

class Label2rowv1 extends StatelessWidget {
  final String text1;
  final String text2;
  Label2rowv1(this.text1, this.text2);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LabelApp.size2(
            text1,
            color: Colors.black,
          ),
          SizedBox(
            height: 4,
          ),
          LabelApp.size3(
            text2,
            color: Colors.red,
          ),
        ],
      ),
    );
  }
}

class LabelAppRich extends StatelessWidget {
  final String text1;
  final String text2;
  final double fontsize;
  final bool bold;
  final Color? color;
  LabelAppRich.title(this.text1,
      {this.text2 = '*', this.bold = false, this.color = Colors.black})
      : fontsize = 20.0;
  LabelAppRich.size1(this.text1,
      {this.text2 = '*', this.bold = false, this.color = Colors.black})
      : fontsize = 16.0;
  LabelAppRich.size2(this.text1,
      {this.text2 = '*', this.bold = false, this.color = Colors.black})
      : fontsize = 14.0;
  LabelAppRich.size3(this.text1,
      {this.text2 = '*', this.bold = false, this.color = Colors.black})
      : fontsize = 12.0;
  LabelAppRich.size4(this.text1,
      {this.text2 = '*', this.bold = false, this.color = Colors.black})
      : fontsize = 10.0;
  LabelAppRich.flexSize(this.text1,
      {this.text2 = '*',
      this.bold = false,
      this.color = Colors.black,
      this.fontsize = 12});

  @override
  Widget build(BuildContext context) {
    TextStyle _labelStyle = TextStyle(
        color: this.color, fontSize: fontsize, fontWeight: FontWeight.normal);
    if (this.bold) {
      _labelStyle = TextStyle(
          color: this.color, fontSize: fontsize, fontWeight: FontWeight.bold);
    }
    TextStyle _textstyle2 = TextStyle(
        color: Colors.red,
        fontSize: fontsize,
        fontWeight: FontWeight.bold,
        fontStyle: FontStyle.italic);

    return RichText(
      text: TextSpan(
        text: text1,
        style: _labelStyle,
        children: <TextSpan>[
          TextSpan(text: text2, style: _textstyle2),
        ],
      ),
    );
  }
}
