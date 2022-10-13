import 'package:flutter/cupertino.dart';

class Note extends StatefulWidget {
  const Note({Key? key}) : super(key: key);

  @override
  State<Note> createState() => _NoteState();
}

class _NoteState extends State<Note> {
  @override
  Widget build(BuildContext context) {
    return  Container(
      height: 100,
      margin: const EdgeInsets.only(
        top: 20,
        right: 20,
        left: 20,
      ),
      padding: const EdgeInsets.all(1),
      decoration: BoxDecoration(
        color: Colors.amberAccent,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Center(
        child: ListTile(


          title: Text(
            Books.name,
            style: Theme.of(context).textTheme.headline4,
          ),
          subtitle: Text(
            Books.title,
            style: Theme.of(context).textTheme.headline6,
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
              size: 30,
            ),
          ),
        ),
      ),
    );
  }
}
