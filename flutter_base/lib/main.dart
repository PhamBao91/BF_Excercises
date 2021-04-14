import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  TextEditingController mathController = TextEditingController();
  TextEditingController litetureController = TextEditingController();
  TextEditingController englishController = TextEditingController();
  double averagePoint = 0 ;
  String adjustmentResult = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPointFromStorage();


  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    if(context != null) {

    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    mathController.dispose();
    litetureController.dispose();
    englishController.dispose();
  }

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
             
            inputWidet(
                controller: mathController,
                lable: "Điểm Toán",
                hint: "Nhập điểm Toán"),
            SizedBox(
              height: 10,
            ),
            // Điểm Văn
            inputWidet(
                controller: litetureController,
                lable: "Điểm Văn",
                hint: "Nhập điểm Văn"),
            SizedBox(
              height: 10,
            ),
            // Điểm Anh
            inputWidet(
                controller: englishController,
                lable: "Điểm Anh",
                hint: "Nhập điểm Anh"),
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

  Widget inputWidet({@required controller, @required lable, @required hint  }){
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: lable,
        hintText: hint
      ),
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
        (double.parse(mathController.text?? 0) +
            double.parse(litetureController.text?? 0) +
            double.parse(englishController.text?? 0))/3
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
          // set points
          setInforIntoStorage();
          setState(() {
            averagePoint = getAveragePoint();
            adjustmentResult = averagePoint!= null ? getAdjustment(averagePoint: averagePoint):"";
          });
        },
        child: Text("Đánh giá"));
  }

  setInforIntoStorage() async {
    SharedPreferences inforStorage = await SharedPreferences.getInstance();
    await inforStorage.setDouble("math_point", double.parse(mathController.text));
    await inforStorage.setDouble("liteture_point", double.parse(litetureController.text));
    await inforStorage.setDouble("english_point", double.parse(englishController.text));

  }

  getPointFromStorage()async {
    SharedPreferences inforStorage = await SharedPreferences.getInstance();
    mathController.text = inforStorage.getDouble("math_point").toString();
    litetureController.text = inforStorage.getDouble("liteture_point").toString();
    englishController.text = inforStorage.getDouble("english_point").toString();

  }



}


