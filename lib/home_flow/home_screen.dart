

import 'dart:async';

import 'package:api_calling_demo/model/user_data.dart';
import 'package:api_calling_demo/service/remote_service.dart';
import 'package:api_calling_demo/value/app_style.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  late StreamSubscription subscription;
  bool isDeviceConnected = false;
  bool isAlertSet = false;
  ValueNotifier<List<Welcome>?> users = ValueNotifier([]);
  ValueNotifier<bool> isLoaded = ValueNotifier(false);

  getData() async {
    users.value = await RemoteService().getUserData();
    if (users.value != null) {
      isLoaded.value = true;
    }
  }


  getConnectivity() =>
      subscription = Connectivity().onConnectivityChanged.listen(
            (ConnectivityResult result) async {
          isDeviceConnected = await InternetConnectionChecker().hasConnection;
          if (!isDeviceConnected && isAlertSet == false) {
            showDialogBox();
            setState(() => isAlertSet = true);
          }
        },
      );


  showDialogBox() => Container(color: Colors.black,height: 100,);

  @override
  void initState() {
    getConnectivity();
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: users,
      builder: (context, value, child) {
        return RefreshIndicator(
          displacement: 250,
          backgroundColor: Colors.yellow,
          color: Colors.red,
          strokeWidth: 3,
          triggerMode: RefreshIndicatorTriggerMode.onEdge,
          onRefresh: () async {
            await Future.delayed(const Duration(milliseconds: 1500));
            setState(() {
              getData();
            });
          },
          child: Scaffold(
            body: ValueListenableBuilder(
              valueListenable: isLoaded,
              builder: (BuildContext context, value, Widget? child) {
                return value
                    ? ListView.builder(
                        itemCount: users.value?.length,
                        itemBuilder: (BuildContext context, int index) {
                         final singleUser = users.value?[index];
                          return Stack(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                      color:
                                          Colors.greenAccent.withOpacity(0.5),
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(
                                          color: Colors.greenAccent)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "First Name :- ${singleUser?.firstName}",
                                          style: tutorialDetailStyle,
                                        ),
                                        Text(
                                          "Last Name :- ${singleUser?.lastName}",
                                          style: tutorialDetailStyle,
                                        ),
                                        Text(
                                          "Gender :- ${singleUser?.gender}",
                                          style: tutorialDetailStyle,
                                        ),
                                        Text(
                                          "Birth Date :- ${singleUser?.dateOfBirth.toString()}",
                                          style: tutorialDetailStyle,
                                        ),
                                        Text(
                                          "email :- ${singleUser?.email}",
                                          style: tutorialDetailStyle,
                                        ),
                                        Text(
                                          "Phone Number:- ${singleUser?.phoneNumber}",
                                          style: tutorialDetailStyle,
                                        ),
                                        Text(
                                          "Employment :- ${singleUser?.employment.title}",
                                          style: tutorialDetailStyle,
                                        ),
                                        Text(
                                          "Skills :- ${singleUser?.employment.keySkill}",
                                          style: tutorialDetailStyle,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(15),
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.lightGreenAccent
                                            .withOpacity(0.6),
                                        borderRadius: BorderRadius.circular(20),
                                        border: Border.all(
                                            color: Colors.greenAccent,
                                            width: 2)),
                                    child: ClipRRect(
                                      child: CachedNetworkImage(
                                        width: 80,
                                        height: 80,
                                        imageUrl:
                                            users.value?[index].avatar ?? " ",
                                        placeholder: (context, url) =>
                                            const CircularProgressIndicator(),
                                        errorWidget: (context, url, error) =>
                                            const Icon(Icons.error),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      )
                    : const Center(child: CircularProgressIndicator());
              },
            ),
          ),
        );
      },
    );

  }
}
