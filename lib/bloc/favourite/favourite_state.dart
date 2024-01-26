part of 'favourite_bloc.dart';

enum ListStatus { loading, success, failure }

class FavouriteState extends Equatable {
  final List<FavouriteItemModel> favouriteList;
  final List<FavouriteItemModel> tempFavouriteList;
  final ListStatus listStatus;

  const FavouriteState({
    this.favouriteList = const [],
    this.tempFavouriteList = const [],
    this.listStatus = ListStatus.loading,
  });

  FavouriteState copyWith(
      {List<FavouriteItemModel>? favouriteList,
      List<FavouriteItemModel>? tempFavouriteList,
      ListStatus? listStatus}) {
    return FavouriteState(
        favouriteList: favouriteList ?? this.favouriteList,
        tempFavouriteList: tempFavouriteList ?? this.tempFavouriteList,
        listStatus: listStatus ?? this.listStatus);
  }

  @override
  List<Object?> get props => [favouriteList, listStatus, tempFavouriteList];
}
