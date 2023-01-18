import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/constants/api.dart';
import 'package:frontend/widgets/todo_container.dart';
import 'package:http/http.dart' as http;
import 'package:pie_chart/pie_chart.dart';

import '../models/todo.dart';
import 'package:frontend/widgets/app_bar.dart';
import 'package:frontend/utils/methods.dart';

HelperFunction helperFunction = HelperFunction();
class HommePage extends StatefulWidget {
  const HommePage({Key? key}) : super(key: key);

  @override
  State<HommePage> createState() => _HommePageState();
}

class _HommePageState extends State<HommePage> {
  // int done = 0;
  List<Todo> mytodos = [];
  // bool isLoading = true;

  void _showModel(){
    String title = "";
    String Author = "";
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context){
          return Container(
            height: MediaQuery.of(context).size.height / 2,
            child: Center(
              child: Column(
                children: [
                  Text('Add your Todo',
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold
                    ),),
                  SizedBox(height: 10,),
                  TextField(
                    // obscureText: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Title',
                    ),
                    onSubmitted: (value){
                      setState(() {
                        title = value;
                      });
                    },
                  ),
                  SizedBox(height: 10,),
                  TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Auteur',
                    ),
                    onSubmitted: (value){
                      setState(() {
                        Author = value;
                      });
                    },
                  ),
                  ElevatedButton(onPressed:() => helperFunction.postData(title: title, Author: Author ),
                      child: Text("Add"))

                ],
              ),
            ),
          );
        });
  }

  @override
  void initState() {
    helperFunction.fetchData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:customAppBar(),
      body: FutureBuilder(
        future: helperFunction.fetchData(),
        builder: (BuildContext context, AsyncSnapshot snapshot){
          Widget widget = Text('');
          if(snapshot.hasData){
            widget =  SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  // PieChart(dataMap: {
                  //   "Done": done.toDouble(),
                  //   "Incomplete" : (mytodos.length - done).toDouble()
                  // }),
                  // isLoading ? CircularProgressIndicator() :
                  Column(
                    children:
                    snapshot.data.map<Widget>((e) {
                      return TodoContainer(
                          id: e.id,onPress: () => helperFunction.delete_book(e.id.toString()),
                          title: e.title.toString(),
                          Author: e.Author.toString(),
                          disponible: e.disponible);
                    }).toList(),
                  ),
                ],
              ),

            );
          }else if(snapshot.connectionState == ConnectionState.waiting){
            widget = Center(
                child: CircularProgressIndicator());
          }else if(snapshot.hasError){
            widget = Center(child: Text('Something went wrong'));
          }
          return widget;
        },
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: (){
          _showModel();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
