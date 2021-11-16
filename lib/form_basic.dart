import 'package:flutter/material.dart';
class MyApp5 extends StatelessWidget {
  const MyApp5({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FormBasic(),
    );
  }
}
class FormBasic extends StatefulWidget {
  const FormBasic({Key? key}) : super(key: key);

  @override
  _FormBasicState createState() => _FormBasicState();
}

class _FormBasicState extends State<FormBasic> {
  var fKey = GlobalKey<FormState>();
  var txtTenDangNhap = TextEditingController();
  var txtMatKhau = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Form(
        key: fKey,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              SizedBox(height: 50,),
              Text("Đăng nhập hệ thống", style: TextStyle(fontSize: 25,color: Colors.orange),),
              TextFormField(
                controller: txtTenDangNhap,
                validator: (value){
                  if(value == null || value.isEmpty) // check giá trị đăng nhập
                    return "Vui lòng nhập tên đăng nhập";
                  else
                    return null;
                },
                decoration: InputDecoration(
                  icon:
                  Icon(Icons.person),
                    hintText: "Nhập tên đăng nhập",
                  labelText: "Tên đăng nhập (*)"
                ),
              ),
              TextFormField(
                controller: txtMatKhau,
                validator: (value){
                  if(value == null || value.isEmpty) // check giá trị đăng nhập
                    return "Vui lòng nhập mật khẩu";
                  else if (value.length <6)
                    return "Mật khẩu dài ít nhất 6 ký tự";
                  else
                    return null;
                },
                decoration: InputDecoration(
                    icon: Icon(Icons.lock_open),
                  hintText: "Nhập mật khẩu",
                  labelText: "Mật khẩu (*)",
                ),
              ),
              Container(
                margin: EdgeInsets.all(20),
                child: ElevatedButton(
                    onPressed: (){
                      if(fKey.currentState!.validate()){
                        var tenDangNhap = txtTenDangNhap.text;
                        var matKhau = txtMatKhau.text;
                        showDialog(context: context, builder: (context){
                          return AlertDialog(
                            content: Text("Tên đăng nhập: ${tenDangNhap}, Mật khẩu: ${matKhau}"),
                          );
                        });
                        print("OK, ${tenDangNhap}, ${matKhau}");
                      }
                      else
                        print("ONot pass");
                    },
                    child: Container(
                        child:   Text("Đăng nhập"),
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


