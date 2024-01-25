import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:wallpaperapp/Models/wallpaper_model.dart';
import 'package:wallpaperapp/data/remote/api_helper.dart';
import 'package:wallpaperapp/data/remote/app_exception.dart';
import 'package:wallpaperapp/data/remote/urls.dart';

part 'wallpaper_searched_event.dart';
part 'wallpaper_searched_state.dart';

class WallpaperSearchedBloc extends Bloc<WallpaperSearchedEvent, WallpaperSearchedState> {
  ApiHelper apiHelper;
  WallpaperSearchedBloc({required this.apiHelper}) : super(WallpaperSearchedInitial()) {
    on<WallpaperSearchedEvent>((event, emit) {


      on<GetSearchedWallpaper>((event, emit) async{
        emit(WallpaperLoadingState());

        try{
          var responseJson = await apiHelper.getAPI(url: "${Urls.SEARCH_WALL_URL}?query=${event.query}");
          var data = WallpaperModel.fromJson(responseJson);
          emit(WallpaperLoadedState(mData: data));
        }catch(e){
          emit(WallpaperErrorState(errorMsg: (e as AppException).toErrorMsg()));
        }
      });
    });
  }
}
