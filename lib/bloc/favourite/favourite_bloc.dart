import 'package:bloc/bloc.dart';
import 'package:bloc_flutter/model/favourite_item_model.dart';
import 'package:bloc_flutter/repository/favourite_repository.dart';
import 'package:equatable/equatable.dart';

part 'favourite_event.dart';
part 'favourite_state.dart';

class FavouriteBloc extends Bloc<FavouriteEvent, FavouriteState> {
  List<FavouriteItemModel> favouriteList = [];
  List<FavouriteItemModel> tempFavouriteList = [];
  FavouriteRepository favouriteRepository;

  FavouriteBloc(this.favouriteRepository) : super(const FavouriteState()) {
    on<FetchFavouriteList>(_fetchList);
    on<FavouriteItem>(_favouriteItem);
    on<SelectItem>(_selectItem);
    on<UnSelectItem>(_unSelectItem);
    on<DeleteItem>(_deleteItem);
  }

  void _fetchList(
      FetchFavouriteList event, Emitter<FavouriteState> emit) async {
    favouriteList = await favouriteRepository.fetchItems();
    emit(state.copyWith(
        favouriteList: List.from(favouriteList),
        listStatus: ListStatus.success));
  }

  void _favouriteItem(FavouriteItem event, Emitter<FavouriteState> emit) {
    final index =
        favouriteList.indexWhere((element) => element.id == event.item.id);

    if (event.item.isFavourite) {
      if (tempFavouriteList.contains(favouriteList[index])) {
        tempFavouriteList.remove(favouriteList[index]);
        tempFavouriteList.add(event.item);
      }
    } else {
      if (tempFavouriteList.contains(favouriteList[index])) {
        tempFavouriteList.remove(favouriteList[index]);
        tempFavouriteList.add(event.item);
      }
    }
    favouriteList[index] = event.item;
    emit(state.copyWith(
        favouriteList: List.from(favouriteList),
        tempFavouriteList: List.from(tempFavouriteList)));
  }

  void _selectItem(SelectItem event, Emitter<FavouriteState> emit) {
    tempFavouriteList.add(event.item);
    emit(state.copyWith(tempFavouriteList: List.from(tempFavouriteList)));
  }

  void _unSelectItem(UnSelectItem event, Emitter<FavouriteState> emit) {
    tempFavouriteList.remove(event.item);
    emit(state.copyWith(tempFavouriteList: List.from(tempFavouriteList)));
  }

  void _deleteItem(DeleteItem event, Emitter<FavouriteState> emit) {
    for (var i = 0; i < tempFavouriteList.length; i++) {
      favouriteList.remove(tempFavouriteList[i]);
    }
    tempFavouriteList.clear();
    emit(state.copyWith(
        favouriteList: List.from(favouriteList),
        tempFavouriteList: List.from(tempFavouriteList)));
  }
}
