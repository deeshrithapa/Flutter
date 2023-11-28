// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:week2/Model/newsapi.dart';
import 'package:week2/Modules/dialogboxes.dart';
import 'package:week2/View/News/newsDetail.dart';
import 'package:week2/api/getapi.dart';
import 'package:week2/modules/cardsandmodules.dart';

import '../../static.dart';



class NewsUI extends StatefulWidget{
  @override
  State<StatefulWidget> createState(){
    return NewsUIState();
  }
}

class NewsUIState extends State<NewsUI>{
  late Future<newsapi?>? _futurehorizontallist;
  late Future<newsapi?>? _futureverticallist;
  RefreshController _refreshController =
  RefreshController(initialRefresh: false);
  ConnectivityResult _connectionStatus = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  horizontalCard(var size, Articles articles){
    return Container(
      margin: EdgeInsets.only(left: 10),
      child: Stack(
          children:[
            Container(
              height: size.height/4,
              width: size.width/1.5,
              margin: EdgeInsets.only(left: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20)
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  articles.urlToImage != null ?articles.urlToImage!: StaticValue.defaultimgurl,
                  fit: BoxFit.cover,),
              ),
            ),
            Positioned(
              left: 15,
              bottom: 70,
              child: Container(
                  width: size.width/1.5,
                  child: Text(articles.title!, style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),)),
            ),
            Positioned(bottom:10, left:15, child: Text(CardsandModules.formatDateTimesstring(articles.publishedAt!))),
            Positioned(right:10, bottom:10, child: Icon(Icons.play_circle, size:30,))
          ]
      ),
    );
  }
  horizontallistitem(size, Articles article){
    return Container(
      margin: EdgeInsets.only(left: 10),
      child: Stack(
        children: [
          GestureDetector(
            onTap: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>
                    newsDetail(article)),
              );
            },
            child: Container(
              width: size.width/1.7,
              height: size.height/4.1,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
              ),

              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Image.network(
                    article.urlToImage != null ?article.urlToImage!: StaticValue.defaultimgurl,
                    fit: BoxFit.cover),
              ),
            ),
          ),
          Positioned(
            bottom: 65,
            left: 20,
            child: Container(
              width: size.width/1.9,
              child: Text(article.title!.toUpperCase()
                ,maxLines: 2,overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Colors.white,fontSize: 16,
                    fontWeight:FontWeight.bold),),
            ),
          ),
          Positioned(
            left: 20,bottom: 5,
            child: Text(CardsandModules.formatDateTimesstring(article.publishedAt!),style: TextStyle(color: Colors.white,
              fontSize: 14,fontWeight: FontWeight.normal,),),
          ),
          Positioned(bottom: 5,right: 15,child: Icon(Icons.play_circle,color: Colors.white,size: 25,))
        ],
      ),
    );
  }
  Gridcarditem(Size size, Articles article){
    return Container(
      child: Column(
        children: [
          //image
          Container(
            height: 80,
            margin: const EdgeInsets.only(left: 10 ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
            ),

            child: ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Image.network(article.urlToImage!,
                  fit: BoxFit.cover),
            ),
          ),

          //col
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  width: size.width/1.5,
                  child: Text(article.title!, style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),)),
              Container(
                  width: size.width/1.5,
                  child: Text(article.author!, style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),)),
              Container(
                  width: size.width/1.5,
                  child: Text(CardsandModules.formatDateTimesstring(article.publishedAt!), style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),)),
            ],
          )
        ],
      ),
    );
  }
  verticalCard(var size, Articles articles){
    return  Container(
      child: Row(
        children: [
          //stack column
          Column(
            children: [
              Stack(
                children: [
                  Container(
                    height: 150,
                    width: 200,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.network(
                        articles.urlToImage != null ?articles.urlToImage!: StaticValue.defaultimgurl,
                        fit: BoxFit.cover,),
                    ),
                  ),
                  Positioned(left: 85, top: 60, child:
                  Icon(Icons.play_circle, color: Colors.black, size: 30,),)
                ],
              ),
              //text
            ],
          ),

          Column(
            children: [
              Container(
                width: size.width/2,
                child: Text(articles.title!,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black),maxLines: 2,),
              ),
              //button

              Row(
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 20, right: 20, top:15, bottom: 15),
                    decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: Text(articles.author!,
                      style: TextStyle(color: Colors.white, fontSize: 10),),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),

                    child: Text(CardsandModules.formatDateTimesstring(articles.publishedAt!),
                      style: TextStyle(color: Colors.black, fontSize: 12),
                    ),
                  )
                ],
              )
            ],
          ),

          //column
          //text
          // row //container //text //date //icon
        ],
      ),
    );
  }
  void _onRefresh() async{
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  void _onLoading() async{
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()

    _refreshController.loadComplete();
  }


  apicallh(){
    _futurehorizontallist = Getapi.getnewsdata();
  }
  apicallv(){
    _futureverticallist = Getapi.getnewsdata();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initConnectivity();

    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    apicallh();
    apicallv();
  }

// Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initConnectivity() async {
    late ConnectivityResult result;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      ShowDialogBox.warningdialogbox(context, e.message.toString());
      //developer.log('Couldn\'t check connectivity status', error: e);
      return;
    }
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    setState(() {
      _connectionStatus = result;
      //dialogbox(connection status)
      if (_connectionStatus == ConnectivityResult.mobile) {
        // I am connected to a mobile network.
      } else if (_connectionStatus == ConnectivityResult.wifi) {
        // I am connected to a wifi network.
      }else{
        //dialogbox
        ShowDialogBox.warningdialogbox(context, "Internet connection error" );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    // TODO: implement build
    return SmartRefresher(
      controller: _refreshController,
      onRefresh: _onRefresh,
      onLoading: _onLoading,
      child: Scaffold(
          body: SingleChildScrollView(
            child: Column(
                children: [
                  //horizontal list
                  FutureBuilder<newsapi?>(
                      future: _futurehorizontallist, //a previously obtained Future<String>
                      builder: (BuildContext context, AsyncSnapshot<newsapi?>snapshot){
                        //switch
                        switch (snapshot.connectionState) {
                          case ConnectionState.none:
                          //error
                            return Container(); //paxi dialog box thapne
                          case ConnectionState.waiting: //loading
                            return Container(
                              height: 50,
                              width: 50,
                              child: CircularProgressIndicator(),
                            );
                          case ConnectionState.done:
                            if(snapshot.data==null || snapshot.data!.articles!.isEmpty){
                              return Center(
                                child: Container(
                                  child: Text("No data or api issue"),
                                ),
                              );
                            }
                            else{
                              //data aayo
                              //show ui

                              return Container(
                                height: size.height/4,
                                width: size.width,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: snapshot.data!.articles!.length,
                                  itemBuilder: (BuildContext context, int index) {
                                    return horizontallistitem(size, snapshot.data!.articles![index]);
                                  },
                                ),
                              );
                            }
                          default: //error
                            return Container(); //error paxi thapamla
                        }
                      }
                  ),

                  FutureBuilder<newsapi?>(
                      future: _futureverticallist, //a previously obtained Future<String>
                      builder: (BuildContext context, AsyncSnapshot<newsapi?>snapshot){
                        //switch
                        switch (snapshot.connectionState) {
                          case ConnectionState.none:
                          //error
                            return Container(); //paxi dialog box thapne
                          case ConnectionState.waiting: //loading
                            return Container(
                              height: 50,
                              width: 50,
                              child: CircularProgressIndicator(),
                            );
                          case ConnectionState.done:
                            if(snapshot.data==null || snapshot.data!.articles!.isEmpty){
                              return Center(
                                child: Container(
                                  child: Text("No data or api issue"),
                                ),
                              );
                            }
                            else{
                              //data aayo
                              //show ui
                              var newsvdata = snapshot.data;
                              return Column(
                                children: [

                                  Container(
                                    height:size.height,
                                    width:size.width,
                                    child: GridView.builder(
                                        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                                            maxCrossAxisExtent: 250,
                                            childAspectRatio: 1 / 1,
                                            crossAxisSpacing: 10,
                                            mainAxisSpacing: 10),
                                        itemCount: newsvdata!.articles!.length,
                                        itemBuilder: (BuildContext ctx, index) {
                                          return Gridcarditem(size, newsvdata.articles![index]);
                                        }),
                                  ),


                                  Container(
                                    height: size.height/1.5,
                                    width: size.width,
                                    child: ListView.builder(
                                      scrollDirection: Axis.vertical,
                                      padding: const EdgeInsets.all(8),
                                      itemCount: snapshot.data!.articles!.length,
                                      itemBuilder: (BuildContext context, int index) {
                                        return CardsandModules.verticalCard(context, size,snapshot.data!.articles![index]);
                                      },
                                    ),
                                  ),
                                ],
                              );
                            }
                          default: //error
                            return Container(); //error paxi thapamla
                        }
                      }
                  ),




                ]),
          )
      ),
    );
  }

}