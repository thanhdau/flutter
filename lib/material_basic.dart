
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Myapp2 extends StatelessWidget {
  const Myapp2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Group1",
      home: MaterialBasic(),
    );
  }
}


class MaterialBasic extends StatefulWidget {
  const MaterialBasic({Key? key}) : super(key: key);

  @override
  _MaterialBasicState createState() => _MaterialBasicState();
}

class _MaterialBasicState extends State<MaterialBasic>{
  int count = 0;
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("Trang chu"),
        leading: Icon(Icons.home, size: 30, color: Colors.amber,),
        actions: [
          IconButton(
              onPressed: (){
                var snack = SnackBar(content: Text("Alert Content"),
                );
                ScaffoldMessenger.of(context).showSnackBar(snack);
              },
              icon: Icon(Icons.add_alert_rounded)),
          IconButton(
              onPressed: (){
                var snack2 = SnackBar(content: Row(
                  children: [
                    Icon(Icons.alarm, color: Colors.white,),
                    Text("Xin Chao")
                  ],
                )
                );
                ScaffoldMessenger.of(context).showSnackBar(snack2);
              },
              icon: Icon(Icons.login))
        ],
      ),
      body: Center(
        child:
            Column(
              children: [
                Image.network("https://images.unsplash.com/photo-1580589454067-5b73e4c2cb52?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=334&q=80"),
                Text(
                  "Dem: $count",
                  style: TextStyle(fontSize: 30),
                )
              ],
            )
        ),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        color: Colors.amber,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
         children: [
           IconButton(
               onPressed: (){

               }, icon: Icon(Icons.call,size: 30, color: Colors.blue,)),
           IconButton(
               onPressed: (){

               }, icon: Icon(Icons.place,size: 30, color: Colors.red,))
         ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          setState(() {
            count++;
            print(count);
          });
        },
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}