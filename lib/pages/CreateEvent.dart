import 'package:flutter/material.dart';

class CreateEvent extends StatefulWidget {
  @override
  _CreateEventState createState() => _CreateEventState();
}

class _CreateEventState extends State<CreateEvent> {
  var _formKey;
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  Widget _input(controller, label) {
    return TextFormField(
      controller: controller,
      cursorColor: Colors.white,
      style: TextStyle(decorationColor: Colors.white, color: Colors.white),
      decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide: BorderSide(color: Colors.white, width: 1.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide: BorderSide(
              color: Colors.white,
              width: 1.0,
            ),
          ),
          labelText: label,
          labelStyle: TextStyle(color: Colors.white),
          contentPadding: EdgeInsets.only(left: 30.0)),
      validator: (value) {
        if (value.trim().isEmpty) {
          return 'Insira um valor!';
        }
        return null;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF102733),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(37, 116, 169, .5),
        title: Text('Criar Evento'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(20.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    _input(_titleController, 'Titulo'),
                    SizedBox(
                      height: 10.0,
                    ),
                    _input(_descriptionController, 'Descrição'),
                    SizedBox(
                      height: 10.0,
                    ),
                    _input(_descriptionController, 'Local'),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
