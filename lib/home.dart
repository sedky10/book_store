import 'package:book_store/data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'database.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

List<Data> todoList = [];

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff3d81ae),
      appBar: AppBar(
        backgroundColor: const Color(0xff2b5d7e),
        elevation: 0,
        centerTitle: true,
        title: Text(
          'available books'.toUpperCase(),
          style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder<List<Data>>(
              future: Back.instance.getAllTodo(),
              builder: (BuildContext context, snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text(snapshot.error.toString()),
                  );
                }
                if (snapshot.hasData) {
                  todoList = snapshot.data!;
                }
                return ListView.builder(
                  itemCount: todoList.length,
                  itemBuilder: (context, index) {
                    Data Books = todoList[index];
                    return Container(
                      height: 180,
                      margin: const EdgeInsets.only(
                        top: 15,
                        right: 15,
                        left: 15,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xff19394c),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(left: 15.0),
                            padding: const EdgeInsets.all(4),
                            height: 150,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(
                                width: 2,
                                color: const Color(0xff3d81ae),
                              ),
                            ),
                            child: CachedNetworkImage(
                              fit: BoxFit.fill,
                              height: 50,
                              width: 120,
                              imageUrl: Books.url,
                              placeholder: (context, url) =>
                                  const CircularProgressIndicator(),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            ),
                          ),
                          Expanded(
                            child: ListTile(
                              title: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 5.0),
                                child: Text(
                                  Books.name,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 40,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              subtitle: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 5.0),
                                child: Text(
                                  Books.title,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25,
                                    color: Color(0xff3d81ae),
                                  ),
                                ),
                              ),
                              trailing: IconButton(
                                onPressed: () {
                                  if (Books.id != null) {
                                    Back.instance.deleteTodo(Books.id!);
                                  }
                                  setState(() {});
                                },
                                icon: const Icon(
                                  Icons.delete,
                                  size: 55,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xff19394c),
        onPressed: () {
          showModalBottomSheet(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20),
                  topLeft: Radius.circular(20),
                ),
              ),
              isScrollControlled: true,
              context: context,
              builder: (BuildContext context) {
                return const BottomSheet();
              });
        },
        child: const Icon(
          Icons.add,
          size: 50,
        ),
      ),
    );
  }
}

class BottomSheet extends StatefulWidget {
  const BottomSheet({Key? key}) : super(key: key);

  @override
  State<BottomSheet> createState() => _BottomSheetState();
}

class _BottomSheetState extends State<BottomSheet> {
  TextEditingController namecontroller = TextEditingController();
  TextEditingController Authocrcontroller = TextEditingController();
  TextEditingController Urlcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          color: Color(0xff2b5d7e),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: namecontroller,
              decoration: const InputDecoration(
                suffix: Icon(
                  Icons.book,
                  color: Color(0xff19394c),
                ),
                hintText: ' Book Name',
                hintStyle: TextStyle(
                  fontSize: 30,
                ),
              ),
              onChanged: (val) {
                setState(() {});
              },
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 10,
              ),
              child: TextFormField(
                controller: Authocrcontroller,
                decoration: const InputDecoration(
                  suffix: Icon(Icons.person,color: Color(0xff19394c)),
                  hintText: ' Book Author',
                  hintStyle: TextStyle(
                    fontSize: 30,
                  ),
                ),
                onChanged: (val) {
                  setState(() {});
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 10,
              ),
              child: TextFormField(
                controller: Urlcontroller,
                decoration: const InputDecoration(
                  suffix: Icon(Icons.image,color: Color(0xff19394c)),
                  hintText: ' Book Cover Url',
                  hintStyle: TextStyle(
                    fontSize: 30,
                  ),
                ),
                onChanged: (val) {
                  setState(() {});
                },
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
            color:const Color(0xff19394c),
              height: 50,
              width: 100,
              child: ElevatedButton(
               style: ElevatedButton.styleFrom(
                 primary:const Color(0xff19394c),
               ),
                onPressed: () {
                  Back.instance.insertTodo(
                    Data(
                      name: namecontroller.text,
                      title: Authocrcontroller.text,
                      url: Urlcontroller.text,
                    ),
                  );
                  setState(() {});
                  Navigator.pop(context);
                },
                child: const Text('ADD'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
