import 'package:flutter/material.dart';
import 'package:provider_base/pages/age_screen/age_screen.dart';
import 'package:provider_base/pages/personal_information/person.dart';
import 'package:provider_base/resources/strings.dart';
import 'package:provider/provider.dart';
class PersonalInformation extends StatefulWidget {
  @override
  _PersonalInformationState createState() => _PersonalInformationState();
}

class _PersonalInformationState extends State<PersonalInformation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            textWidget(
                title: usernameTitle,
                content: context.read<Person>().userName),
            textWidget(
                title: age,
                content: context.read<Person>().age),
            nextButton()
          ],
        ),
      ),
    );
  }

  textWidget({@required title, @required content}){
    return Container(
      child: Row(
        children: [
          Expanded(
              child:Text(title),
          ),
          Expanded(
            child: Text(content),
          )
        ],
      ),
    );

  }

  nextButton(){
    return Container(
      padding: EdgeInsets.all(10),
      child:  ElevatedButton(
          onPressed: (){
            var route = MaterialPageRoute(builder: (context)=> AgeScreen());
            Navigator.push(context, route);
          },
          child: Text("Next")),
    );
  }
}
