import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:written_exam/edit_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List items = <dynamic>[];

  @override
  void initState() {
    getAllTodo();
    super.initState();
  }

  getAllTodo() async {
    var jsonUrl = Uri.parse('https://jsonplaceholder.typicode.com/todos');
    var response = await http.get(jsonUrl);

    if (response.statusCode == 200) {
      setState(() {
        items = convert.jsonDecode(response.body) as List<dynamic>;
      });
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index){
          return Padding(
            padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
            child: Card(
              child: ListTile(
                title: Text(items[index]['title']),
                trailing: IconButton(
                  icon: const Icon(Icons.mode_edit_sharp),
                  color: Colors.black,
                  onPressed: () async{
                     var receive = await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EditPage(
                                information: items[index]
                            )
                        )
                    );
                     print(receive);
                     if (receive != null){
                       ScaffoldMessenger.of(context).showSnackBar(
                         const SnackBar(
                           backgroundColor: Colors.greenAccent,
                           content: Text(
                             'Successfully Edited'
                           )
                         )
                       );
                     }else{
                       ScaffoldMessenger.of(context).showSnackBar(
                         const SnackBar(
                           backgroundColor: Colors.greenAccent,
                           content: Text(
                             'Still the same'
                           )
                         )
                       );
                     }
                  },
                ),
              ),
            ),
          );
        }
      ),
    );
  }
}
