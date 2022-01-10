import 'package:flutter/material.dart';

class PropertyImage extends StatelessWidget {
  final EnumPropertyImage _enumProperty;

  PropertyImage.bgatas() : _enumProperty = EnumPropertyImage.bgatas;

  PropertyImage.bgbawah() : _enumProperty = EnumPropertyImage.bgbawah;

  PropertyImage.map() : _enumProperty = EnumPropertyImage.map;

  PropertyImage.textWelcome() : _enumProperty = EnumPropertyImage.textwelcome;

  PropertyImage.textReset() : _enumProperty = EnumPropertyImage.textreset;

  PropertyImage.logo() : _enumProperty = EnumPropertyImage.logo;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    switch (_enumProperty) {
      case EnumPropertyImage.bgatas:
        return _bgatas();
      case EnumPropertyImage.bgbawah:
        return _bgbawah(size.height);
      case EnumPropertyImage.map:
        return _map();
      case EnumPropertyImage.textwelcome:
        return _textwelcome();
      case EnumPropertyImage.textreset:
        return _textresetpassword();
      case EnumPropertyImage.logo:
        return _logo();
      default:
        return Container();
    }
    
  }

  Widget _map() {
    return Center(
      child: FractionallySizedBox(
          widthFactor: 0.6,
          child: Image(image: AssetImage('assets/image/bgmap.png'))),
    );
  }

  Widget _textresetpassword() {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0),
      child: FractionallySizedBox(
          widthFactor: 0.6,
          child: Image(image: AssetImage('assets/image/textreset.png'))),
    );
  }

  Widget _textwelcome() {
    return Center(
      child: FractionallySizedBox(
          widthFactor: 0.6,
          child: Image(image: AssetImage('assets/image/textwelcome.png'))),
    );
  }

  Widget _bgbawah(double height) {
    return SingleChildScrollView(
      child: Container(
        height: height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FractionallySizedBox(
                widthFactor: 1,
                child: Image(image: AssetImage('assets/image/bgbawah.png'))),
          ],
        ),
      ),
    );
  }

  Widget _bgatas() {
    return FractionallySizedBox(
        widthFactor: 0.8,
        child: Image(image: AssetImage('assets/image/bgatas.png')));
  }

  Widget _logo() {
    return Image(image: AssetImage('assets/image/logoappbar.png'));
  }
}

enum EnumPropertyImage { bgatas, bgbawah, map, textwelcome, textreset, logo }
