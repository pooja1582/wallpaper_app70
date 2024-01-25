
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:wallpaperapp/screens/wallpaper_screen.dart';
import 'package:wallpaperapp/searched_bloc/wallpaper_searched_bloc.dart';

// ignore: must_be_immutable
class SearchedWallpaper extends StatefulWidget {
   SearchedWallpaper({super.key, required this.query, this.colorCode});
   String query;
   String? colorCode;

  @override
  State<SearchedWallpaper> createState() => _SearchedWallpaperState();
}

class _SearchedWallpaperState extends State<SearchedWallpaper> {


  @override
  void initState() {
    super.initState();

    context.read<WallpaperSearchedBloc>().add(GetSearchedWallpaper(query: widget.query));
      // wallpaper = getWallpaper(widget.query.isNotEmpty ? widget.query : 'nature');
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Text(widget.query,style:const TextStyle(fontWeight: FontWeight.bold,fontSize: 40),),
              const SizedBox(height: 30,),
              Expanded(
                child: BlocBuilder<WallpaperSearchedBloc,WallpaperSearchedState>(
                  builder: (_,state){
                    if(state is WallpaperLoadingState){
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }else if(state is WallpaperErrorState){
                      return Center(
                        child: Text(state.errorMsg,),
                      );
                    }else if(state is WallpaperLoadedState){
                      return  GridView.builder(gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 9/16, mainAxisSpacing: 10,crossAxisSpacing: 10),
                          itemCount: state.mData.photos!.length,
                          itemBuilder: (_,index){
                            return InkWell(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context) => WallpaperScreen(image: state.mData.photos![index].src!.portrait!),));
                              },
                              child: GridTile(
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.network(state.mData.photos![index].src!.portrait!, fit: BoxFit.fill,))),
                            );
                          });
                    }
                    return Container();
                  },
                )
              )
            ],
          ),
        ),
      ),
    );
  }
}
