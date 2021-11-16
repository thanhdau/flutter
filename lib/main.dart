import 'package:flutter/material.dart';
import 'package:nhom1/callfakeapi.dart';
import 'package:nhom1/form_basic.dart';
import 'package:nhom1/list_grid.dart';
import 'package:nhom1/material_basic.dart';
import 'package:nhom1/list_basic.dart';
import 'package:nhom1/carousel_list.dart';
import 'package:nhom1/news_api.dart';

void main() {
  runApp(MyApp8());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  Widget createColumn(String data, IconData icons){
    Color color = Colors.red;
    double size = 30;
    return Column(
      children: [
        Icon(
          icons,
          textDirection: TextDirection.ltr,
          color: color,
          size: size,
        ),
        Text(data,
          textDirection: TextDirection.ltr,
          style: TextStyle(
              color: color,
              fontSize: size
          ),
        )
      ],
    );
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            textDirection: TextDirection.ltr,
            children: [
              createColumn("Call", Icons.call),
              createColumn("Route", Icons.router),
              createColumn("Share", Icons.share)

            ],
          )
      ),
      decoration: BoxDecoration(
          color: Colors.white
      ),
      padding: EdgeInsets.all(50),
    );
  }
}