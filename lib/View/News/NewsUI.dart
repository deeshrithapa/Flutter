import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:week2/Model/newsapi.dart';
import 'package:week2/Modules/CardsandModules.dart';
import 'package:week2/View/News/newsDetail.dart';
import '../../api/Getapi.dart';

class NewsUi extends StatefulWidget{
  @override
  State<StatefulWidget> createState(){
    return NewsUiState();
  }
}

class NewsUiState extends State<NewsUi>{
  late Future<newsapi?>? _futurehorizontallist;
  late Future<newsapi?>? _futureverticallist;



  horizontalCard(var size, Articles article){
    return Container(
      margin: EdgeInsets.only(left:10),
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
                child: Image.network(article.urlToImage!,
                  fit: BoxFit.cover,),
              ),
            ),
            Positioned(
              left: 15,
              bottom: 70,
              child: Container(
                  width: size.width/1.5,
                  child: Text(article.title!.toUpperCase(), style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),)),
            ),
            Positioned(bottom:10, left:15, child: Text(CardsandModules.formatDateTimesstring(article.publishedAt!),)),
            Positioned(right:10, bottom:10, child: Icon(Icons.play_circle, size:30,))
          ]
      ),
    );
  }
  horizontallistitem(size, Articles article){
    return GestureDetector(
      onTap:() {
      Navigator.push(
        context,
          MaterialPageRoute(builder: (context) =>
              newsDetail(article)));
      },

      child: Container(
        margin: EdgeInsets.only(left: 10),
        child: Stack(
          children: [
            Container(
              width: size.width/1.7,
              height: size.height/4.1,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Image.network(article.urlToImage!,
                    fit: BoxFit.cover),
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
      ),
    );
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
    apicallh();
    apicallv();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    // TODO: implement build
    return Scaffold(
        body: Column(
            children: [
              //horizontal list
              FutureBuilder<newsapi?>(
                  future: _futurehorizontallist, //a previously obtained Future<String>
                  builder: (BuildContext context, AsyncSnapshot<newsapi?>snapshot){
                    //switch
                    switch(snapshot.connectionState){
                      case ConnectionState.none:
                        // error
                        return Container();   // paxi dialog box thapne
                      case ConnectionState.waiting: // loading
                        return Center(
                          child: Container(
                            height: 50,
                            width: 50,
                            child: CircularProgressIndicator(),
                          ),
                        );
                      case ConnectionState.done:
                        if (snapshot.data == null || snapshot.data!.articles!.isEmpty){
                          return Center(
                            child: Container(
                              child : Text("No data or api issue"),
                            ),

                    );
                    }else{
                          return Container(
                          height: size.height/4,
                    width: size.width,
                    child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.all(8),
                    itemCount: snapshot.data!.articles!.length,
                    itemBuilder: (BuildContext context, int index) {
                    return horizontallistitem(size, snapshot.data!.articles![index]);
                    },
                    ),
                    );
                        }
                      default: // error
                        return Container(); // error paxi thapula
                    }

                  }
              ),
              //stack //image //text //date //icon


              FutureBuilder<newsapi?>(
                  future: _futureverticallist, //a previously obtained Future<String>
                  builder: (BuildContext context, AsyncSnapshot<newsapi?>snapshot){
                    //switch
                    switch(snapshot.connectionState){
                      case ConnectionState.none:
                      // error
                        return Container();   // paxi dialog box thapne
                      case ConnectionState.waiting: // loading
                        return Center(
                          child: Container(
                            height: 50,
                            width: 50,
                            child: CircularProgressIndicator(),
                          ),
                        );
                      case ConnectionState.done:
                        if (snapshot.data == null || snapshot.data!.articles!.isEmpty){
                          return Center(
                            child: Container(
                              child : Text("No data or api issue"),
                            ),

                          );
                        }else{
                          return Container(
                          height: size.height/1.5,
                    width: size.width,
                    child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    padding: const EdgeInsets.all(8),
                    itemCount: snapshot.data!.articles!.length,
                    itemBuilder: (BuildContext context, int index) {
                    return CardsandModules.verticalCard(context, size, snapshot.data!.articles![index]);


                    },
                    ),
                    );
                        }
                      default: // error
                        return Container(); // error paxi thapula
                    }

                  }
              ),



            ])
    );
  }

}