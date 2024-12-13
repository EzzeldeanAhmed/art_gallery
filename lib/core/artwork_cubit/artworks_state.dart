part of 'artworks_cubit.dart';

@immutable
sealed class ArtworksState {}

final class ArtworksInitial extends ArtworksState {}

final class ArtworksLoading extends ArtworksState {}

final class ArtworksFailure extends ArtworksState {
  final String errMessage;

  ArtworksFailure(this.errMessage);
}

final class ArtworksSuccess extends ArtworksState {
  final List<ArtworkEntity> artworks;
  ArtworksSuccess(this.artworks);
}
