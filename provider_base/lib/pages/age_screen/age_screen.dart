import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_base/pages/personal_information/person.dart';
import 'package:provider_base/resources/strings.dart';
class AgeScreen extends StatefulWidget {
  @override
  _AgeScreenState createState() => _AgeScreenState();
}

class _AgeScreenState extends State<AgeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(ageAppBarTitle),
        centerTitle: true,
      ),
      body: Container(
        child: Center(
          child: Consumer<Person>(
            builder: (context, person, child){
              return Text("Tuổi :" + person.age.toString());
              //return child;
           },
            child: Container(
              height: 50,
              width: 50,
              color: Colors.blue,
            ),
          ),
        ),
      ),
    );
  }
}
