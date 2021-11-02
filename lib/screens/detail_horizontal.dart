import 'package:flutter/material.dart'; 
import 'package:http/http.dart' as http; 
import 'dart:convert'; 

class DetailHorizontalPage extends StatefulWidget {
  final int item;
  final String title;
  const DetailHorizontalPage({Key? key, required this.item, required this.title}) : super(key: key);
  
  @override
  _DetailHorizontalPageState createState() => _DetailHorizontalPageState(); 
} 

class _DetailHorizontalPageState extends State<DetailHorizontalPage> {
  late Future<Info> info;
  
  @override
  void initState() {
    super.initState();
    info = fetchInfo(widget.item);
  } 
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Container(
        child: FutureBuilder<Info>(
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    height: 230,
                    width: 140,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: NetworkImage(snapshot.data!.imageUrl)
                      )
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(8),
                    width: 570,
                    child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 6, left: 18),
                        child: Text(snapshot.data!.title, style: TextStyle(fontWeight: FontWeight.w900),),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 6,left: 18),
                        child: Text(
                          'Score: ${snapshot.data!.score}',
                          style: TextStyle(
                            color: Colors.black38),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 6,left: 18),
                        child: Text(
                          'Broadcast: '+snapshot.data!.broadcast,
                          style: TextStyle(
                            color: Colors.black38),
                        ),
                      ),
                    ],
                  ),
                  )
                  ,
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: Text(
                      snapshot.data!.synopsis,
                      textAlign: TextAlign.justify,
                    ),
                  ),
                  
                ]
              );
            } else if (snapshot.hasError) {
              return const Center(child: Text('Something went wrong :('));
            }
            return const CircularProgressIndicator();
          },
          future: info,
        )
      ),
    );
  }
}

class Info {
  final int malId;
  final String imageUrl;
  final String title;
  final double score;
  final String broadcast;
  final String synopsis;
  Info(
    {
    required this.malId,
    required this.imageUrl,
    required this.title,
    required this.score,
    required this.synopsis,
    required this.broadcast
    });
  factory Info.fromJson(Map<String, dynamic> json) {
    return Info(
      malId: json['mal_id'],
      imageUrl: json['image_url'],
      title: json['title'],
      score: json['score'],
      synopsis: json['synopsis'],
      broadcast: json['broadcast']
      );
  } 
} 

Future<Info> fetchInfo(id) async {
  final response = await http.get(Uri.parse('https://api.jikan.moe/v3/anime/$id'));
  if (response.statusCode == 200) {
    return Info.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load info');
  }
}