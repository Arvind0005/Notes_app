import 'package:flutter/material.dart';

class CustomSearchBar extends StatelessWidget {
  final Function onSearch;

  const CustomSearchBar({Key? key, required this.onSearch}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 46.0, // Adjust height as needed
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              print("hello world");
            }, // Call the onSearch function
          ),
          Expanded(
            child: TextField(
              decoration: const InputDecoration(
                hintText: "Search...",
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
