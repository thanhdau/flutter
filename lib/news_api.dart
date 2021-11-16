import 'dart:async';
import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:nhom1/ViewNews.dart';
class MyApp8 extends StatelessWidget {
  const MyApp8({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "NewsApi",
      home: newsApi(),
    );
  }
}
class newsApi extends StatefulWidget {
  const newsApi({Key? key}) : super(key: key);

  @override
  _newsApiState createState() => _newsApiState();
}

class _newsApiState extends State<newsApi> {
  List<Carousel_list> carousel = <Carousel_list>[];
  List<Post> post = <Post>[];

  bool _loading = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    carousel = getCarousel();
    getPost();
  }
  getPost() async{
    Posts p = new Posts();
    await p.getPost();
    post = p.po;
    setState(() {
      _loading = false;
    });

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("News API",style: TextStyle(
              color: Colors.blue,
              fontWeight: FontWeight.bold
            ),)
          ],
        ),
      ),
      body: _loading ? Center(
        child: Container(
          child: CircularProgressIndicator(),
        ),
      ):SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                height: 70,
                child: ListView.builder(
                    itemCount: carousel.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index){
                      return Carousel_Slider(
                           carousel[index].Carousel_list_Name,
                        carousel[index].img,
                      );
                    },
                ),
              ),
              ///Post
              Container(
                child: ListView.builder(
                  itemCount: post.length,
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    itemBuilder: (context, index){
                    return BlogTile(
                        imageUrl: post[index].urlToImage,
                        title: post[index].title,
                        desc: post[index].description,
                        url: post[index].url,
                        );
                    },

                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class Carousel_Slider extends StatelessWidget {

  final  Carousel_list_Name,img;
  Carousel_Slider(this.Carousel_list_Name, this.img);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 20),
      child: Stack(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
                child: Image.network(img, width: 120, height: 60,fit: BoxFit.cover,)
            ),
            Center(
              child: Container(
                alignment: Alignment.center,
                width: 120, height: 60,
                child: Text(Carousel_list_Name, style: TextStyle(
                  color: Colors.white
                ),),
              ),
            ),

          ],
      ),
    );
  }
}
class BlogTile extends StatelessWidget {
 final String imageUrl, title, desc, url;

   BlogTile({required this.imageUrl,required this.title,required this.desc, required this.url});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(
            builder:(context) => ArticleView(
              blogUrl: url,

            )
            ));
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 16),
        child: Column(
          children: <Widget>[
            SizedBox(height: 8,),
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
                child: Image.network(imageUrl, fit: BoxFit.cover,width: 400,height: 200,),
            ),
            Text(title, style: TextStyle(
              fontSize: 18,
              color: Colors.black87,
              fontWeight: FontWeight.bold
            ),),
            SizedBox(height: 8,),
            Text(desc, style: TextStyle(
              color: Colors.black54
            ),)
          ],
        ),
      ),
    );
  }
}

class Carousel_list{
   late String Carousel_list_Name;
   late String img;
}
List<Carousel_list> getCarousel(){
    List<Carousel_list> crsl = <Carousel_list>[];
    Carousel_list carousel_list = new Carousel_list();

    carousel_list.Carousel_list_Name = "Tin mới";
    carousel_list.img = "https://media.istockphoto.com/photos/online-news-on-a-smartphone-and-laptop-woman-reading-news-or-articles-picture-id1219980553?b=1&k=20&m=1219980553&s=170667a&w=0&h=HGLxwS06WjWFl9TSEKwmRbPtz9AS4og49opQ_2uxYCk=";
    crsl.add(carousel_list);
    carousel_list = new Carousel_list();

    carousel_list.Carousel_list_Name = "Giải trí";
    carousel_list.img = "https://images.unsplash.com/photo-1593642532454-e138e28a63f4?ixid=MnwxMjA3fDF8MHxlZGl0b3JpYWwtZmVlZHw2fHx8ZW58MHx8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60";
    crsl.add(carousel_list);
    carousel_list = new Carousel_list();

    carousel_list.Carousel_list_Name = "Covid - 19";
    carousel_list.img = "https://media.istockphoto.com/photos/coronavirus-with-dna-illustration-picture-id1268214384?b=1&k=20&m=1268214384&s=170667a&w=0&h=SW0JyONnyBEAPGZ2CBlfipzdx680P6OvODbHB7O-JMg=";
    crsl.add(carousel_list);
    carousel_list = new Carousel_list();

    carousel_list.Carousel_list_Name = "Đọc báo";
    carousel_list.img = "https://media.istockphoto.com/photos/newspapers-picture-id513051742?b=1&k=20&m=513051742&s=170667a&w=0&h=ax1sVBU4REigOoOp3c28CntSSDKvg-eHIiSzOIPV6sM=";
    crsl.add(carousel_list);
    carousel_list = new Carousel_list();
    return crsl;
}

class Post{
  final String title;
  final String description;
  final String url;
  final String urlToImage;
  final String content;

  Post(
      {
        required this.title,
        required this.description,
        required this.url,
        required this.urlToImage,
        required this.content,
      }
        );

}
class Posts{
  List <Post> po = [];
  Future<void> getPost()  async {

    print("alo");
    var client = http.Client();
    var response = await client.get(Uri.parse("https://newsapi.org/v2/everything?q=tesla&from=2021-10-16&sortBy=publishedAt&apiKey=f4011407e93740b7b765981d5cf4e3d6"));
    if(response.statusCode == 200){
      var result = response.body;
      var jsonData = jsonDecode(result);

      if(jsonData['status']=="ok"){
        jsonData["articles"].forEach((element){
          if(element["urlToImage"]!= null && element["description"]!=null){
            Post p = new Post(
               title: element["title"],
                description: element["description"],
                url: element["url"],
                urlToImage: element["urlToImage"],
                content: element["content"],
            );
            po.add(p);
          }
          print(response.body);
        });
      }
    }
    else{
      throw Exception("Lỗi lấy dữ liệu, Lỗi: ${response.statusCode}");
    }
  }
}

