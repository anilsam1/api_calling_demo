import 'package:api_calling_demo/model/user_data.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class RemoteService{
  Future<List<Welcome>?> getUserData() async{

  var client = http.Client();
  var uri = Uri.parse("https://random-data-api.com/api/v2/users?size=50");
  var responce = await client.get(uri);
  if(responce.statusCode == 200){
    debugPrint("status 200");
    var json = responce.body;
    debugPrint("successful fetching");
    return welcomeFromJson(json);
  }

  }
}