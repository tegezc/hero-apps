import 'package:flutter/material.dart';
import 'package:hero/model/enumapp.dart';
import 'package:hero/modulapp/merchandising/viewmerchandisingitem.dart';
import 'package:hero/util/component/label/component_label.dart';
import 'package:hero/util/constapp/consstring.dart';

class HomeViewMerchandisingDs extends StatefulWidget {
  const HomeViewMerchandisingDs({Key? key}) : super(key: key);

  @override
  _HomeViewMerchandisingDsState createState() =>
      _HomeViewMerchandisingDsState();
}

class _HomeViewMerchandisingDsState extends State<HomeViewMerchandisingDs> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            bottom: const TabBar(
              isScrollable: true,
              tabs: [
                Tab(
                  child: LabelBlack.size2('Poster'),
                ),
                Tab(
                  child: LabelBlack.size2('Spanduk'),
                ),
              ],
            ),
            backgroundColor: Colors.white,
            iconTheme: const IconThemeData(
              color: Colors.black, //change your color here
            ),
            title: Text(
              ConstString.textMerchandising,
              style: const TextStyle(color: Colors.black),
            ),
            centerTitle: true,
          ),
          body: const TabBarView(
            children: [
              ViewMerchandising(EnumMerchandising.poster, null),
              ViewMerchandising(EnumMerchandising.spanduk, null),
            ],
          ),
        ),
      ),
    );
  }
}
