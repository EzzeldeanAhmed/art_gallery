part of 'add_artist_cubit.dart';

@immutable
sealed class AddArtistState {}

final class AddArtistInitial extends AddArtistState {}

final class AddArtistLoading extends AddArtistState {}

final class AddArtistFailure extends AddArtistState {
  final String errMessage;

  AddArtistFailure({required this.errMessage});
}

final class AddArtistSuccess extends AddArtistState {}
