

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:wallpaperapp/Models/wallpaper_model.dart';
import 'package:wallpaperapp/data/remote/api_helper.dart';
import 'package:wallpaperapp/data/remote/app_exception.dart';
import 'package:wallpaperapp/data/remote/urls.dart';

part 'wallpaper_event.dart';
part 'wallpaper_state.dart';

class WallpaperBloc extends Bloc<WallpaperEvent, WallpaperState> {
  ApiHelper apiHelper;
  WallpaperBloc({required this.apiHelper}) : super(WallpaperInitialState()){
    on<GetTrendingWallpaper>((event, emit) async{
      emit(WallpaperLoadingState());

      try{
        var responseJson = await apiHelper.getAPI(url: Urls.TRENDING_WALL_URL);
        var data = WallpaperModel.fromJson(responseJson);
        emit(WallpaperLoadedState(mData: data));
      }catch(e){
        emit(WallpaperErrorState(errorMsg: (e as AppException).toErrorMsg()));
      }
    });


  }
}
