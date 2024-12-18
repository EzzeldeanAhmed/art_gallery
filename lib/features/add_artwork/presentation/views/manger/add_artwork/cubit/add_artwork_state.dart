part of 'add_artwork_cubit.dart';

@immutable
sealed class AddArtworkState {}

final class AddArtworkInitial extends AddArtworkState {}

final class AddArtworkLoading extends AddArtworkState {}

final class AddArtworkFailure extends AddArtworkState {
  final String errMessage;

  AddArtworkFailure({required this.errMessage});
}

final class AddArtworkSuccess extends AddArtworkState {}
