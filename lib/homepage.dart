import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  String counter = "0";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //     appBar: AppBar(
      //   title: const Text('Tasabeeh'),
      //   centerTitle: true,
      // )
      body: Column(
        children: [
          Center(
            child: Container(
              width: 300,
              height: 75,
              margin: const EdgeInsets.only(top: 100),
              decoration: BoxDecoration(
                color: Colors.orangeAccent,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Center(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('ألا بذكر الله تطمئن القلوب'),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 100,
          ),
          Center(child: Text(counter)),
          const SizedBox(
            height: 15,
          ),
          Center(
            child: MaterialButton(
              color: Colors.orangeAccent,
              onPressed: () {},
              child: const Text('حفظ'),
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          MaterialButton(
            height: 200,
            minWidth: 200,
            shape: const CircleBorder(),
            color: Colors.orangeAccent,
            onPressed: () {
              setState(() {
                counter = (int.parse(counter) + 1).toString();
              });
            },
          )
        ],
      ),
    );
  }
}
