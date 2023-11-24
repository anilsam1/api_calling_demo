import 'package:api_calling_demo/model/address_data.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class AddressDemo extends StatefulWidget {
  const AddressDemo({super.key});

  @override
  State<AddressDemo> createState() => _AddressDemoState();
}

class _AddressDemoState extends State<AddressDemo> {

  List<AddressData>? users;
 bool isLoaded = false ;




  Future<List<AddressData>?> fetchData() async
  {
    Dio dio = Dio();
    var responce =await dio.get("https://random-data-api.com/api/v2/addresses?size=10");
    if(responce.statusCode ==200) {
       debugPrint("responce........................$responce");
       return addressDataFromJson(responce.data);
    }
    return null;
    }


  getData() async {

    users = await fetchData();
  if(users != null){
    setState(() {
      isLoaded = true ;
    });
  }

  }


    @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    debugPrint(users?[3].country);
    return Scaffold(

      body: Visibility(
        visible: isLoaded,
          child: Text(users?[3].country ?? " " , style: const TextStyle(color: Colors.black , fontSize: 30),)),

    );
  }
}
