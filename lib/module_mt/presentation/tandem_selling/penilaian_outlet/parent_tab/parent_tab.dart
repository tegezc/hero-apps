import 'package:flutter/material.dart';
import 'package:hero/module_mt/domain/entity/outlet_mt.dart';
import 'package:hero/module_mt/presentation/tandem_selling/penilaian_outlet/advokasi/page_advokasi.dart';
import 'package:hero/module_mt/presentation/tandem_selling/penilaian_outlet/availability/page_availability.dart';
import 'package:hero/module_mt/presentation/tandem_selling/penilaian_outlet/visibility/page_visibility.dart';
import 'package:hero/util/component/button/component_button.dart';
import 'package:hero/util/component/label/component_label.dart';

class ParentTabNilaiOutlet extends StatefulWidget {
  static const routeName = '/nilaioutlet';
  final OutletMT outletMT;
  const ParentTabNilaiOutlet({required this.outletMT, Key? key})
      : super(key: key);

  @override
  _ParentTabNilaiOutletState createState() => _ParentTabNilaiOutletState();
}

class _ParentTabNilaiOutletState extends State<ParentTabNilaiOutlet> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            actions: [
              Padding(
                padding: const EdgeInsets.only(top: 12.0, bottom: 12.0),
                child: ButtonApp.black(
                  'Selesai',
                  () {},
                  bgColor: Colors.white,
                ),
              ),
            ],
            bottom: const TabBar(
              indicatorColor: Colors.white,
              isScrollable: true,
              tabs: [
                // wallet share, sales broadband share, voucher fisik share
                Tab(
                  child: LabelWhite.size2('Availability'),
                ),
                Tab(
                  child: LabelWhite.size2('Visibility'),
                ),
                Tab(
                  child: LabelWhite.size2('Advokasi'),
                ),
              ],
            ),
            backgroundColor: Colors.red[600],
            iconTheme: const IconThemeData(
              color: Colors.white, //change your color here
            ),
            title: const Text(
              'Penilaian Outlet',
              style: TextStyle(color: Colors.white),
            ),
            centerTitle: true,
          ),
          body: const TabBarView(
            children: [
              PageAvailability(),
              PageVisibility(),
              PageAdvokasi(),
            ],
          ),
        ),
      ),
    );
  }
}
