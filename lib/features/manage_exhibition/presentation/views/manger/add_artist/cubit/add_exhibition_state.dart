part of 'add_exhibition_cubit.dart';

@immutable
sealed class AddExhibitionState {}

final class AddExhibitionInitial extends AddExhibitionState {}

final class AddExhibitionLoading extends AddExhibitionState {}

final class AddExhibitionFailure extends AddExhibitionState {
  final String errMessage;

  AddExhibitionFailure({required this.errMessage});
}

final class AddExhibitionSuccess extends AddExhibitionState {}
