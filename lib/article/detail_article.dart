import 'package:flutter/material.dart';

class DetailArticle extends StatelessWidget {
  const DetailArticle({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Field Area',
        home: DetailArticlePage(),
        
    );    
  }
}

class DetailArticlePage extends StatelessWidget {
  const DetailArticlePage ({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Row(
          children: [
            Icon(Icons.arrow_back, color: Colors.white,),
            SizedBox(width: 15),
            Text('Article',
            style: TextStyle(
              color: Colors.white
            ),
            ),
          ],
        ),
      ) ,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          color: Colors.black
        ),
        child: Column(
          children: [
            
          ],
        ),
      ),
    );
  }
}