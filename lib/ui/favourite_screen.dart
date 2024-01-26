import 'package:bloc_flutter/bloc/favourite/favourite_bloc.dart';
import 'package:bloc_flutter/model/favourite_item_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({super.key});

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  @override
  void initState() {
    super.initState();

    context.read<FavouriteBloc>().add(FetchFavouriteList());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Favourites"),
        actions: [
          BlocBuilder<FavouriteBloc, FavouriteState>(
            builder: (context, state) {
              return Visibility(
                visible: state.tempFavouriteList.isNotEmpty ? true : false,
                child: IconButton(
                    onPressed: () {
                      context.read<FavouriteBloc>().add(DeleteItem());
                    },
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.red,
                    )),
              );
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocBuilder<FavouriteBloc, FavouriteState>(
          builder: (context, state) {
            switch (state.listStatus) {
              case ListStatus.loading:
                return const Center(
                  child: CircularProgressIndicator(),
                );
              case ListStatus.failure:
                return const Center(
                  child: CircularProgressIndicator(),
                );
              case ListStatus.success:
                return ListView.builder(
                  itemCount: state.favouriteList.length,
                  itemBuilder: (context, index) {
                    final item = state.favouriteList[index];

                    return Card(
                      child: ListTile(
                        leading: Checkbox(
                          value: state.tempFavouriteList.contains(item)
                              ? true
                              : false,
                          onChanged: (value) {
                            if (value!) {
                              context
                                  .read<FavouriteBloc>()
                                  .add(SelectItem(item: item));
                            } else {
                              context
                                  .read<FavouriteBloc>()
                                  .add(UnSelectItem(item: item));
                            }
                          },
                        ),
                        title: Text(item.value.toString()),
                        trailing: IconButton(
                            onPressed: () {
                              FavouriteItemModel itemModel = FavouriteItemModel(
                                  id: item.id,
                                  value: item.value,
                                  isFavourite: item.isFavourite ? false : true);

                              context
                                  .read<FavouriteBloc>()
                                  .add(FavouriteItem(item: itemModel));
                            },
                            icon: Icon(item.isFavourite
                                ? Icons.favorite
                                : Icons.favorite_outline)),
                      ),
                    );
                  },
                );

              default:
                return Container();
            }
          },
        ),
      ),
    );
  }
}
