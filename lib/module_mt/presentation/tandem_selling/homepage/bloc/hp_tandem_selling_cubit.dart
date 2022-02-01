import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:hero/config/configuration_sf.dart';
import 'package:hero/module_mt/data/datasources/common/combobox_datasource.dart';
import 'package:hero/module_mt/data/datasources/common/outlet_mt_datasource.dart';
import 'package:hero/module_mt/data/repositories/common/combo_box_repository.dart';
import 'package:hero/module_mt/data/repositories/common/outletmt_repository.dart';
import 'package:hero/module_mt/domain/entity/common/cluster.dart';
import 'package:hero/module_mt/domain/entity/common/sales.dart';
import 'package:hero/module_mt/domain/entity/common/tap.dart';
import 'package:hero/module_mt/domain/entity/outlet_mt.dart';
import 'package:hero/module_mt/domain/usecase/tandem_selling/prepare_tandem_selling_use_case.dart';
import 'package:hero/module_mt/domain/usecase/tandem_selling/search_tandem_use_case.dart';
import 'package:meta/meta.dart';

part 'hp_tandem_selling_state.dart';

class HpTandemSellingCubit extends Cubit<HpTandemSellingState> {
  HpTandemSellingCubit() : super(HpTandemSellingInitial());

  late PrepareTandemSellingUseCase ptandem;
  late SearchTandemUseCase sTandem;

  List<Cluster>? lCluster;
  Cluster? currentCluster;

  List<Tap>? lTap;
  Tap? currentTap;

  List<Sales>? lSales;
  Sales? currentSales;

  List<OutletMT>? lOutlet;
  void setupData() {
    OutletMTDatasourceImpl outletMTDatasource = OutletMTDatasourceImpl();
    OutletMTRepository outletMTRepository =
        OutletMTRepository(outletMTDatasource: outletMTDatasource);
    sTandem = SearchTandemUseCase(outletMTRepository: outletMTRepository);

    ComboboxDatasourceImpl comboboxDatasource = ComboboxDatasourceImpl();
    ComboBoxRepositoryImp comboboxRepository =
        ComboBoxRepositoryImp(comboboxDatasource: comboboxDatasource);
    ptandem =
        PrepareTandemSellingUseCase(comboboxRepository: comboboxRepository);
    _setupData().then((value) {});
  }

  Future<void> _setupData() async {
    emit(HpTandemSellingLoading());
    lCluster = await ptandem.getListCluster();
    if (lCluster != null) {
      emit(
          HpTandemSellingLoaded(lCluster: lCluster!, lTap: null, lSales: null));
    } else {
      emit(HpTandemSellingError(
          message: 'Kesulitan mendapatkan data dari server.'));
    }
  }

  void changeCombobox(dynamic selected) {
    ph(selected);
    if (selected is Cluster) {
      if (currentCluster != selected) {
        currentCluster = selected;
        currentTap = null;
        currentSales = null;
        lTap = null;
        lSales = null;
        _getComboboxTap();
      }
    } else if (selected is Tap) {
      if (selected != currentTap) {
        currentTap = selected;
        currentSales = null;
        lSales = null;
        _getComboboxSales();
      }
    } else if (selected is Sales) {
      currentSales = selected;
    }
  }

  void _getComboboxTap() {
    String idCluster = currentCluster!.idCluster;
    ptandem.getListTap(idCluster).then((value) {
      lTap = value;
      emit(HpTandemSellingLoaded(lCluster: lCluster!, lTap: value));
    });
  }

  void _getComboboxSales() {
    String idTap = currentTap!.idTap;
    ptandem.getListSales(idTap).then((value) {
      lSales = value;
      emit(HpTandemSellingLoaded(
          lCluster: lCluster!, lTap: lTap, lSales: lSales));
    });
  }

  void searchOutletMt() {
    String idSales = currentSales!.idSales;
    sTandem.getListOutletMTTandemSelling(idSales).then((value) {
      lOutlet = value;
      emit(HpTandemSellingLoaded(
          lCluster: lCluster!, lTap: lTap, lSales: lSales, lOutlet: lOutlet));
    });
  }
}
