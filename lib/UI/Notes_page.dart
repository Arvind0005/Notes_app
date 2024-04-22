import 'package:flutter/material.dart';
import 'package:sample_project/Data/DBhelper.dart';
import 'package:sample_project/Data/Globals.dart';
import 'package:sample_project/UI/homePage.dart';
import 'package:sqflite/sqflite.dart';

class NotesPage extends StatefulWidget {
  final int index;
  final String title;
  final String content;

  const NotesPage({
    Key? key,
    required this.index,
    required this.title,
    required this.content,
  }) : super(key: key);

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  TextEditingController _Titlecontroller = TextEditingController();
  TextEditingController _Contentcontroller = TextEditingController();
  final DatabaseHelper _databaseHelper =
      DatabaseHelper(); // Create DatabaseHelper instance

  Future<void> _saveNote() async {
    if (widget.index == -1) {
      final title = _Titlecontroller.text;
      final tag = "Notes";
      final content = _Contentcontroller.text;
      await _databaseHelper.insertNote(title, tag, content);
      // Clear text fields after saving
      _Titlecontroller.clear();
      _Contentcontroller.clear();
      print("Note saved successfully!");
    } else {
      final title = _Titlecontroller.text;
      final tag = "Notes";
      final content = _Contentcontroller.text;
      await _databaseHelper.updateNote(widget.index, title, tag, content);
      // Clear text fields after saving
      _Titlecontroller.clear();
      _Contentcontroller.clear();
      print("Note saved successfully!");
    }
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const HomePage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    _Contentcontroller = TextEditingController(
        text: widget.content == "" ? null : widget.content.toString());
    _Titlecontroller = TextEditingController(
        text: widget.title == "" ? null : widget.title.toString());
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // Handle save button press (logic to save note)
          print("Save note");
          await _saveNote();
          // Add your logic to save the note content (titles and content from TextFields)
        },
        child: const Icon(Icons.save),
      ),
      backgroundColor: Color(0xffFDF3BF),
      body: ListView(
        children: [
          Row(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const HomePage()),
                  );
                },
                icon: Icon(Icons.arrow_back),
              ),
              Spacer(),
              Center(
                  child: widget.title == ""
                      ? Text(
                          "Add Note",
                          style: TextStyle(
                              fontFamily: "rimouskisb_regular", fontSize: 20),
                        )
                      : Text(
                          widget.title,
                          style: TextStyle(
                              fontFamily: "rimouskisb_regular", fontSize: 20),
                        )),
              Spacer(),
              IconButton(
                  onPressed: () async {
                    if (widget.index != -1)
                      await _databaseHelper.deleteNote(widget.index);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const HomePage()),
                    );
                  },
                  icon: widget.index != -1
                      ? Icon(Icons.delete)
                      : Icon(Icons.verified_user)),
            ],
          ),
          Row(
            children: [
              Spacer(),
              Container(
                width: width,
                child: TextField(
                    textAlign: TextAlign.center,
                    controller: _Titlecontroller,
                    style: const TextStyle(
                        color: Colors.black,
                        fontFamily: "rimouskisb_regular",
                        fontSize: 28),
                    decoration: InputDecoration(
                      hintText: "Add Title",
                      hintStyle: TextStyle(
                          color: Colors.grey,
                          fontFamily: "rimouskisb_regular",
                          fontSize: 28),
                      border: InputBorder.none,
                    )),
              ),
              Spacer()
            ],
          ),
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 30.0, // Adjust height as needed
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: Globals.categories.length,
                  itemBuilder: (context, index) {
                    final category = Globals.categories[index];
                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10.0),
                      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Center(
                        child: Text(
                          Globals.categories[index],
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16.0,
                              fontFamily: "rimouskisb_regular"),
                        ),
                      ),
                    );
                  },
                ),
              )),
          Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10.0),
            child: Container(
              height: 1,
              color: Colors.grey,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: width,
              child: TextField(
                  maxLines: null,
                  controller: _Contentcontroller,
                  textAlign: TextAlign.left,
                  style:
                      TextStyle(fontFamily: "rimouskisb_regular", fontSize: 18),
                  decoration: InputDecoration(
                    hintText: "Add your notes here..",
                    hintStyle: TextStyle(
                        color: Colors.grey,
                        fontFamily: "rimouskisb_regular",
                        fontSize: 18),
                    border: InputBorder.none,
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
