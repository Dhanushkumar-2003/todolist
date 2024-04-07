// ignore_for_file: avoid_unnecessary_containers

import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:notes/database.dart';

// ignore: depend_on_referenced_packages

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController text = TextEditingController();

  TextEditingController trail = TextEditingController();
  DatabaseHelper dbHelper = DatabaseHelper();
  List stor = [];
  void getdata() {}
  void _refreshTaskList() async {
    List taskList = await dbHelper.getTasks();
    setState(() {
      stor = taskList;
    });
  }

  final List<Color> colo = const [
    Colors.red,
    // Color.fromARGB(255, 105, 162, 85),
    Colors.blue,
    Color.fromARGB(255, 172, 231, 174),
    Color.fromARGB(255, 217, 134, 128),
    Colors.yellow,
    Colors.deepOrange
  ];

  Color ran() {
    return colo[Random().nextInt(4)];
  }

  @override
  void initState() {
    _refreshTaskList();

    // TO
    //DO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          actions: const [],
          title: const Center(
              child: Text(
            'TO-DOlist',
            style: TextStyle(
                fontSize: 25,
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic),
          )),
          // ignore: deprecated_member_use
          // brightness: Brightness.dark,
          elevation: 0,
          backgroundColor: Colors.transparent),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          margin: EdgeInsets.only(top: 30, left: 5, right: 5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: const Text(
                        'Title:',
                        style: TextStyle(
                            fontSize: 20,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),

                    Container(
                      margin: EdgeInsets.only(left: 5, right: 5),
                      child: TextField(
                        decoration: const InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            borderSide:
                                BorderSide(color: Colors.black, width: 3.0),
                          ),
                          filled: true,
                          // fillColor: Colors.white,
                          border: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.black, width: 3),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          labelText: 'title',
                          hintText: 'Enter title',
                        ),
                        style: const TextStyle(fontSize: 15),
                        controller: text,
                      ),
                    ),

                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      child: const Text(
                        'Description:',
                        style: TextStyle(
                            fontSize: 20,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),

                    // width: 350,

                    Container(
                      margin: EdgeInsets.only(left: 5, right: 5),
                      child: TextFormField(
                        decoration: const InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            borderSide:
                                BorderSide(color: Colors.black, width: 3.0),
                          ),
                          focusColor: Colors.black,
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.black, width: 3),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          labelText: 'description',
                          hintText: 'Enter description',
                        ),
                        controller: trail,
                      ),
                    ),

                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
              Container(
                child: ElevatedButton(
                    onPressed: () {
                      if (text.text != '' && trail.text != '') {
                        print("Okkk");

                        var rng = Random().nextInt(200);

                        var ok = dbHelper.insertTask(
                            note(mm: text.text, id: rng, descrip: trail.text));
                        print(ok);
                        // var nn = _refreshTaskList();

                        text.clear();
                        trail.clear();
                      }
                    },
                    child: const Text("submit")),
              ),
              SizedBox(
                height: 400,
                child: stor.length == 0
                    ? Container(child: Text("no data found"))
                    : Container(
                        child: ListView.builder(
                            itemCount: stor.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Card(
                                color: ran(),
                                child: ListTile(
                                  title: Text("title:${stor[index].mm}"),
                                  subtitle: Text(
                                      "description:${stor[index].descrip}"),
                                  trailing: IconButton(
                                      onPressed: () async {
                                        await dbHelper
                                            .deletenot(stor[index].id);
                                        // print("del$del");
                                        // setState(() {});
                                        _refreshTaskList();
                                        print("DELETED ${stor[index].id}");

                                        // setState(() {});
                                      },
                                      icon: const Icon(Icons.delete,
                                          color: Colors.white)),
                                ),
                              );
                            })),
              )
            ],
          ),
        ),
      ),
    );
  }
}

//
