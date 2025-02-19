part of 'add_collection_cubit.dart';

@immutable
sealed class AddCollectionState {}

final class AddCollectionInitial extends AddCollectionState {}

final class AddCollectionLoading extends AddCollectionState {}

final class AddCollectionFailure extends AddCollectionState {
  final String errMessage;

  AddCollectionFailure({required this.errMessage});
}

final class AddCollectionSuccess extends AddCollectionState {}
