import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
class MyApp6 extends StatelessWidget {
  const MyApp6({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "ListGrid",
      home: ListGrid()
    );
  }
}
class ListGrid extends StatefulWidget {
  const ListGrid({Key? key}) : super(key: key);

  @override
  _ListGridState createState() => _ListGridState();
}

class _ListGridState extends State<ListGrid> {
  late Future<List<Album>> lsAlbum;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    try {
      lsAlbum = Album.fetchData();
    }catch(E){
      print(E.toString());
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Grid list"),
      ),
      body: FutureBuilder(
        future: lsAlbum,
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot){
          if(snapshot.hasData){
            var data = snapshot.data as List<Album>;
            return GridView.builder(
              itemCount: data.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemBuilder: (BuildContext context, int index){
                Album a = data[index];
                return Card(
                  child: GridTile(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.network(a.image,fit: BoxFit.fill,height: 140,width: 120,),
                          Text(a.title,textAlign: TextAlign.center,) ,
                          Text(a.price.toString() +'\$',),
                          Container(
                            padding: EdgeInsets.all(5.0),
                            child: ElevatedButton(
                                onPressed: (){},
                                child: Container(
                                  child: Text("Đặt hàng"),
                                )
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              }
            );
          }else{
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }
}

class Rating{
  final double rate;
  final int count;
  Rating({required this.rate,required this.count});
}

class Album{
  final int Id;
  final String title;
  final double price;
  final String description;
  final String category;
  final String image;
  final Rating rating;

  Album({required this.Id, required this.title,required this.price,required this.description,required this.category,
    required this.image, required this.rating});

  static Future<List<Album>> fetchData() async{
    var client = http.Client();
    var response = await client.get(Uri.parse("https://fakestoreapi.com/products?limit=100"));

    if(response.statusCode == 200){
      var result = response.body;
      var jsonData = jsonDecode(result);
      print(jsonData.length);

      List<Album> ls  = [];
      for(var item in jsonData){
        Album a = new Album(
          Id: item["id"],
          title: item["title"],
          price: double.parse((item["price"]).toString()),
          description: item["description"],
          category: item["category"],
          image: item["image"],
          rating: Rating(
            rate: double.parse(item['rating']['rate'].toString()),
            count: item['rating']['count'],
          ),
        );
        ls.add(a);
      }
      print(response.body);
      return ls;
    }
    else{
      throw Exception("Lỗi lấy dữ liệu, Lỗi: ${response.statusCode}");
    }
  }
}