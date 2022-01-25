import 'package:flutter/material.dart';

class LabelGray extends StatelessWidget {
  final String text;

  LabelGray(this.text, {Key? key}) : super(key: key);

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
  const LabelBlack.title(this.text, {Key? key, this.bold = false})
      : _fontsize = 20.0,
        super(key: key);
  const LabelBlack.size1(this.text, {Key? key, this.bold = false})
      : _fontsize = 16.0,
        super(key: key);
  const LabelBlack.size2(this.text, {Key? key, this.bold = false})
      : _fontsize = 14.0,
        super(key: key);
  const LabelBlack.size3(this.text, {Key? key, this.bold = false})
      : _fontsize = 12.0,
        super(key: key);
  const LabelBlack.size4(this.text, {Key? key, this.bold = false})
      : _fontsize = 10.0,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    TextStyle _labelStyle = TextStyle(
        color: Colors.black,
        fontSize: _fontsize,
        fontWeight: FontWeight.normal);
    if (bold) {
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
  const LabelWhite.title(this.text, {Key? key, this.bold = false})
      : _fontsize = 20.0,
        super(key: key);
  const LabelWhite.size1(this.text, {Key? key, this.bold = false})
      : _fontsize = 16.0,
        super(key: key);
  const LabelWhite.size2(this.text, {Key? key, this.bold = false})
      : _fontsize = 14.0,
        super(key: key);
  const LabelWhite.size3(this.text, {Key? key, this.bold = false})
      : _fontsize = 12.0,
        super(key: key);
  const LabelWhite.size4(this.text, {Key? key, this.bold = false})
      : _fontsize = 10.0,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    TextStyle _labelStyle = TextStyle(
        color: Colors.white,
        fontSize: _fontsize,
        fontWeight: FontWeight.normal);
    if (bold) {
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
  const LabelApp.title(this.text,
      {Key? key, this.bold = false, this.color = Colors.black})
      : fontsize = 20.0,
        super(key: key);
  const LabelApp.size1(this.text,
      {Key? key, this.bold = false, this.color = Colors.black})
      : fontsize = 16.0,
        super(key: key);
  const LabelApp.size2(this.text,
      {Key? key, this.bold = false, this.color = Colors.black})
      : fontsize = 14.0,
        super(key: key);
  const LabelApp.size3(this.text,
      {Key? key, this.bold = false, this.color = Colors.black})
      : fontsize = 12.0,
        super(key: key);
  const LabelApp.size4(this.text,
      {Key? key, this.bold = false, this.color = Colors.black})
      : fontsize = 10.0,
        super(key: key);
  const LabelApp.flexSize(this.text,
      {Key? key,
      this.bold = false,
      this.color = Colors.black,
      this.fontsize = 12})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextStyle _labelStyle = TextStyle(
        color: color, fontSize: fontsize, fontWeight: FontWeight.normal);
    if (bold) {
      _labelStyle = TextStyle(
          color: color, fontSize: fontsize, fontWeight: FontWeight.bold);
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
  const LabelAppMiring.title(this.text,
      {Key? key,
      this.bold = false,
      this.color = Colors.black,
      this.textAlign = TextAlign.left})
      : fontsize = 20.0,
        super(key: key);
  const LabelAppMiring.size1(this.text,
      {Key? key,
      this.bold = false,
      this.color = Colors.black,
      this.textAlign = TextAlign.left})
      : fontsize = 16.0,
        super(key: key);
  const LabelAppMiring.size2(this.text,
      {Key? key,
      this.bold = false,
      this.color = Colors.black,
      this.textAlign = TextAlign.left})
      : fontsize = 14.0,
        super(key: key);
  const LabelAppMiring.size3(this.text,
      {Key? key,
      this.bold = false,
      this.color = Colors.black,
      this.textAlign = TextAlign.left})
      : fontsize = 12.0,
        super(key: key);
  const LabelAppMiring.size4(this.text,
      {Key? key,
      this.bold = false,
      this.color = Colors.black,
      this.textAlign = TextAlign.left})
      : fontsize = 10.0,
        super(key: key);
  const LabelAppMiring.flexSize(this.text,
      {Key? key,
      this.bold = false,
      this.color = Colors.black,
      this.fontsize = 12,
      this.textAlign = TextAlign.left})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextStyle _labelStyle = TextStyle(
        color: color,
        fontSize: fontsize,
        fontWeight: FontWeight.normal,
        fontStyle: FontStyle.italic);
    if (bold) {
      _labelStyle = TextStyle(
          color: color,
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
  const Label2row(this.text1, this.text2, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LabelApp.size2(
          text1,
          color: Colors.grey,
        ),
        const SizedBox(
          height: 4,
        ),
        LabelApp.size1(text2),
      ],
    );
  }
}

class Label2rowv1 extends StatelessWidget {
  final String text1;
  final String text2;
  const Label2rowv1(this.text1, this.text2, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LabelApp.size2(
          text1,
          color: Colors.black,
        ),
        const SizedBox(
          height: 4,
        ),
        LabelApp.size3(
          text2,
          color: Colors.red,
        ),
      ],
    );
  }
}

class LabelAppRich extends StatelessWidget {
  final String text1;
  final String text2;
  final double fontsize;
  final bool bold;
  final Color? color;
  const LabelAppRich.title(this.text1,
      {Key? key,
      this.text2 = '*',
      this.bold = false,
      this.color = Colors.black})
      : fontsize = 20.0,
        super(key: key);
  const LabelAppRich.size1(this.text1,
      {Key? key,
      this.text2 = '*',
      this.bold = false,
      this.color = Colors.black})
      : fontsize = 16.0,
        super(key: key);
  const LabelAppRich.size2(this.text1,
      {Key? key,
      this.text2 = '*',
      this.bold = false,
      this.color = Colors.black})
      : fontsize = 14.0,
        super(key: key);
  const LabelAppRich.size3(this.text1,
      {Key? key,
      this.text2 = '*',
      this.bold = false,
      this.color = Colors.black})
      : fontsize = 12.0,
        super(key: key);
  const LabelAppRich.size4(this.text1,
      {Key? key,
      this.text2 = '*',
      this.bold = false,
      this.color = Colors.black})
      : fontsize = 10.0,
        super(key: key);
  const LabelAppRich.flexSize(this.text1,
      {Key? key,
      this.text2 = '*',
      this.bold = false,
      this.color = Colors.black,
      this.fontsize = 12})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextStyle _labelStyle = TextStyle(
        color: color, fontSize: fontsize, fontWeight: FontWeight.normal);
    if (bold) {
      _labelStyle = TextStyle(
          color: color, fontSize: fontsize, fontWeight: FontWeight.bold);
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
