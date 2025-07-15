//home
import 'package:flutter/material.dart';
import 'package:todo_app/Widget/todo_items.dart';
import 'package:todo_app/constants/color.dart';
import 'package:todo_app/model/todo_model.dart';
import 'package:todo_app/screens/add_task.dart';

import '../constants/db_handler.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final searchController = TextEditingController();
  final searchFocusNode = FocusNode();


  @override
  Widget build(BuildContext context) {
    final data = DBHandler().read();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: buildAppBar(),
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.26,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.white, tdyellow.withAlpha(101)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              boxShadow: [
                BoxShadow(color: tdyellow, blurRadius: 5, spreadRadius: 2),
              ],
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(20),
                bottomLeft: Radius.circular(20),
              ),
            ),
          ),
          Column(
            children: [
              //Search Filed
              searchBar(),
              //Your task Text
              Container(
                margin: EdgeInsets.only(top: 40, bottom: 10),
                child: Text(
                  'Your Task',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                    shadows: [
                      Shadow(
                        color: tdyellow,
                        blurRadius: 5,
                        offset: Offset(1, 1),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: FutureBuilder(
                  future: data,
                  builder: (context, AsyncSnapshot<List<TodoModel>> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }

                    if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    }

                    if (snapshot.hasData && snapshot.data != null) {
                      print(snapshot.data!);
                      final tileData = snapshot.data!;
                      return ListView.builder(
                        padding: EdgeInsets.symmetric(horizontal: 5,vertical: 60),
                        itemCount: tileData.length,
                        itemBuilder: (context, index) {
                          return TodoItem(data: tileData[index],deleteTask:deleteTask,);
                        },
                      );
                    } else {
                      return Center(child: Text('No Data'));
                    }
                  },

                ),
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddTask()),
          );
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        elevation: 5,
        backgroundColor: Colors.white,
        child: Text(
          '+',
          style: TextStyle(
            fontSize: 20,
            color: textColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Container searchBar() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      margin: EdgeInsets.only(top: 30, left: 15, right: 15),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            blurRadius: 1,
            spreadRadius: 0,
            offset: Offset(1, 1),
            color: textColor,
          ),
        ],
        color: Colors.white,
        borderRadius: BorderRadiusGeometry.circular(20),
      ),

      child: TextFormField(
        controller: searchController,
        focusNode: searchFocusNode,
        onChanged: (value) {},
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(0),
          prefixIcon: Icon(Icons.search, size: 20, color: tdyellow),
          prefixIconConstraints: BoxConstraints(minWidth: 25, maxHeight: 25),
          border: InputBorder.none,
          hintText: 'Search',
          hintStyle: TextStyle(color: tdyellow),
        ),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(Icons.menu, size: 30, color: tdyellow),
          SizedBox(
            width: 40,
            height: 40,
            child: CircleAvatar(
              backgroundImage: AssetImage('assets/images/avatar.png'),
            ),
          ),
        ],
      ),
    );
  }
  deleteTask(int id)async{
    DBHandler().delete(id);
    setState(() {

    });
  }
}
