import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:hero/core/log/printlog.dart';
import 'package:hero/module_mt/data/datasources/common/combobox_datasource.dart';
import 'package:hero/module_mt/data/datasources/common/outlet_mt_datasource.dart';
import 'package:hero/module_mt/data/repositories/common/combo_box_repository.dart';
import 'package:hero/module_mt/data/repositories/common/outletmt_repository.dart';
import 'package:hero/module_mt/domain/entity/common/cluster.dart';
import 'package:hero/module_mt/domain/entity/common/sales.dart';
import 'package:hero/module_mt/domain/entity/common/tap.dart';
import 'package:hero/module_mt/domain/entity/tandem_selling/pencarian_tandem_selling.dart';
import 'package:hero/module_mt/domain/usecase/tandem_selling/prepare_tandem_selling_use_case.dart';
import 'package:hero/module_mt/domain/usecase/tandem_selling/search_tandem_use_case.dart';
import 'package:meta/meta.dart';

part 'hp_tandem_selling_state.dart';

class HpTandemSellingCubit extends Cubit<HpTandemSellingState> {
  HpTandemSellingCubit() : super(HpTandemSellingInitial());

  late PrepareTandemSellingUseCase ptandem;
  late SearchTandemUseCase sTandem;

  List<Cluster> lCluster = [];
  Cluster? currentCluster;

  List<Tap> lTap = [];
  Tap? currentTap;

  List<Sales> lSales = [];
  Sales? currentSales;

  late PencarianTandemSelling pcts;
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

    // combobox mininal 1 component
    // dan menjadi default value
    Sales defaultSales = const Sales(idSales: 'Pilih', namaSales: '0');

    Tap defTap = const Tap(idTap: '0', namaTap: 'Pilih');
    lSales.add(defaultSales);
    lTap.add(defTap);

    _setupData().then((value) {});
  }

  Future<void> _setupData() async {
    emit(HpTandemSellingLoading());
    List<Cluster>? lc = await ptandem.getListCluster();
    if (lc != null) {
      _addToComboboxCluster(lc);
      pcts = PencarianTandemSelling([], false);
      emit(_createStateTandemLoaded(false));
    } else {
      emit(HpTandemSellingError(
          message: 'Kesulitan mendapatkan data dari server.'));
    }
  }

  HpTandemSellingLoaded _createStateTandemLoaded(bool isFromSearchButton) {
    return HpTandemSellingLoaded(
        lCluster: lCluster,
        lTap: lTap,
        lSales: lSales,
        currentCluster: currentCluster,
        currentSales: currentSales,
        currentTap: currentTap,
        pcts: pcts,
        isFromSearchButton: isFromSearchButton);
  }

  void _addToComboboxCluster(List<Cluster> lObject) {
    lCluster.addAll(lObject);
  }

  void changeCombobox(dynamic selected) {
    ph(selected);
    if (selected is Cluster) {
      if (currentCluster != selected) {
        currentCluster = selected;
        currentTap = lTap[0];
        currentSales = lSales[0];
        _clearListSales();
        _clearListTap();
        _getComboboxTap();
      }
    } else if (selected is Tap) {
      if (selected != currentTap) {
        currentTap = selected;
        currentSales = lSales[0];
        _clearListSales();
        _getComboboxSales();
      }
    } else if (selected is Sales) {
      currentSales = selected;
      emit(_createStateTandemLoaded(false));
    }

    pcts = PencarianTandemSelling([], false);
    emit(_createStateTandemLoaded(false));
  }

  void _addToComboboxTap(List<Tap> lObject) {
    _clearListTap();
    lTap.addAll(lObject);
  }

  void _addToComboboxSales(List<Sales> lObject) {
    _clearListSales();
    lSales.addAll(lObject);
  }

  void _clearListSales() {
    lSales.removeWhere((element) => element.namaSales != '0');
  }

  void _clearListTap() {
    lTap.removeWhere((element) => element.idTap != '0');
  }

  void _getComboboxTap() {
    String idCluster = currentCluster!.idCluster;
    ptandem.getListTap(idCluster).then((value) {
      if (value != null) {
        _addToComboboxTap(value);
        emit(_createStateTandemLoaded(false));
      }
    });
  }

  void _getComboboxSales() {
    String idTap = currentTap!.idTap;
    ptandem.getListSales(idTap).then((value) {
      if (value != null) {
        _addToComboboxSales(value);
        emit(_createStateTandemLoaded(false));
      }
    });
  }

  void searchOutletMt() {
    if (currentSales != null) {
      if (currentSales!.idSales.length > 1) {
        String idSales = currentSales!.idSales;
        sTandem.getListOutletMTTandemSelling(idSales).then((value) {
          if (value == null) {
            pcts = PencarianTandemSelling([], false);
            emit(_createStateTandemLoaded(false));
          } else {
            pcts = value;
            if (pcts.isPenilaianSfSubmitted) {
              emit(_createStateTandemLoaded(true));
            } else {
              emit(_createStateTandemLoaded(false));
            }
          }
        });
      }
    }
  }
}
