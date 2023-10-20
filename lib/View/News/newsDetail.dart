import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:week2/Modules/CardsandModules.dart';
import '../../api/Getapi.dart';


import '../../Model/newsapi.dart';

class newsDetail extends StatefulWidget{
  Articles article;
  newsDetail(this.article);

  @override
  State<StatefulWidget> createState(){
    return newsDetailState(article);
  }

}

class newsDetailState extends State<newsDetail>{

  late Future<newsapi?>? _futureverticallist;

  Articles article;

  newsDetailState(this.article );



  apicallv(){
    _futureverticallist = Getapi.getnewsdata();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    apicallv();
  }
  @override
  Widget build(BuildContext context){
    var size= MediaQuery.of(context).size;
    return Scaffold(
      body : SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 60,),
            // top part
            // stack // icon // appbar // back button
            // text title , author , date and description
            Stack(
              children: [
                Image.network(article.urlToImage!, height: size.height/3.5, width : size.width, fit : BoxFit.cover,),
                Positioned( top: 15, left: 20,

                    child: GestureDetector(
                      onTap: (){
                        Navigator.pop(context);
                      },
                        child: Icon (Icons.arrow_back, color: Colors.white,size:30,),)),
                Positioned( top: 15,right: 20,
                    child: Icon (Icons.share, color: Colors.white, size: 30,)),
                Container(
                height: size.height/3.5,
                    width: size.width,

                    child: Center(
                        child: Icon(Icons.play_circle, color: Colors.white, size: 50,)))
              ],
            ),
            SizedBox(height: 15,),
        Container(
          width: size.width,
          padding: EdgeInsets.only(bottom: 20,),
          child: Text("",
            maxLines: 2,overflow: TextOverflow.ellipsis,
            style: TextStyle(color: Colors.black,fontSize: 16,
                fontWeight:FontWeight.bold),),
        ),

              Padding(
                padding: const EdgeInsets.only(left: 15.0, right: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(article.author!, style: TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.normal,),),

                    Text (CardsandModules.formatDateTimesstring(article.publishedAt!), style:
                      TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.normal,),),
                  ],
                ),
              ),
            Container(
              width: size.width/1.2,
              padding: EdgeInsets.only(bottom: 20, top: 15,),
              child: Text("",
                maxLines: 2,overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Colors.black,fontSize: 14,
                    fontWeight:FontWeight.normal),),
            ),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: Divider(
                  color: Colors.black, height: 10, thickness: 0.8,),
              ),

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



              // divider

              // bottom part
              //vertical list card

        ],
        ),
      ),
    );
  }

}