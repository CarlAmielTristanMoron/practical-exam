import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:written_exam/todo_model.dart';

class EditPage extends StatefulWidget {

  final dynamic information;

  const EditPage({
    required this.information,
    Key? key
  }) : super(key: key);

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {

  var jsonUrl = Uri.parse('https://jsonplaceholder.typicode.com/todos');

  TextEditingController titleController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  var id = '';

  @override
  void initState() {
    super.initState();
    titleController.text = widget.information['title'];
    id = widget.information['id'].toString();
  }

  editInformation() async {
    var editedTitle = titleController.text;
    var url = Uri.parse('$jsonUrl/$id');
    var data = json.encode({
      'title': editedTitle,
    });
    var response = await http.patch(url, body: data);
    print(response.statusCode);
    if (response.statusCode == 200) {
      print(response.body);
      print('Information Successfully Edited!');
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Page'),
      ),
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
          child: ListView(
            children:[
              TextFormField(
                controller: titleController,
                keyboardType: TextInputType.text,
                validator: (value) {
                  return value == null || value.isEmpty ? 'please enter title' : null;
                }
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                  var send = TodoModel(title: titleController.text);
                      Navigator.pop(context, send);
                  }else{
                    return;
                  }
                },
                child: const Text('Done')
              ),
            ]
          ),
        ),
      ),
    );
  }
}
