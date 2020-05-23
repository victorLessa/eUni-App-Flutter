import 'package:flutter/material.dart';

class CreateEvent extends StatefulWidget {
  @override
  _CreateEventState createState() => _CreateEventState();
}

class _CreateEventState extends State<CreateEvent> {
  var _loading = false;
  void initState() {
    super.initState();
  }

  var _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _localController = TextEditingController();
  final _dataController = TextEditingController();
  final _hourController = TextEditingController();

  Widget _input(controller, label, typeInput) {
    return TextFormField(
      controller: controller,
      cursorColor: Colors.black,
      keyboardType: typeInput,
      style: TextStyle(decorationColor: Colors.black, color: Colors.black),
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(color: Colors.black, width: 1.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(
            color: Colors.black,
            width: 1.0,
          ),
        ),
        labelText: label,
        labelStyle: TextStyle(color: Colors.black),
        contentPadding: EdgeInsets.only(left: 30.0),
      ),
      validator: (value) {
        if (value.trim().isEmpty) {
          return 'Insira um valor!';
        }
        return null;
      },
    );
  }

  _button() {
    return RaisedGradientButton(
      child: _loading
          ? SizedBox(
              child: CircularProgressIndicator(
                backgroundColor: Colors.transparent,
                strokeWidth: 2.0,
                valueColor: AlwaysStoppedAnimation(Colors.white),
              ),
              height: 20.0,
              width: 20.0,
            )
          : Text(
              'Cadastrar',
              style: TextStyle(color: Colors.white),
            ),
      gradient: LinearGradient(
        colors: <Color>[
          Color.fromRGBO(125, 0, 179, 1),
          Color.fromRGBO(179, 0, 255, 1)
        ],
      ),
      onPressed: () async {
        setState(() {
          _loading = true;
        });
        if (_formKey.currentState.validate()) {}
        setState(() {
          _loading = false;
        });
      },
    );
  }

  _form() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _input(_titleController, 'Titulo', TextInputType.text),
          SizedBox(
            height: 10.0,
          ),
          _input(_descriptionController, 'Descrição', TextInputType.text),
          SizedBox(
            height: 10.0,
          ),
          _input(_localController, 'Local', TextInputType.text),
          SizedBox(
            height: 10.0,
          ),
          _input(_dataController, 'Data', TextInputType.datetime),
          SizedBox(
            height: 10.0,
          ),
          _input(_hourController, 'Hora', TextInputType.text),
          SizedBox(
            height: 10.0,
          ),
          _button()
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(46, 13, 218, .5),
        title: Text('Criar Evento'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(padding: EdgeInsets.all(20.0), child: _form())
          ],
        ),
      ),
    );
  }
}

class RaisedGradientButton extends StatelessWidget {
  final Widget child;
  final Gradient gradient;
  final double width;
  final double height;
  final Function onPressed;

  const RaisedGradientButton({
    Key key,
    @required this.child,
    this.gradient,
    this.width = double.infinity,
    this.height = 50.0,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: 50.0,
      decoration: BoxDecoration(
          gradient: gradient,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey[500],
              offset: Offset(0.0, 1.5),
              blurRadius: 1.5,
            ),
          ]),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
            onTap: onPressed,
            child: Center(
              child: child,
            )),
      ),
    );
  }
}
