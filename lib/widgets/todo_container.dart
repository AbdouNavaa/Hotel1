import 'package:flutter/material.dart';

import '../constants/colors.dart';
import 'package:frontend/utils/methods.dart';

HelperFunction helperFunction = HelperFunction();
class TodoContainer extends StatelessWidget {
  const TodoContainer({Key? key,
    required this.id, required this.title, required this.Author, required this.disponible, required this.onPress})
      : super(key: key);

  final int id;
  final String title;
  final String Author;
  final bool disponible;
  final Function onPress;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
        child: InkWell(
          onTap: (){
            showModalBottomSheet(
                context: context,
                builder: (BuildContext context){
                  return Container(
                    height: MediaQuery.of(context).size.height / 2,
                    child: Center(
                      child: Column(
                        children: [
                          Text('Update your Todo',
                            style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold
                            ),),
                          SizedBox(height: 10,),
                          TextFormField(
                            // obscureText: true,
                            initialValue: title,
                            style: TextStyle(fontSize: 23,
                                fontStyle: FontStyle.italic, fontWeight: FontWeight.bold, color: darkBlue),
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Title',
                            ),
                          ),
                          SizedBox(height: 10,),
                          TextFormField(
                            initialValue: Author,
                            style: TextStyle(fontSize: 23,
                                fontStyle: FontStyle.italic, fontWeight: FontWeight.bold,color: darkBlue),
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Auteur',
                            ),
                          ),
                          ElevatedButton(onPressed:() =>  helperFunction.update_book(id.toString()), child: Text("Update"))

                        ],
                      ),
                    ),
                  );
                });
          },
          child: Container(
            width: double.infinity,
            height: 120,
            decoration: BoxDecoration(
              color: disponible == true ? green : red,
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children:[
                    Text(title,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 22
                    ),),
                      IconButton(onPressed: () => onPress(), icon: Icon(Icons.delete_outline,color: Colors.white,size: 34,),)
                    ]
                  ),
                  SizedBox(height: 6,),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Text(Author,
                    style: TextStyle(
                      color: bg,
                      fontWeight: FontWeight.bold,
                      fontSize: 18
                    ),),
                  ),

                ],
              ),
            ),
          ),
        ));
  }
}
