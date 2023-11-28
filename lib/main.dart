import 'package:flutter/material.dart';
import 'package:week2/RouteGen.dart';
import 'package:week2/View/News/NewsUI.dart';
import 'package:week2/View/maps/mappage.dart';

import 'View/Auth/loginpage.dart';
import 'View/Cart/CartPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      onGenerateRoute: RouteGen.generateRoute,
      //home: MapSample(),
    );
  }
}

class firstclass extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return firstclassState();
  }

}

class firstclassState extends State<firstclass>{
  textcard(String txt){
    return  Container(
      height: 40,
      width: 100,
      margin: const EdgeInsets.only(left: 8,right: 8),
      decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(20)
      ),
      child: Center(child: Text(txt,style: const TextStyle(color: Colors.white),)),
    );
  }
  // product list horizontal
  horizontalcard(){
    return Container(
      margin: EdgeInsets.only(left: 12),
      decoration: BoxDecoration(
          borderRadius:BorderRadius.circular(30)
      ),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Column(
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight:  Radius.circular(30),
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30)
                    ),

                    child: Image.network("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSMvoozsQTWZLHDu96cFh27LotmyLlXWRd4c-LyI8c-Se5JeFUa5Qhtm-6q7ZTqd1H6d8g&usqp=CAU"
                      ,fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    left: 25,
                    top: 15,
                    child: Container(

                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(50)
                        ),
                        child: Icon(Icons.heart_broken, size:30, )),
                  )
                ],

              ),

              // text
              SizedBox(height:10,),
              Padding(
                padding: const EdgeInsets.only(left:38.0),
                child: Text("burger ",
                  style: TextStyle(color: Colors.black,
                      fontSize: 40, fontWeight: FontWeight.normal), ),
              ),
              SizedBox(height:10,),
              Padding(
                padding: const EdgeInsets.only(left:38.0),
                child: Text("Rs.1000/- ",
                  style: TextStyle(color: Colors.black,
                      fontSize: 30, fontWeight: FontWeight.normal), ),
              ),
              Row(

                children: [
                  Icon(Icons.star),
                  Icon(Icons.star),
                  Icon(Icons.star),
                  Icon(Icons.star),
                  Icon(Icons.star_border)
                ],
              ),


            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body:  SingleChildScrollView(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                color: Colors.black12,
                child: Column(
                  children: [
                    const SizedBox(height:20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 60,
                          width: size.width/1.1,
                          decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(50)
                          ),
                          child: Row(
                            children:  const [
                              Padding(
                                padding: EdgeInsets.only(left: 15.0,right: 15.0),
                                child: Icon(Icons.search,color: Colors.white,size: 18,),
                              ),
                              Text("Search Here...",style: TextStyle(color: Colors.white),)
                            ],
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height:20),
                    Container(

                      child: Row(
                        children: [
                          textcard("menu1"),
                          textcard("menu2"),
                          textcard("menu3"),
                          textcard("menu4"),
                          textcard("menu5"),
                          textcard("menu6")
                        ],
                      ),
                    ),
                    const SizedBox(height: 20,)
                  ],
                ),
              ),
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left:100.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Food Home Delivery",
                        style: TextStyle(color: Colors.black,
                        fontSize: 20, fontWeight: FontWeight.bold), ),
                        Row(
                          children: [
                            Icon(Icons.star),
                            Icon(Icons.star),
                            Icon(Icons.star),
                            Icon(Icons.star),
                            Icon(Icons.star)
                          ],
                        ),
                      ],
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(right:15.0),
                    child: Text("Rs.500\-" , style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 30),),

                  ),
                ],
              ),
              SizedBox(height:50,),
              Padding(
                padding: const EdgeInsets.only(left:38.0),
                child: Text("Details",
                  style: TextStyle(color: Colors.black,
                      fontSize: 40, fontWeight: FontWeight.bold), ),
              ),
              SizedBox(height:10,),
              Padding(
                padding: const EdgeInsets.only(left:38.0),
                child: Text("Online food ordering system! ",
                  style: TextStyle(color: Colors.black,
                      fontSize: 20, fontWeight: FontWeight.normal), ),
              ),

              SizedBox(height:50,),
              Padding(
                padding: const EdgeInsets.only(left:38.0),
                child: Text("Contact Details",
                  style: TextStyle(color: Colors.black,
                      fontSize: 40, fontWeight: FontWeight.bold), ),
              ),
              SizedBox(height:10,),
              Padding(
                padding: const EdgeInsets.only(left:38.0),
                child: Text("Through text, website order or contact number. ",
                  style: TextStyle(color: Colors.black,
                      fontSize: 20, fontWeight: FontWeight.normal), ),
              ),
              // horizontal line
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    horizontalcard(),
                    horizontalcard(),
                    horizontalcard(),
                    horizontalcard(),
                    horizontalcard()
                  ],
                ),
              )
            ],
          ),
        ),
      ),


    );
  }

}
