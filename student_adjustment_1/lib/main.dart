import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {


  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  Map<String, double> pointMap = Map<String, double>();
  double averagePoint = 0 ;
  String adjustmentResult = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Đánh giá học sinh"),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(40),
        child: Column(
          children: [
            //  Điểm Toán
             
            mathInput(),
            SizedBox(
              height: 10,
            ),
            // Điểm Văn
            litetureInput(),
            SizedBox(
              height: 10,
            ),
            // Điểm Anh
            englishInput(),
            SizedBox(
              height: 10,
            ),
            // Điểm TB
            averageWidget(),
            SizedBox(
              height: 10,
            ),
            // Học Lưc
            adjustmentWidget(),
            SizedBox(
              height: 50,
            ),

            // Button : Đánh giá
            buttonWidget()
          ],
        ),
      ),
    );
  }

  Widget mathInput(){
    return TextField(
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: "Điểm Toán",
        hintText: "Nhập điểm Toán"
      ),
      onChanged: (value){
        setState(() {
          pointMap["math_point"] = double.parse(value);
        });
      },
    );
  }

  Widget litetureInput(){
    return TextField(
      decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: "Điểm Văn",
          hintText: "Nhập điểm Văn"
      ),
      onChanged: (value){
        setState(() {
          pointMap["liteture_point"] = double.parse(value);
        });
      },
    );
  }

  Widget englishInput(){
    return TextField(
      decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: "Điểm Anh",
          hintText: "Nhập điểm Anh"
      ),
      onChanged: (value){
        setState(() {
          pointMap["english_point"] = double.parse(value);
        });
      },
    );
  }

  averageWidget()
  {
    return averagePoint!= 0 ? Text(
      "Điểm Trung Bình: " + averagePoint.toStringAsFixed(1).toString()
    ) : Container();
  }

  double getAveragePoint(){
    return  (
        (pointMap["math_point"] + pointMap["liteture_point"] + pointMap["english_point"])/3
    );
  }

  Widget adjustmentWidget()
  {
    return adjustmentResult !="" ? Text(
      "Học Lưc: " + adjustmentResult
    ): Container();
  }

  getAdjustment({@required averagePoint})
  {
    if(averagePoint <5 ) return "Học lực kém";
    else if (averagePoint < 6.5) return "Học lực trung bình";
    else if (averagePoint < 8.5) return "Học lực khá";
    else if (averagePoint < 10) return "Học lực giỏi";
  }

  buttonWidget()
  {
    return ElevatedButton(
        onPressed:(){
          setState(() {
            averagePoint = getAveragePoint();
            adjustmentResult = getAdjustment(averagePoint: averagePoint);
          });
        },
        child: Text("Đánh giá"));
  }



}


