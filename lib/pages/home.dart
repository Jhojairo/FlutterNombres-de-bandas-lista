import 'dart:io';

import 'package:band_name_app/models/band.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Band> bands = [
    Band(id: '1', name: 'Mana', votes: 2),
    Band(id: '2', name: 'GunsAndRoses', votes: 4),
    Band(id: '3', name: 'Metalica', votes: 5),
    Band(id: '4', name: 'IronMaiden', votes: 9),
    Band(id: '5', name: 'Margt', votes: 3),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'BandNames',
          style: TextStyle(color: Colors.black87),
        ),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: ListView.builder(
          itemCount: bands.length,
          itemBuilder: (context, index) => _bandTitle(bands[index])),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        elevation: 1,
        onPressed: addnewband,
      ),
    );
  }

  Widget _bandTitle(Band band) {
    //Widget Dissmisable sirve para eliminar datos de una fila u columna
    return Dismissible(
      key: Key(band.id),
      onDismissed: (DismissDirection direction) {
        print(
            'direction : ${direction}'); // imprime la doreccion en la que se borran los datos
        print('id : ${band.id}'); //para saver que banda estoy borrando

        //llamar al borrado dede el server
      },
      background: Container(
          padding: EdgeInsets.only(left: 8.0),
          color: Colors.red,
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Eliminar Bnda',
              style: TextStyle(color: Colors.black),
            ),
          )),
      direction:
          DismissDirection.startToEnd, // direccion en la cual se va a borrar
      child: ListTile(
        leading: CircleAvatar(
          child: Text(band.name.substring(0, 2)),
          backgroundColor: Colors.blue[100],
        ),
        title: Text(band.name),
        trailing: Text(
          '${band.votes}',
          style: TextStyle(fontSize: 20),
        ),
        onTap: () {
          print(band.name);
        },
      ),
    );
  }

  addnewband() {
    /// para obteener el valor que se ingresa enel textfiel del show dialog.
    final textController = TextEditingController();
    if (Platform.isIOS) {
      return showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Add new band'),
              content: TextField(
                controller: textController,
              ),
              actions: [
                MaterialButton(
                  child: Text('Add'),
                  elevation: 5,
                  textColor: Colors.blue,
                  onPressed: () => addBandtoList(textController.text),
                )
              ],
            );
          });
    }
    showCupertinoDialog(
        context: context, //context contiene el arbol de widges para diidujarlos
        builder: (_) {
          return CupertinoAlertDialog(
            title: Text('new band name'),
            content: CupertinoTextField(controller: textController),
            actions: <Widget>[
              CupertinoDialogAction(
                isDefaultAction: true,
                isDestructiveAction: true,
                child: Text('Add'),
                onPressed: () => addBandtoList(textController.text),
              ),
              CupertinoDialogAction(
                isDefaultAction: true,
                child: Text('Dismis'),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          );
        });
  }

  void addBandtoList(String name) {
    print(name);
    if (name.length > 1) {
      this
          .bands
          .add(new Band(id: DateTime.now().toString(), name: name, votes: 0));
      setState(() {});
    }

    Navigator.of(context); //  para cerrar el show dialog
  }
}
