part of 'hp_tandem_selling_cubit.dart';

@immutable
abstract class HpTandemSellingState {}

class HpTandemSellingInitial extends HpTandemSellingState {}

class HpTandemSellingLoading extends HpTandemSellingState {}

class HpTandemSellingLoaded extends HpTandemSellingState {
  final List<Cluster> lCluster;
  final List<Tap> lTap;
  final List<Sales> lSales;
  final Cluster? currentCluster;
  final Tap? currentTap;
  final Sales? currentSales;
  final PencarianTandemSelling? pcts;
  final bool isFromSearchButton;
  HpTandemSellingLoaded(
      {required this.lCluster,
      required this.lTap,
      required this.lSales,
      this.currentCluster,
      this.currentTap,
      this.currentSales,
      this.pcts,
      required this.isFromSearchButton});
}

class HpTandemSellingError extends HpTandemSellingState {
  final String message;
  HpTandemSellingError({required this.message});
}

class HpTandemSellingSfAlready extends HpTandemSellingState {}
