import 'package:flutter/material.dart';
import 'package:interviewapp/features/post/presentation/pages/posts.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('HomePage'),backgroundColor:Color(0xFF2193b0) ,),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            mainAxisSpacing: 5.0,
            crossAxisSpacing: 5.0,
            crossAxisCount: 2,
          ),
          itemCount: mainPageItems.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(0xFF2193b0),
                        Color(0xFF6dd5ed),
                      ])),
              child: GestureDetector(
                onTap: mainPageItems[index]['link'] == ''
                    ? () => showDialog(
                        context: context,
                        builder: (context) {
                          return const AlertDialog(
                            content: Text('Not Implemented yet'),
                          );
                        })
                    : () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => mainPageItems[index]['link'],
                        )),
                child: Card(
                    elevation: 0,
                    color: Colors.transparent,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(mainPageItems[index]['name'],
                              style: const TextStyle(
                                color: Color.fromARGB(255, 14, 23, 39),
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0,
                              )),
                          SizedBox(
                              height: MediaQuery.of(context).size.height * .03),
                          Icon(mainPageItems[index]['icon'], size: 30.0),
                        ])),
              ),
            );
          },
        ),
      ),
    );
  }

  final List<Map<String, dynamic>> mainPageItems = [
    {'name': 'Users', 'color': Colors.red, 'link': '', 'icon': Icons.person},
    {
      'name': 'Posts',
      'color': Colors.red,
      'link': const PostPage(),
      'icon': Icons.post_add
    },
    {'name': 'Albums', 'color': Colors.red, 'link': '', 'icon': Icons.album}
  ];
}
