part of 'wallpaper_searched_bloc.dart';

@immutable
abstract class WallpaperSearchedEvent {}


class GetSearchedWallpaper extends WallpaperSearchedEvent{
  String query;
  GetSearchedWallpaper({required this.query});
}

