import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class MyApp7 extends StatelessWidget {
  const MyApp7({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Carousel List",
      home: CarouselList(),
    );
  }
}
class CarouselList extends StatefulWidget {
  const CarouselList({Key? key}) : super(key: key);

  @override
  _CarouselListState createState() => _CarouselListState();
}

class _CarouselListState extends State<CarouselList> {
  late Future<List<ImageList>> lsImageList;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    lsImageList = ImageList.fetchData();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Carousel List"),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: lsImageList,
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot){
          if(snapshot.hasData){
            var data = snapshot.data as List<ImageList>;
            return CarouselSlider.builder(
                itemCount: data.length,
                itemBuilder: (context, index, realindex){
                  ImageList il = data[index];
                  var url = il.downloadUrl;
                  return buildImage(url);
                },
                options: CarouselOptions(
                    height: 400,
                  autoPlay: true,
                  autoPlayInterval: Duration(seconds: 2),
                ),
            );
          }
          else{
            return CircularProgressIndicator();
          }
        }
      ),
    );
  }
  Widget buildImage(String url){
    return Container(
     // margin: EdgeInsets.symmetric(horizontal: 12),
      color: Colors.grey,
      child: Image.network(
        url,
        fit: BoxFit.cover,
      ),
    );
  }
}
class ImageList{
  final String id;
  final String author;
  final int width;
  final int height;
  final String url;
  final String downloadUrl;

  ImageList({required this.id,required this.author,required this.width,required this.height,required this.url,required this.downloadUrl });

  static Future<List<ImageList>> fetchData() async{
    var client = http.Client();
    var response = await client.get(Uri.parse("https://picsum.photos/v2/list?page=2&limit=20"));

    if(response.statusCode == 200){
      var result = response.body;
      var jsonData = jsonDecode(result);

      List<ImageList> ls = [];
      for(var item in jsonData){
        ImageList il = new ImageList(
            id: item["id"],
            author: item["author"],
            width: item["width"],
            height: item["height"],
            url: item["url"],
            downloadUrl: item["download_url"]
        );
        ls.add(il);
      }
      return ls;
    }
    else{
      throw Exception("Lỗi lấy dữ liệu, Lỗi: ${response.statusCode}");
    }
  }
}

