import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sql_test/widget/add_points.dart';

class Points extends StatefulWidget {
  const Points({
    super.key,
  });

  @override
  State<Points> createState() => _PointsState();
}

class _PointsState extends State<Points> {
  late int points = 0;
  @override
  void initState() {
    loadData();
    super.initState();
  }

  void loadData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      points = prefs.getInt('points') ?? 0;
    });
  }

  void calculate(int added) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      points = points + added;
      prefs.setInt('points', points);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 535,
        width: 350,
        child: ClipRRect(
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: Card(
              child: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  gradient: LinearGradient(
                    colors: [
                      Colors.amber,
                      Color.fromARGB(255, 205, 183, 117),
                      Color.fromARGB(255, 227, 211, 161),
                    ],
                    begin: Alignment.bottomRight,
                    end: Alignment.topLeft,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FaIcon(
                          FontAwesomeIcons.coins,
                          size: 40,
                          color: Color.fromARGB(255, 103, 99, 99),
                        ),
                        SizedBox(width: 20),
                        Text(
                          "Points",
                          style: TextStyle(
                            fontSize: 30,
                            color: Color.fromARGB(255, 103, 99, 99),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text.rich(
                        TextSpan(
                          text: 'You Have Got  ',
                          style: const TextStyle(
                              fontSize: 20,
                              color: Color.fromARGB(255, 103, 99, 99)),
                          children: <TextSpan>[
                            TextSpan(
                              text: points.toString(),
                              style: const TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const TextSpan(
                              text: '  Points.',
                              style: TextStyle(
                                color: Color.fromARGB(255, 103, 99, 99),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: () {
                            calculate(5);
                          },
                          child: const AddPoints(
                            added: 5,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            calculate(-5);
                          },
                          child: const AddPoints(
                            added: -5,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: () {
                            calculate(20);
                          },
                          child: const AddPoints(
                            added: 20,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            calculate(-20);
                          },
                          child: const AddPoints(
                            added: -20,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: () {
                            calculate(50);
                          },
                          child: const AddPoints(
                            added: 50,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            calculate(-50);
                          },
                          child: const AddPoints(
                            added: -50,
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Card(
                          color: Color.fromARGB(255, 103, 99, 99),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 20),
                            child: Text(
                              "Done",
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white),
                            ),
                          ),
                        )),
                    const Spacer(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
