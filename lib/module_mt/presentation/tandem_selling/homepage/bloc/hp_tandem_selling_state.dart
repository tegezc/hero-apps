part of 'hp_tandem_selling_cubit.dart';

@immutable
abstract class HpTandemSellingState {}

class HpTandemSellingInitial extends HpTandemSellingState {}

class HpTandemSellingLoading extends HpTandemSellingState {}

class HpTandemSellingLoaded extends HpTandemSellingState {}

class HpTandemSellingError extends HpTandemSellingState {}
