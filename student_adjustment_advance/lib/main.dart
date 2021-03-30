import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_adjustment/resources/widgets/spaces.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  Map<String, double> pointMap = Map<String, double>();
  double diemTB = 0;
  String hocLuc = "";
  
  TextEditingController mathController, litetureController, englishController ;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    englishController = TextEditingController();
    litetureController = TextEditingController();
    mathController = TextEditingController();
    getInforFromStorage();

  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    englishController.dispose();
  }


  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: appBar(title: "Đánh giá học sinh"),
        body: Container(
          padding: EdgeInsets.only(top: 20),
          child: Center(
            child: Container(
              margin: EdgeInsets.only(right: 50, left: 50),
              child: Column(
                children: [
                  inputText(
                      controller: mathController,
                      hintText: "Nhập điểm Toán",
                      labelText: "Điểm Toán"),
                  Divider(
                    height: 10,
                  ),
                  inputText(
                      controller: litetureController,
                      hintText: "Nhập điểm Văn",
                      labelText: "Điểm Văn"),
                  Divider(
                    height: 10,
                  ),
                  inputText(
                      controller: englishController,
                      hintText: "Nhập điểm Anh",
                      labelText: "Điểm Anh"),
                  spaceVertical(height: 5.0),
                  diemTB!=0 ? Text("Điểm trung bình: " + diemTB.toStringAsFixed(1)): Container(),
                  spaceVertical(height: 10.0),
                  hocLuc!="" ? Text("Xếp loại: "+ hocLuc): Container(),
                  spaceVertical(height: 10.0),
                  ElevatedButton(
                      onPressed: (){
                        setInforIntoStorage();
                        setState(() {
                          diemTB = tinhDiemTrungBinh();
                          hocLuc = xepLoaiHocLuc(diemTB: diemTB);
                        });

                      },


                      child: Text("Đánh giá")),

                ],
              ),
            ),
          ),
        ),
      )
    );
  }

  getInforFromStorage()async {
    SharedPreferences inforStorage = await SharedPreferences.getInstance();

    double math  =  inforStorage.getDouble('math')?? 0 ; //?? 0
    double liteture  =  inforStorage.getDouble('liteture')?? 0 ;
    double english  =  inforStorage.getDouble('english')?? 0 ;
     mathController?.text = math.toString();
    litetureController.text = liteture.toString();
    englishController.text = english.toString();
  }

  setInforIntoStorage() async {
    SharedPreferences inforStorage = await SharedPreferences.getInstance();
    await inforStorage.setDouble('math', double.parse(mathController.text==""?"0.0": mathController.text));
    await inforStorage.setDouble('liteture', double.parse(litetureController.text==""?"0.0":litetureController.text ));
    await inforStorage.setDouble('english', double.parse(englishController.text==""?"0.0":englishController.text));
  }



appBar({@required title}){
  return AppBar(
    title: Text(title),
    centerTitle: true,
  );
}

Widget inputText({@required controller, @required hintText, @required labelText}){
    return TextField(
      controller: controller ,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: hintText,
        labelText: labelText
      ),
    );
}


tinhDiemTrungBinh(){
   if(mathController.text =="") print("Điểm toán lạ kì");
  return ( double.parse(mathController.text==""?"0.0":mathController.text) + double.parse(litetureController.text==""?"0.0":litetureController.text) + double.parse(englishController.text ==""?"0.0":englishController.text) )/3;
}

xepLoaiHocLuc({@required diemTB})
{

  if(diemTB < 5) return "Hoc Yếu";
  else if(diemTB < 6.5 ) return "Học Trung Bình";
  else if(diemTB < 8.5 ) return "Học Khá";
  else if(diemTB <= 10 ) return "Học Giỏi";
  return "Bạn cần nhập lại";
}

}
