
import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:wallpaper/wallpaper.dart';

// ignore: must_be_immutable
class WallpaperScreen extends StatefulWidget {
  String image;
  WallpaperScreen({super.key, required this.image});

  @override
  State<WallpaperScreen> createState() => _WallpaperScreenState();
}

class _WallpaperScreenState extends State<WallpaperScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover, image: NetworkImage(widget.image))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.6),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(
                        Icons.info,
                        size: 20,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    const Text(
                      'Info',
                      style: TextStyle(fontSize: 15, color: Colors.white),
                    )
                  ],
                ),
                const SizedBox(
                  width: 40,
                ),
                Column(
                  children: [
                    InkWell(
                      onTap: () {
                        downloadWallpaper(context);
                      },
                      child: Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.6),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(
                          Icons.download,
                          size: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    const Text(
                      'Save',
                      style: TextStyle(fontSize: 15, color: Colors.white),
                    )
                  ],
                ),
                const SizedBox(
                  width: 40,
                ),
                Column(
                  children: [
                    InkWell(
                      onTap: (){
                        showModalBottomSheet(context: context, builder: (context) => SizedBox(
                          height: 200,
                          width: double.infinity,
                          child: Column(
                            children: [
                              TextButton(onPressed: (){
                                setBothScreenWallpaper(context);
                              }, child: const Text("Both Screen")),
                              TextButton(onPressed: (){
                                setHomeScreenWallpaper(context);
                              }, child: const Text("Home Screen")),
                              TextButton(onPressed: (){
                                setLockScreenWallpaper(context);
                              }, child: const Text("Lock Screen")),
                            ],
                          ),
                        ),);
                      },
                      child: Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          color: Colors.blueAccent,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(
                          Icons.brush_rounded,
                          size: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    const Text(
                      'Apply',
                      style: TextStyle(fontSize: 15, color: Colors.white),
                    )
                  ],
                )
              ],
            ),
            const SizedBox(
              height: 70,
            )
          ],
        ),
      ),
    );
  }

  void downloadWallpaper(BuildContext context) {
    GallerySaver.saveImage(widget.image).then((value) => ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Wallpaper Downloaded'))));
  }

  void setHomeScreenWallpaper(BuildContext context){
    var downloadStream = Wallpaper.imageDownloadProgress(widget.image);

    downloadStream.listen((event) {
      print('Progress: $event');
    },onDone: ()async{
      var check = await Wallpaper.homeScreen(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        options: RequestSizeOptions.RESIZE_FIT,
      );
      print(check);

    },onError: (e){
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Could not set Wallpaper: $e')));
    }

    );
  }

  void setLockScreenWallpaper(BuildContext context){
    var downloadStream = Wallpaper.imageDownloadProgress(widget.image);

    downloadStream.listen((event) {
      print('Progress: $event');
    },onDone: ()async{

      var check =await Wallpaper.lockScreen(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        options: RequestSizeOptions.RESIZE_FIT,
      );
      print(check);
    },onError: (e){
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Could not set Wallpaper: $e')));
    }

    );
  }
  void setBothScreenWallpaper(BuildContext context){
    var downloadStream = Wallpaper.imageDownloadProgress(widget.image);

    downloadStream.listen((event) {
      print('Progress: $event');
    },onDone: ()async{

      var check =await Wallpaper.bothScreen(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        options: RequestSizeOptions.RESIZE_FIT,
      );
      print(check);
    },onError: (e){
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Could not set Wallpaper: $e')));
    }

    );
  }
}
