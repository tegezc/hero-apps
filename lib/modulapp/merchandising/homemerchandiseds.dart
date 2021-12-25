import 'package:flutter/material.dart';
import 'package:hero/model/enumapp.dart';
import 'package:hero/modulapp/merchandising/viewmerchandisingitem.dart';
import 'package:hero/util/component/component_label.dart';
import 'package:hero/util/constapp/consstring.dart';

class HomeViewMerchandisingDs extends StatefulWidget {
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
            bottom: TabBar(
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
            iconTheme: IconThemeData(
              color: Colors.black, //change your color here
            ),
            title: Text(
              ConstString.textMerchandising,
              style: TextStyle(color: Colors.black),
            ),
            centerTitle: true,
          ),
          body: TabBarView(
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
