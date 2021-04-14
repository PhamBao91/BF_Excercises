import 'package:flutter/material.dart';

class Person with ChangeNotifier {
  String userName = "Chưa cập nhật";
  String age = "Chưa cập nhật";

  Person({this.userName, this.age});

  updateInfor({userName, age})
  {
    this.userName = userName;
    this.age = age;
    notifyListeners();
  }

  updateUserName({userName})
  {
    this.userName = userName;
    notifyListeners();
  }

  updateAge({age})
  {
    this.age = age;
    notifyListeners();
  }
}