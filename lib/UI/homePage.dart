import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sample_project/Data/DBhelper.dart';
import 'package:sample_project/Data/Globals.dart';
import 'package:sample_project/UI/Notes_page.dart';
import 'package:sample_project/UI/searchBar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final DatabaseHelper _databaseHelper =
      DatabaseHelper(); // Create DatabaseHelper instance
  List<Map<String, dynamic>> _notes = []; // List to store retrieved notes

  Future<void> _getNotes() async {
    final notes = await _databaseHelper.getNotes();
    setState(() {
      _notes = notes;
    });
  }

  @override
  void initState() {
    super.initState();
    _getNotes(); // Call _getNotes on initialization to fetch notes
  }

  @override
  Widget build(BuildContext context) {
    print("hvgvvfvfjbbhbhb");
    print(_notes);
    //  notes.insert(notes.length, Note(title: "Blog", content: "content"));
    final TextEditingController _controller =
        TextEditingController(text: 'Initial Text');
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const NotesPage(
                      title: "",
                      index: -1,
                      content: "",
                    )),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: ListView(
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "The Notes",
              style: TextStyle(fontFamily: "rimouskisb_regular", fontSize: 28),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomSearchBar(
              onSearch: (String query) {
                print("Search query: $query");
              },
            ),
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
          GridView.count(
            shrinkWrap: true,
            physics: ScrollPhysics(),
            crossAxisCount: 2, // Two columnsS
            childAspectRatio: 0.8, // Adjust aspect ratio for card size
            children: _notes
                .asMap()
                .entries
                .map((entry) => _buildNoteCard(entry.key, entry.value, context))
                .toList(),
          )
        ],
      ),
    );
  }
}

Widget _buildNoteCard(
    int index, Map<String, dynamic> map, BuildContext context) {
  return GestureDetector(
    onTap: () {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => NotesPage(
                    title: map['title'],
                    index: map['id'],
                    content: map['content'],
                  )));
    },
    child: Container(
      height: 50,
      margin: const EdgeInsets.all(8.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Color(Globals.colors[index % 7]),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            map['title'],
            style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8.0), // Add spacing between title and content
          Text(
            map['content'],
            maxLines: 3,
          ),
        ],
      ),
    ),
  );
}
