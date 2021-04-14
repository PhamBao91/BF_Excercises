import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_base/pages/personal_information/person.dart';

import 'pages/home_screen/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return MultiProvider(
        providers: [
      ChangeNotifierProvider(create: (context)=> Person(),),

        ],
       child: MaterialApp(
         home: HomeScreen(),
       ),
    );
  }
}





