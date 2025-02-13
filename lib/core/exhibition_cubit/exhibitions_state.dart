part of 'exhibitions_cubit.dart';

@immutable
sealed class ExhibitionsState {}

final class ExhibitionsInitial extends ExhibitionsState {}

final class ExhibitionsLoading extends ExhibitionsState {}

final class ExhibitionsFailure extends ExhibitionsState {
  final String errMessage;

  ExhibitionsFailure(this.errMessage);
}

final class ExhibitionsSuccess extends ExhibitionsState {
  final List<ExhibitionEntity> exhibitions;
  ExhibitionsSuccess(this.exhibitions);
}
