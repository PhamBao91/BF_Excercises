import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider_base/pages/personal_information/person.dart';
import 'package:provider_base/pages/personal_information/personal_information.dart';
import 'package:provider_base/resources/strings.dart';
import 'package:provider/provider.dart';
class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  TextEditingController usenameController = TextEditingController();
  TextEditingController ageController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    usenameController.dispose();
    ageController.dispose();
  }


  @override
  Widget build(BuildContext context) {
    final changeInfor = Provider.of<Person>(context);
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: 40, right: 20, left: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            textFieldWidget(
                hintText: usernameHintText,
                labelText: usernameTitle,
                controller: usenameController),
            textFieldWidget(
                hintText: ageHintText,
                labelText: age,
                controller: ageController),
            updateButton(
                buttonText: update,
                onPress: (){
                 context.read<Person>().updateInfor(
                    userName: usenameController.text,
                    age: ageController.text
                  );
                  /*changeInfor.updateInfor( userName: usenameController.text,
                      age: ageController.text);*/
                  var route = MaterialPageRoute(builder: (context)=> PersonalInformation());
                  Navigator.push(context, route);
                })
          ],
        ),
      ),
    );
  }

  textFieldWidget({
    @required hintText,
    @required labelText,
    @required controller}){
    return Container(
      padding: EdgeInsets.all(10),
      child: TextField(
        decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: hintText,
            labelText: labelText
        ),
        controller: controller,
      )
    );
  }

  updateButton({@required buttonText, @required onPress}){
    return GestureDetector(
      child: Container(
        padding: EdgeInsets.all(15),
        margin: EdgeInsets.all(15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.blue
        ),
        child: Text(buttonText, style: TextStyle(color: Colors.white),),
      ),
      onTap: onPress,
    );
  }


}
