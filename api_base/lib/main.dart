import 'package:api_base/data_resources/api_services.dart';
import 'package:api_base/pages/videos/video_page.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: ElevatedButton(
            child: Text("Get Infor"),
            onPressed: (){
              var route = MaterialPageRoute(builder: (context) => VideoPage());
              Navigator.push(context, route);
            },
          ),
        ),
      ),
    );
  }
}






