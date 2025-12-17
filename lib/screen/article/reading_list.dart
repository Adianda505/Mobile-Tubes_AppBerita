import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';


class ReadingList extends StatelessWidget {
  const ReadingList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 0, 0, 0),
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white
        ),

        title: const Text('Reading List',
        style: TextStyle(color: Color.fromARGB(255, 255, 255, 255),),
        
        ),
        backgroundColor: Color.fromARGB(255, 0, 0, 0),
      ),
      body: Column(

      )
    );
  }
}
