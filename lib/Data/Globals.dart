import 'package:flutter/material.dart';

class Globals {
  static const List<String> categories = [
    "Notes",
    "Todo",
    "Blogs",
    "Story",
    "Posts",
    "Instagram",
    "Facebook"
  ];
  static const List<int> colors = [
    0xff9DDCFF,
    0xffFFBA9D,
    0xffFFF59D,
    0xff9DDCFF,
    0xff1e3c72,
    0xffF29492,
    0xffff9068
  ];
}

class Note {
  final String title;
  final String content;

  const Note({required this.title, required this.content});
}
