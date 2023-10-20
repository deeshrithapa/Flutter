import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:week2/View/News/newsDetail.dart';
import '../Model/newsapi.dart';

class CardsandModules{
  // widgets eg dialog box, toast, cards, error handeling
  // date time formatter

    static String formatDateTimesstring(String date){
    DateFormat dateFormat = DateFormat("yyyy-MM-dd");
    DateTime format = (dateFormat.parse(date));
    DateFormat longdate = DateFormat("MMM dd, yyyy");
    date = longdate.format(format);
    return date;
  }

    static verticalCard(context, var  size,Articles article){
        return  GestureDetector(
            onTap: (){
                Navigator.push (
                    context,
                    MaterialPageRoute(builder: (context) =>
                    newsDetail(article))
                );
            },
          child: Container(
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
                                              child: Image.network(article.urlToImage!,
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
                                  child: Text(article.title!,
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
                                          child: Text(article.author!,
                                              style: TextStyle(color: Colors.white, fontSize: 10),),
                                      ),
                                      Padding(
                                          padding: const EdgeInsets.only(right: 8.0),
                                          child: Text(CardsandModules.formatDateTimesstring(article.publishedAt!),
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
          ),
        );
    }
}
