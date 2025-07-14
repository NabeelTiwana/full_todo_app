import 'package:flutter/material.dart';
import 'package:todo_app/constants/color.dart';

class AddTask extends StatefulWidget {
  const AddTask({super.key});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  final titleController = TextEditingController();
  final descController = TextEditingController();
  final titleFocusNode=FocusNode();
  final  descFocusNode=FocusNode();
  final _formkey= GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(elevation: 0),
      body: GestureDetector(
        onTap: (){
          titleFocusNode.unfocus();
          descFocusNode.unfocus();
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              //Container Add task
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.246,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [tdyellow, Colors.transparent],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(150),
                    bottomLeft: Radius.circular(150),
                  ),
                ),
                child: Center(
                  child: Text(
                    'Add Task',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 80),
              //TextField Container
              Form(
                key:_formkey ,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    children: [
                      //Title TextField
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 0,
                              spreadRadius: 10,
                              color: tdyellow,
                            ),
                          ],
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        //title Textfield
                        child: TextFormField(
                          validator: (value){
                            if(value!.isEmpty){
                              return'Please enter some text';
                            }return null;
                          },
                          focusNode: titleFocusNode,
                          controller: titleController,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(10),
                            border: InputBorder.none,
                            hintText: 'Title',
                            hintStyle: TextStyle(color: tdyellow),
                            prefixIcon: Icon(
                              Icons.title,
                              size: 20,
                              color: tdyellow,
                            ),
                            prefixIconConstraints: BoxConstraints(
                              maxHeight: 30,
                              minWidth: 25,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 30),
                      //description TextField
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 0,
                              spreadRadius: 10,
                              color: tdyellow,
                            ),
                          ],
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        //dec Textfield
                        child: TextFormField(
                          validator: (value){
                            if(value!.isEmpty){
                              return 'Please enter some text';
                            }return null;
                          },
                          focusNode: descFocusNode,
                          controller: descController,
                          maxLines: 4,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(10),
                            border: InputBorder.none,
                            hintText: 'Description',
                            hintStyle: TextStyle(color: tdyellow, height: 4),
                            prefixIcon: Icon(
                              Icons.description,
                              size: 20,
                              color: tdyellow,
                            ),
                            prefixIconConstraints: BoxConstraints(
                              maxHeight: 30,
                              minWidth: 25,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 50),
              ///Add Button
              Container(
               width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 2,
                    padding: EdgeInsets.symmetric(vertical: 15,),
                    shadowColor: textColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadiusGeometry.circular(20),
                    ),
                  ),
                  onPressed: () {
                    if(_formkey.currentState!.validate()){
                     Navigator.pop(context);
                    }
                  },
                  child: Text(
                    'Add',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
