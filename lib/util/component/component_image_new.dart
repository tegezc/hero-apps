import 'package:flutter/material.dart';

class PropertyImage extends StatelessWidget {
  final EnumPropertyImage _enumProperty;

  // PropertyImage.bgatas() : _enumProperty = EnumPropertyImage.bgatas;

  PropertyImage.bgbawah() : _enumProperty = EnumPropertyImage.bgbawah;

  PropertyImage.map() : _enumProperty = EnumPropertyImage.map;

  PropertyImage.textWelcome() : _enumProperty = EnumPropertyImage.textwelcome;

  PropertyImage.textReset() : _enumProperty = EnumPropertyImage.textreset;

  // PropertyImage.logo() : _enumProperty = EnumPropertyImage.logo;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    switch (_enumProperty) {
      // case EnumPropertyImage.bgatas:
      //   return _bgatas();
      case EnumPropertyImage.bgbawah:
        return _bgbawah(size.height + 8.5);
      case EnumPropertyImage.map:
        return _map();
      // case EnumPropertyImage.textwelcome:
      //   return _textwelcome();
      case EnumPropertyImage.textreset:
        return _textresetpassword();
      // case EnumPropertyImage.logo:
      //   return _logo();
      default:
        return Container();
    }
  }

  Widget _map() {
    return Center(
      child: FractionallySizedBox(
          widthFactor: 0.6,
          child: Image(image: AssetImage('assets/image/new/big_logo.png'))),
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

  // Widget _textwelcome() {
  //   return Center(
  //     child: FractionallySizedBox(
  //         widthFactor: 0.6,
  //         child: Image(image: AssetImage('assets/image/textwelcome.png'))),
  //   );
  // }

  Widget _bgbawah(double height) {
    return SingleChildScrollView(
      child: Container(
        height: height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/image/new/BG.png'),
            fit: BoxFit.cover,
          ),
        ),
        // child:
        // Column(
        //   crossAxisAlignment: CrossAxisAlignment.center,
        //   mainAxisSize: MainAxisSize.max,
        //   mainAxisAlignment: MainAxisAlignment.end,
        //   children: [
        //     Container()
        //     // FractionallySizedBox(
        //     //     widthFactor: 1,
        //     //     child: Image(image: AssetImage('assets/image/new/BG.png'))),
        //   ],
        // ),
      ),
    );
  }

  // Widget _bgatas() {
  //   return FractionallySizedBox(
  //       widthFactor: 0.8,
  //       child: Image(image: AssetImage('assets/image/bgatas.png')));
  // }

  // Widget _logo() {
  //   return Image(image: AssetImage('assets/image/logoappbar.png'));
  // }
}

class ClockInImageIcon extends StatefulWidget {
  final Function onTap;
  final String image;
  final String disableImage;
  final double width;
  final bool? enable;

  const ClockInImageIcon(
      {required this.onTap, required this.image, required this.disableImage, this.enable = true, this.width = 140});

  @override
  State<ClockInImageIcon> createState() => _ClockInImageIconState();
}

class _ClockInImageIconState extends State<ClockInImageIcon> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        widget.enable! ? widget.onTap() : print('');
      },
      child: Image(
        image: AssetImage(widget.enable! ? widget.image : widget.disableImage),
        width: widget.width,
      )
    );
  }
}

enum EnumPropertyImage { bgbawah, map, textwelcome, textreset, logo }
