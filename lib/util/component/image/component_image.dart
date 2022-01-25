import 'package:flutter/material.dart';

class PropertyImage extends StatelessWidget {
  final EnumPropertyImage _enumProperty;

  const PropertyImage.bgatas({Key? key})
      : _enumProperty = EnumPropertyImage.bgatas,
        super(key: key);

  const PropertyImage.bgbawah({Key? key})
      : _enumProperty = EnumPropertyImage.bgbawah,
        super(key: key);

  const PropertyImage.map({Key? key})
      : _enumProperty = EnumPropertyImage.map,
        super(key: key);

  const PropertyImage.textWelcome({Key? key})
      : _enumProperty = EnumPropertyImage.textwelcome,
        super(key: key);

  const PropertyImage.textReset({Key? key})
      : _enumProperty = EnumPropertyImage.textreset,
        super(key: key);

  const PropertyImage.logo({Key? key})
      : _enumProperty = EnumPropertyImage.logo,
        super(key: key);

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
    return const Center(
      child: FractionallySizedBox(
          widthFactor: 0.6,
          child: Image(image: AssetImage('assets/image/bgmap.png'))),
    );
  }

  Widget _textresetpassword() {
    return const Padding(
      padding: EdgeInsets.only(left: 16.0),
      child: FractionallySizedBox(
          widthFactor: 0.6,
          child: Image(image: AssetImage('assets/image/textreset.png'))),
    );
  }

  Widget _textwelcome() {
    return const Center(
      child: FractionallySizedBox(
          widthFactor: 0.6,
          child: Image(image: AssetImage('assets/image/textwelcome.png'))),
    );
  }

  Widget _bgbawah(double height) {
    return SingleChildScrollView(
      child: SizedBox(
        height: height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.end,
          children: const [
            FractionallySizedBox(
                widthFactor: 1,
                child: Image(image: AssetImage('assets/image/bgbawah.png'))),
          ],
        ),
      ),
    );
  }

  Widget _bgatas() {
    return const FractionallySizedBox(
        widthFactor: 0.8,
        child: Image(image: AssetImage('assets/image/bgatas.png')));
  }

  Widget _logo() {
    return const Image(image: AssetImage('assets/image/logoappbar.png'));
  }
}

enum EnumPropertyImage { bgatas, bgbawah, map, textwelcome, textreset, logo }
