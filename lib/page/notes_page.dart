import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../note.dart';
import '../notes_data_base.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../widget/points.dart';
import '../page/edit_note_page.dart';
import '../page/note_detail_page.dart';
import '../widget/note_card_widget.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({Key? key}) : super(key: key);

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  late int days = 0;
  late int points = 0;

  @override
  void initState() {
    loadData();
    super.initState();
    refreshNotes();
  }

  void loadData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      days = prefs.getInt('number') ?? 0;
    });
  }

  late List<Note> notes;
  bool isLoading = false;

  @override
  void dispose() {
    NotesDatabase.instance.close();
    super.dispose();
  }

  Future refreshNotes() async {
    setState(() => isLoading = true);
    notes = await NotesDatabase.instance.readAllNotes();
    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/image1.jpg"),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Center(
              child: isLoading
                  ? const CircularProgressIndicator(
                      color: Colors.grey,
                      value: 20,
                    )
                  : notes.isEmpty
                      ? const Text(
                          'No Notes',
                          style: TextStyle(color: Colors.white, fontSize: 24),
                        )
                      : buildNotes(),
            ),
          ],
        ),
        appBar: AppBar(
          title: const Text(
            'Notes',
            style: TextStyle(
                fontSize: 24, color: Color.fromARGB(255, 248, 248, 248)),
          ),
          actions: [
            TextButton.icon(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return Points();
                    });
              },
              icon: const FaIcon(
                FontAwesomeIcons.coins,
                size: 20,
                color: Colors.amber,
              ),
              label: const Text(
                "Points",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.amber,
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              "${days.toString()} Days Streak",
              style: const TextStyle(fontSize: 17, color: Colors.orange),
            ),
            const SizedBox(
              width: 10,
            ),
            GestureDetector(
              onTap: () async {
                final SharedPreferences prefs =
                    await SharedPreferences.getInstance();

                setState(() {
                  days++;
                  prefs.setInt('number', days);
                });
              },
              onDoubleTap: () async {
                final SharedPreferences prefs =
                    await SharedPreferences.getInstance();

                setState(() {
                  days--;
                  prefs.setInt('number', days);
                });
              },
              child: const FaIcon(
                FontAwesomeIcons.fire,
                size: 35,
                color: Colors.red,
              ),
            ),
            const SizedBox(
              width: 20,
            ),
          ],
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Color.fromARGB(255, 213, 236, 5),
          child: const Icon(
            Icons.add,
            size: 40,
          ),
          onPressed: () async {
            await Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const AddEditNotePage()),
            );

            refreshNotes();
          },
        ),
      );

  Widget buildNotes() => SingleChildScrollView(
        child: StaggeredGrid.count(
          crossAxisCount: 2,
          mainAxisSpacing: 2,
          crossAxisSpacing: 2,
          children: List.generate(
            notes.length,
            (index) {
              final note = notes[index];
              return StaggeredGridTile.fit(
                crossAxisCellCount: 1,
                child: GestureDetector(
                  onTap: () async {
                    await Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => NoteDetailPage(noteId: note.id!),
                    ));

                    refreshNotes();
                  },
                  child: NoteCardWidget(note: note, index: index),
                ),
              );
            },
          ),
        ),
      );
}
