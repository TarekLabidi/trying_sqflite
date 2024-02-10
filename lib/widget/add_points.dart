import 'package:flutter/material.dart';

class AddPoints extends StatefulWidget {
  final int added;

  const AddPoints({
    Key? key,
    required this.added,
  }) : super(key: key);

  @override
  State<AddPoints> createState() => _AddPointsState();
}

class _AddPointsState extends State<AddPoints> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: widget.added > 0 ? Colors.green[400] : Colors.red[400],
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15),
        child: Text(
          widget.added > 0
              ? "Add ${widget.added.toString()} +"
              : "Remove ${widget.added.toString()}",
          style: const TextStyle(fontSize: 16, color: Colors.white),
        ),
      ),
    );
  }
}
