import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/constants/api.dart';
import 'package:frontend/widgets/todo_container.dart';
import 'package:http/http.dart' as http;
import 'package:pie_chart/pie_chart.dart';

import '../models/todo.dart';
import 'package:frontend/widgets/app_bar.dart';
class HelperFunction{
  Future<List<dynamic>> fetchData() async {
    List<Todo> mytodos = [];
    try{
      http.Response response = await http.get(Uri.parse(api));
      var data =  json.decode(response.body);
      data.forEach((todo) {
        Todo t = Todo(id: todo['id'],
            title: todo['title'],
            Author: todo['Author'],
            disponible: todo['disponible'],
            date: todo['date']);

        mytodos.add(t);
      });
      print(mytodos.length);

    }catch(e){ print('error is $e');}
      return mytodos;
  }

  Future<void> postData({String title = "", String Author = ""})async {
    try{
      http.Response response = await http.post(Uri.parse(api),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(
              <String, dynamic>{
                'title': title,
                'Author': Author,
                'disponible': false,
              }
          ));
      if(response.statusCode == 201){
        fetchData();
      }else{print("Something went wrong");}
    }catch(e){print('error is $e');}
  }

  Future<void> delete_book(String id) async{
    try{
      http.Response response = await http.delete(Uri.parse(api + "/" + id));
      fetchData();
    }catch(e){print(e);}
  }

  Future<void> update_book(String id) async {
    try{
    final response = await http.put(Uri.parse(api + "/" + id));

    if (response.statusCode == 201) {
      // La mise à jour a réussi
      fetchData();
    } else {
      throw Exception('Failed to update user');
    }
    fetchData();
    }catch(e){print(e);}
  }

}