import 'package:flutter/material.dart';
import 'package:mod3_kel07/screens/detail.dart';
import 'package:mod3_kel07/screens/detail_horizontal.dart';
import 'package:mod3_kel07/screens/profile.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<Show>> shows;
  
  int _selectedIndex = 0;
  static const TextStyle optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Home',
      style: optionStyle,
    ),
    Text(
      'Index 1: Person',
      style: optionStyle,
    ),
  ];

  

  @override
  void initState() {
    super.initState();
    shows = fetchShows();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('MyAnimeList')),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const Text(
            'Top Airing',
            style: TextStyle(fontSize: 18),
          ),
          Expanded(
            child: FutureBuilder(
              builder: (context, AsyncSnapshot<List<Show>> snapshot) {
                if (snapshot.hasData) {
                  return Center(
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          padding: EdgeInsets.all(1),
                          margin: EdgeInsets.all(1),
                          child: GestureDetector(
                            onTap:(){
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DetailHorizontalPage(
                                    item: snapshot.data![index].malId,
                                    title: snapshot.data![index].title),
                                ),
                              );
                            },
                            child: Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(2),
                                  margin: EdgeInsets.all(4),
                                  height: 230,
                                  width: 140,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        padding: EdgeInsets.all(2),
                                        width: 60,
                                        color: Colors.black45,
                                        child: Row(
                                        children: [
                                          Icon(
                                            Icons.star,
                                            color: Colors.yellow[600]
                                          ),
                                          Text('${snapshot.data![index].score}',
                                            style: TextStyle(color: Colors.yellow[600]),
                                          )
                                        ],
                                        ),
                                      )
                                      ]
                                  ),
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      fit: BoxFit.fill,
                                      image: NetworkImage(snapshot.data![index].imageUrl)
                                    )
                                  ),
                                ),
                                Container(
                                  width: 140,
                                  child: Center(
                                    child: Card(
                                  
                                  child: Text(snapshot.data![index].title,
                                  style: TextStyle(fontSize: 13),
                                  overflow: TextOverflow.ellipsis,
                                  ),
                                ),),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  );
                } else if (snapshot.hasError) {
                  return const Center(child: Text('Something went wrong :('));
                }
                return const CircularProgressIndicator();
              },
              future: shows,
            ),
          ),
          const Text(
            'Top Anime of All Time',
            style: TextStyle(
              fontSize: 18
            ),
          ),
          Expanded(
            child: FutureBuilder(
              builder: (context, AsyncSnapshot<List<Show>> snapshot) {
                if (snapshot.hasData) {
                  return Center(
                    child: ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Card(
                          color: Colors.white,
                          child: ListTile(
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 10.0
                            ),
                            leading: CircleAvatar(
                              radius: 30,
                              backgroundImage:
                              NetworkImage(snapshot.data![index].imageUrl),
                            ),
                            title: Text(snapshot.data![index].title),
                            subtitle: Text('Score: ${snapshot.data![index].score}'),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DetailPage(
                                    item: snapshot.data![index].malId,
                                    title: snapshot.data![index].title
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
                  );
                } else if (snapshot.hasError) {
                  return const Center(child: Text('Something went wrong :('));
                }
                return const CircularProgressIndicator();
              },
              future: shows,
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: Colors.blue,
      onTap: (int index) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProfilePage(),
          ),
        );
      },
    ),
    );
  }
} 

class Show {
  final int malId;
  final String title;
  final String imageUrl;
  final double score;
  
  Show({
    required this.malId,
    required this.title,
    required this.imageUrl,
    required this.score,
  });
  
  factory Show.fromJson(Map<String, dynamic> json) {
    return Show(
      malId: json['mal_id'],
      title: json['title'],
      imageUrl: json['image_url'],
      score: json['score'],
    );
  }
} 

Future<List<Show>> fetchShows() async {
  final response = await http.get(Uri.parse('https://api.jikan.moe/v3/top/anime/1'));
  
  if (response.statusCode == 200) {
    var topShowsJson = jsonDecode(response.body)['top'] as List;
    return topShowsJson.map((show) => Show.fromJson(show)).toList();
  } else {
    throw Exception('Failed to load shows');
  }
}
