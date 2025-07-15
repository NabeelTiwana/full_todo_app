//todoitem
import 'package:flutter/material.dart';
import 'package:todo_app/constants/color.dart';
import 'package:todo_app/constants/db_handler.dart';

class TodoItem extends StatefulWidget {
  final data;
  final deleteTask;

  const TodoItem({super.key, required this.data, required this.deleteTask});

  @override
  State<TodoItem> createState() => _TodoItemState();
}

class _TodoItemState extends State<TodoItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(color: textColor, blurRadius: 2, offset: Offset(1, 1)),
        ],
        borderRadius: BorderRadiusGeometry.circular(20),
        color: tdyellow,
      ),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        onTap: () {
          if (widget.data.checkbox == 0) {
            widget.data.checkbox = 1;
          } else {
            widget.data.checkbox = 0;
          }
          setState(() {});
        },
        title: Text(
          '${widget.data.title}',
          style: TextStyle(
            decoration: widget.data.checkbox == 0
                ? TextDecoration.none
                : TextDecoration.lineThrough,
            fontSize: 16,
            color: textColor,
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Text(
          '${widget.data.description}',
          style: TextStyle(
            decoration: widget.data.checkbox == 0
                ? TextDecoration.none
                : TextDecoration.lineThrough,
            fontStyle: FontStyle.italic,
            color: textColor,
          ),
        ),
        leading: Icon(
          widget.data.checkbox == 0
              ? Icons.check_box_outline_blank
              : Icons.check_box,
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 35,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadiusGeometry.circular(20),
              ),
              child: IconButton(
                onPressed: () {
                  showAlertBox();
                },
                icon: Icon(Icons.edit, size: 20, color: tdyellow),
              ),
            ),
            SizedBox(width: 10),
            Container(
              width: 40,
              height: 35,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadiusGeometry.circular(20),
              ),
              child: IconButton(
                onPressed: () {
                  int id=widget.data.id;
                  widget.deleteTask(id);
                },
                icon: Icon(Icons.delete, size: 20, color: textColor),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showAlertBox() {
    showDialog(
      useSafeArea: true,
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: tdyellow.withAlpha(200),
          title: Center(
            child: Text(
              'Edit',
              style: TextStyle(color: textColor, fontWeight: FontWeight.bold),
            ),
          ),
          content: Container(
            margin: EdgeInsets.only(top: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                //title Text field
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadiusGeometry.circular(20),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 1,
                        spreadRadius: 0,
                        offset: Offset(1, 1),
                      ),
                    ],
                  ),
                  child: TextFormField(
                    style: TextStyle(color: tdyellow),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(10),
                      hintText: 'Title',
                      hintStyle: TextStyle(color: tdyellow),
                      border: InputBorder.none,
                      prefixIcon: Icon(Icons.title, size: 20, color: tdyellow),
                      prefixIconConstraints: BoxConstraints(
                        maxHeight: 30,
                        minWidth: 25,
                      ),
                    ),
                  ),
                ),
                //description text filed
                SizedBox(height: 10),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadiusGeometry.circular(20),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 1,
                        spreadRadius: 0,
                        offset: Offset(1, 1),
                      ),
                    ],
                  ),
                  child: TextFormField(
                    maxLines: 4,
                    style: TextStyle(color: tdyellow),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(10),
                      hintText: 'Description',
                      hintStyle: TextStyle(color: tdyellow, height: 4),
                      border: InputBorder.none,
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
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel', style: TextStyle(color: Colors.red)),
            ),
            TextButton(
              onPressed: () {},
              child: Text('Save', style: TextStyle(color: Colors.black)),
            ),
          ],
        );
      },
    );
  }
}
