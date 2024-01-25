
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallpaperapp/bloc/wallpaper_bloc.dart';
import 'package:wallpaperapp/screens/searched_wallpaper_screen.dart';
import 'package:wallpaperapp/screens/wallpaper_screen.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, dynamic>> listColor = [
    {'color': Colors.pinkAccent, 'colorCode': "FF4081"},
    {'color': Colors.blue, 'colorCode': "2196F3"},
    {'color': Colors.purple, 'colorCode': "9C27B0"},
    {'color': Colors.cyan, 'colorCode': "00BCD4"},
    {'color': Colors.black, 'colorCode': "000000"},
    {'color': Colors.orange, 'colorCode': "FF9800"},
    {'color': Colors.lightBlue, 'colorCode': "03A9F4"},
    {'color': Colors.lightGreen, 'colorCode': "8BC34A"},
  ];

  List<Map<String, String>> listTitles2 = [
    {
      'title': 'Abstract',
      'image':
          'https://images.unsplash.com/photo-1574169208507-84376144848b?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8M3x8YWJzdHJhY3R8ZW58MHx8MHx8fDA%3D&auto=format&fit=crop&w=500&q=60',
    },
    {
      'title': 'Nature',
      'image':
          'https://images.unsplash.com/photo-1469474968028-56623f02e42e?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8bmF0dXJlfGVufDB8fDB8fHww&auto=format&fit=crop&w=500&q=60',
    },
    {
      'title': 'Science',
      'image':
          'https://images.unsplash.com/photo-1451187580459-43490279c0fa?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTl8fHNjaWVuY2V8ZW58MHx8MHx8fDA%3D&auto=format&fit=crop&w=500&q=60',
    },
    {
      'title': 'Animals',
      'image':
          'https://images.unsplash.com/photo-1456926631375-92c8ce872def?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTF8fGFuaW1hbHN8ZW58MHx8MHx8fDA%3D&auto=format&fit=crop&w=500&q=60',
    },
    {
      'title': 'Cars',
      'image':
          'https://images.unsplash.com/photo-1492144534655-ae79c964c9d7?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8Y2Fyc3xlbnwwfHwwfHx8MA%3D%3D&auto=format&fit=crop&w=500&q=60',
    },
    {
      'title': 'Foods',
      'image':
          'https://images.unsplash.com/photo-1694505396696-b093cca3d8ea?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHx0b3BpYy1mZWVkfDd8eGpQUjRobGtCR0F8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=500&q=60',
    },
  ];

  TextEditingController searchController = TextEditingController();


  @override
  void initState() {
    super.initState();

    context.read<WallpaperBloc>().add(GetTrendingWallpaper());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(
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
                        boxShadow: const [
                          BoxShadow(
                            blurRadius: 5,
                            color: Colors.grey,
                          )
                        ]),
                    child: TextField(
                      controller: searchController,
                      decoration: InputDecoration(
                          hintText: ('Find Wallpaper...'),
                          suffixIcon: IconButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SearchedWallpaper(
                                            query: searchController.text)));
                              },
                              icon: const Icon(Icons.search)),
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
              const SizedBox(
                height: 35,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: SizedBox(
                  width: 350,
                  child: Text(
                    'Best of the month',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                  height: 200,
                  child: BlocBuilder<WallpaperBloc, WallpaperState>(
                    builder: (_, state) {
                      if (state is WallpaperLoadingState) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state is WallpaperErrorState) {
                        return Center(
                          child: Text(state.errorMsg),
                        );
                      } else if (state is WallpaperLoadedState) {
                        return SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                              children: state.mData.photos!
                                  .map((photosModel) => Padding(
                                        padding:
                                            const EdgeInsets.only(left: 25),
                                        child: InkWell(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      WallpaperScreen(
                                                          image: photosModel
                                                              .src!.portrait!),
                                                ));
                                          },
                                          child: Container(
                                            clipBehavior: Clip.antiAlias,
                                            height: 200,
                                            width: 150,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                            ),
                                            child: Image.network(
                                              "${photosModel.src!.portrait}",
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ))
                                  .toList()),
                        );
                      }

                      return Container();
                    },
                  )),
              const SizedBox(
                height: 35,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: SizedBox(
                  width: 350,
                  child: Text(
                    'The color tone',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 50,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: listColor.length,
                    itemBuilder: (_, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SearchedWallpaper(
                                  query: searchController.text.toString(),
                                  colorCode: listColor[index]['colorCode'],
                                ),
                              ));
                        },
                        child: Container(
                            margin: EdgeInsets.only(
                                left: index == 0 ? 20 : 11,
                                right: index == listColor.length - 1 ? 20 : 0),
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: listColor[index]['color'])),
                      );
                    }),
              ),
              const SizedBox(
                height: 40,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: SizedBox(
                  width: 350,
                  child: Text(
                    'Categories',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: SizedBox(
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
                                        builder: (context) => SearchedWallpaper(
                                              query: listTitles2[index]
                                                  ['title']!,
                                            )));
                              },
                              child: Container(
                                // margin: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(
                                          listTitles2[index]['image']!),
                                    )),
                                child: Center(
                                    child: Text(
                                  listTitles2[index]['title']!,
                                  style: const TextStyle(
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
}
