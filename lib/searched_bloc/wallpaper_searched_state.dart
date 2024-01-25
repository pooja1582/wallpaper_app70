part of 'wallpaper_searched_bloc.dart';

@immutable
abstract class WallpaperSearchedState {}

class WallpaperSearchedInitial extends WallpaperSearchedState {}

class WallpaperLoadingState extends WallpaperSearchedState {}
class WallpaperLoadedState extends WallpaperSearchedState {
  WallpaperModel mData;
  WallpaperLoadedState({required this.mData});
}
class WallpaperErrorState extends WallpaperSearchedState {
  String errorMsg;
  WallpaperErrorState({required this.errorMsg});
}

