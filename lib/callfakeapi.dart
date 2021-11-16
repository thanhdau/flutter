import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class MyApp4 extends StatelessWidget {
  const MyApp4({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomepageApp4(),
    );
  }
}

class HomepageApp4 extends StatefulWidget {
  const HomepageApp4({Key? key}) : super(key: key);

  @override
  _HomepageApp4State createState() => _HomepageApp4State();
}

class _HomepageApp4State extends State<HomepageApp4> {
  late Future<List<Photo>> lsPhoto;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    lsPhoto = Photo.fetchData();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: lsPhoto,
        builder: (BuildContext context,AsyncSnapshot<dynamic> snapshot ){
          if(snapshot.hasData){
            var data = snapshot.data as List<Photo>;
            return ListView.builder(
              itemCount: data.length,
                itemBuilder: (BuildContext context, int index){
                    Photo p = data[index];
                    return Card(
                      child: Column(
                        children: [
                          Image.network(p.thumbnailUrl),
                          Text(p.title)
                        ],
                      ),
                    );
                });
          }
          else{
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
class Photo{
  final int albumId;
  final int id;
  final String title;
  final String url;
  final String thumbnailUrl;

  Photo({required this.id,required this.title,required this.url,required this.thumbnailUrl,required this.albumId});
  static Future<List<Photo>> fetchData() async{
    String url = "https://jsonplaceholder.typicode.com/photos";
    var client = http.Client();
    var response = await client.get(Uri.parse(url));
    if(response.statusCode == 200){
      var result = response.body;
      var jsonData = jsonDecode(result);//.cast<List<Map<String, dynamic>>>();
      List<Photo> ls = [];

      for(var item in jsonData){
        print(item.runtimeType);
        Photo p = new Photo(
          albumId: item['albumId'],
          id: item['id'],
          title: item['url'],
          url: item['url'],
          thumbnailUrl: item['thumbnailUrl']
        );
        ls.add(p);
      }
      return ls;
    }
    else{
      throw Exception("Lỗi lấy dữ liệu, Lỗi: ${response.statusCode}");
    }
  }
}

