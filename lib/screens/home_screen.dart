import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:wallpaperapp/Models/wallpaper_model.dart';
import 'package:wallpaperapp/screens/Categories_screen.dart';
import 'package:wallpaperapp/screens/wallpaper_screen.dart';
import 'package:http/http.dart'as http;

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  
  List<Color> listColor = [
    Colors.pinkAccent,
    Colors.blue,
    Colors.purple,
    Colors.cyan,
    Colors.black,
    Colors.orange,
    Colors.lightBlue,
    Colors.lightGreen,
  ];

  List<String> listImages2 = [
    'https://images.unsplash.com/photo-1574169208507-84376144848b?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8M3x8YWJzdHJhY3R8ZW58MHx8MHx8fDA%3D&auto=format&fit=crop&w=500&q=60',
    'https://images.unsplash.com/photo-1469474968028-56623f02e42e?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8bmF0dXJlfGVufDB8fDB8fHww&auto=format&fit=crop&w=500&q=60',
    'https://images.unsplash.com/photo-1451187580459-43490279c0fa?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTl8fHNjaWVuY2V8ZW58MHx8MHx8fDA%3D&auto=format&fit=crop&w=500&q=60',
    'https://images.unsplash.com/photo-1456926631375-92c8ce872def?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTF8fGFuaW1hbHN8ZW58MHx8MHx8fDA%3D&auto=format&fit=crop&w=500&q=60',
    'https://images.unsplash.com/photo-1492144534655-ae79c964c9d7?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8Y2Fyc3xlbnwwfHwwfHx8MA%3D%3D&auto=format&fit=crop&w=500&q=60',
    'https://images.unsplash.com/photo-1694505396696-b093cca3d8ea?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHx0b3BpYy1mZWVkfDd8eGpQUjRobGtCR0F8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=500&q=60',
  ];

  List<String> listTitles2 = [
    'Abstract',
    'Nature',
    'Science',
    'Animals',
    'Cars',
    'Foods'
  ];

  TextEditingController searchController = TextEditingController();
  var myKey = "fPEP48LlfqZj96ZoZswcg2yDm05Gm2Fj0tHgLvoAnO0DeNyhhSyvarJU";
  late Future<WallpaperModel> wallpaper;

  @override
  void initState() {
    super.initState();

    wallpaper=getWallpaper('abstract');

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(
                height: 40,
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    width: 350,
                    height: 55,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(21),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(blurRadius: 5, color: Colors.grey,)
                        ]),
                    child: TextField(
                      controller: searchController, 
                      decoration: InputDecoration(
                          hintText: ('Find Wallpaper...'),
                          suffixIcon: IconButton(onPressed: (){
                            wallpaper = getWallpaper(searchController.text.toString());
                            setState(() {

                            });
                          }, icon: Icon(Icons.search)),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(21),
                            borderSide: BorderSide.none,
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(21))),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 35,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  width: 350,
                  child: Text(
                    'Best of the month',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 200,
                child: FutureBuilder(future: wallpaper, builder: (context,snapshot){
                  if(snapshot.hasData){
                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(children: snapshot.data!.photos!.map((photosModel) => Padding(
                        padding: const EdgeInsets.only(left: 25),
                        child: InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => wallpaperScreen(image: photosModel.src!.portrait!),));
                          },
                          child: Container(
                            clipBehavior: Clip.antiAlias,
                            height: 200,
                            width: 150,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Image.network("${photosModel.src!.portrait}",fit: BoxFit.cover,),
                          ),
                        ),
                      )).toList()),
                    );
                  }
                  else if(snapshot.hasError){
                    Center(child: Text("${snapshot.hasError.toString()}"),);
                  }
                  return Center(child: CircularProgressIndicator(),);
                }),
              ),
              SizedBox(
                height: 35,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  width: 350,
                  child: Text(
                    'The color tone',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 50,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: listColor.length,
                    itemBuilder: (_, index) {
                      return Container(
                          margin: EdgeInsets.only(
                              left: index == 0 ? 20 : 11,
                              right: index == listColor.length - 1 ? 20 : 0),
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: listColor[index]));
                    }),
              ),
              SizedBox(
                height: 40,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  width: 350,
                  child: Text(
                    'Categories',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Container(
                  height: 241,
                  child: GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 16 / 9,
                    children: List.generate(
                        6,
                        (index) => GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => natureCategories(
                                            title: listTitles2[index],
                                            list: listImages2)));
                              },
                              child: Container(
                                // margin: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(listImages2[index]),
                                    )),
                                child: Center(
                                    child: Text(
                                  listTitles2[index],
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25,
                                      color: Colors.white),
                                )),
                              ),
                            )),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<WallpaperModel> getWallpaper(String search)async{
    var url = "https://api.pexels.com/v1/search?query=$search";
    var response = await http.get(Uri.parse(url),headers: {"Authorization": myKey});

    if(response.statusCode==200){
      var photos = jsonDecode(response.body);
      return WallpaperModel.fromJson(photos);
    }else{
      return WallpaperModel();
    }
  }
}
