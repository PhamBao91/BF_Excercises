import 'dart:convert';

import 'package:flutter/cupertino.dart';

class Logs {

  void printJson({ @required Map json})
  {
    JsonEncoder encoder = new JsonEncoder.withIndent('  ');
    String prettyprint = encoder.convert(json);
    print ("LOGGING: " + prettyprint);
  }


  void printLog({@required string})
  {
    print("LOGGING: " + string);
  }
}