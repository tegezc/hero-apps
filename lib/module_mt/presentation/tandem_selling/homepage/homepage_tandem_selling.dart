import 'package:flutter/material.dart';
import 'package:hero/module_mt/presentation/common/homepage_search/cell_outlet.dart';
import 'package:hero/module_mt/presentation/common/widgets/cell_widget.dart';
import 'package:hero/module_mt/presentation/common/widgets/comboboxhore.dart';
import 'package:hero/module_mt/presentation/tandem_selling/detail_outlet/detail_outlet.dart';
import 'package:hero/util/component/button/component_button.dart';
import 'package:hero/util/component/label/component_label.dart';
import 'package:hero/util/component/widget/component_widget.dart';
import 'package:hero/util/component/widget/horeboxdecoration.dart';
import 'package:hero/util/component/widget/widgetpencariankosong.dart';
import 'package:hero/util/uiutil.dart';

class HomePageTandemSelling extends StatefulWidget {
  const HomePageTandemSelling({Key? key}) : super(key: key);

  @override
  _HomePageTandemSellingState createState() => _HomePageTandemSellingState();
}

class _HomePageTandemSellingState extends State<HomePageTandemSelling> {
  final TextEditingController textEditingController = TextEditingController();

  final HoreBoxDecoration _boxDecoration = HoreBoxDecoration();
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String title = 'Tandem Selling';
    Size s = MediaQuery.of(context).size;
    double heightContentSearch = s.height - 280;
    return ScaffoldMT(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: searchFilter(),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                child: ButtonStrectWidth(
                    buttonColor: Colors.green,
                    text: 'Penilain SF',
                    onTap: () {},
                    isenable: true),
              ),
              Container(
                  height: heightContentSearch,
                  margin: const EdgeInsets.all(8.0),
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                      //color: Colors.red[600],
                      borderRadius: BorderRadius.circular(10.0),
                      gradient: getGradientBackground()),
                  child: controllContentPencarian(heightContentSearch)),
            ],
          ),
        ),
        title: title);
  }

  Gradient getGradientBackground() {
    return _boxDecoration.gradientBackgroundApp();
  }

  Widget headerPencarian() {
    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          LabelWhite.size1("Berikut Daftar Pencarian : "),
          Divider(
            color: Colors.white,
          ),
        ],
      ),
    );
  }

  Widget controllContentPencarian(double height) {
    var items = ['a', 'b', 'c', 'd', 'e'];
    if (items.isEmpty) {
      if (textEditingController.text.isNotEmpty) {
        return const WidgetPencarianKosong(
            text: 'Pencarian dengan kriteria tersebut \nTIDAK DITEMUKAN.');
      } else {
        return const WidgetPencarianKosong(
            text:
                'Silahkan masukkan kriteria pencarian \nuntuk mendapatkan hasil pencarian');
      }
    } else {
      return Column(
        children: [
          headerPencarian(),
          SizedBox(height: height - 100, child: content(items)),
        ],
      );
    }
  }

  Widget content(List<String> items) {
    return ListView.builder(
      padding: const EdgeInsets.only(top: 20),
      // shrinkWrap: true,
      itemCount: items.length,
      itemBuilder: (context, index) {
        return CellOutlet(onTap: () {
          CommonUi().openPage(context, DetailOutlet());
        });
      },
    );
  }

  Widget combo({required String label, required Function(String) onChange}) {
    List<String> lcombo = ['satu', 'dua', 'tiga', 'empat', 'lima'];
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
      child: DynamicTwoColumn(
        widget: HoreComboBox(
          lcombo: lcombo,
          currentValue: 'satu',
          hint: 'Pilih',
          onChange: onChange,
        ),
        widthFirsComponent: 70,
        label: label,
      ),
    );
  }

  Widget searchFilter() {
    double w = MediaQuery.of(context).size.width;
    return Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            combo(label: 'Cluster', onChange: (value) {}),
            combo(label: 'TAP', onChange: (value) {}),
            Padding(
              padding:
                  const EdgeInsets.only(left: 4.0, bottom: 8, right: 4, top: 8),
              child: Row(
                children: [
                  SizedBox(
                    width: w - 80,
                    child: TextField(
                      keyboardType: TextInputType.text,
                      controller: textEditingController,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                      ),
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(8.0)),
                          ),
                          // suffixIcon:
                          //     Icon(Icons.search, color: Colors.black),
                          hintText: 'ID SF',
                          hintStyle: TextStyle(color: Colors.grey)),
                      onChanged: (v) {},
                    ),
                  ),
                  IconButton(
                      icon: const Icon(Icons.search, size: 30),
                      onPressed: () {
                        FocusScope.of(context).unfocus();
                      })
                ],
              ),
            ),
          ],
        ));
  }
}
