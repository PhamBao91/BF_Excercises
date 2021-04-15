import 'package:api_base/blocs/video_bloc.dart';
import 'package:api_base/data_resources/api_services.dart';
import 'package:api_base/pages/videos/video_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  final videoBloc = VideoBloc();

  @override
  Widget build(BuildContext context) {
    videoBloc.fetchAllVideos();

    return StreamProvider(
        create: (context) => videoBloc.allVideo,
        catchError: (context, error)
        {
          print(error.toString());
        },
        child: MaterialApp(
          home: HomeScreen(),
        ));
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






