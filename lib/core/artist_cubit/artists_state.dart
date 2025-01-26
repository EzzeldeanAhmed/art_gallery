part of 'artists_cubit.dart';

@immutable
sealed class ArtistsState {}

final class ArtistsInitial extends ArtistsState {}

final class ArtistsLoading extends ArtistsState {}

final class ArtistsFailure extends ArtistsState {
  final String errMessage;

  ArtistsFailure(this.errMessage);
}

final class ArtistsSuccess extends ArtistsState {
  final List<ArtistEntity> artists;
  ArtistsSuccess(this.artists);
}
