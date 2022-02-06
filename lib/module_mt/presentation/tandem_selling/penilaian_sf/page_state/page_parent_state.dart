part of 'page_parent_cubit.dart';

@immutable
abstract class PageParentPenilaianSFState {}

class PageParentPenilaianSFInitial extends PageParentPenilaianSFState {}

class PageParentPenilaianSfLoading extends PageParentPenilaianSFState {}

class PageParentPenilaianSfLoaded extends PageParentPenilaianSFState {
  final PenilaianSf penilaianSf;
  PageParentPenilaianSfLoaded(this.penilaianSf);
}

class PageParentPenilaianSfError extends PageParentPenilaianSFState {
  final String message;
  PageParentPenilaianSfError(this.message);
}
