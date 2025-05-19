import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  int index = 2;
  bool status = false;

  Future<void> saveStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool("status", status);
  }

  Future<bool> getStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool("status") ?? false;
  }

  @override
  void initState() {
    super.initState();
    getStatus().then((value) {
      setState(() {
        status = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
            currentIndex: index,
            unselectedFontSize: 15,
            selectedItemColor: Colors.orange,
            selectedFontSize: 17,
            iconSize: 27,
            selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
            onTap: (value) {
              setState(() {
                index = value;
                if (value == 0) {
                  Navigator.pushNamed(context, "home");
                }
              });
            },
            items: [
              const BottomNavigationBarItem(
                  icon: Icon(Icons.home), label: 'Home'),
              BottomNavigationBarItem(
                  icon: Padding(
                    padding: const EdgeInsets.only(top: 13, bottom: 4),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          index = 1;
                        });
                        Navigator.pushNamed(context, "azkar");
                      },
                      child: Container(
                        width: 80,
                        height: 40,
                        decoration: BoxDecoration(
                          boxShadow: const [
                            BoxShadow(
                                color: Colors.black,
                                blurRadius: 1.3,
                                offset: Offset(0, 2),
                                spreadRadius: -0.10)
                          ],
                          color: index == 1 ? Colors.orange : Colors.grey[700],
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Center(
                            child: Text(
                          "Azkar",
                          style: TextStyle(
                            fontWeight: index == 1
                                ? FontWeight.bold
                                : FontWeight.normal,
                            color: index == 1 ? Colors.grey[700] : Colors.white,
                            fontSize: index == 1 ? 15 : 13,
                          ),
                        )),
                      ),
                    ),
                  ),
                  label: ''),
              const BottomNavigationBarItem(
                  icon: Icon(Icons.settings), label: 'settings'),
            ]),
        body: Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(color: Colors.grey[800]),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 100,
                ),
                Card(
                  elevation: 10,
                  shadowColor: Colors.orange[900],
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                    trailing: Switch(
                        activeColor: Colors.orange,
                        activeTrackColor: Colors.grey[700],
                        value: status,
                        onChanged: (value) {
                          setState(() {
                            status = value;
                            saveStatus();
                          });
                        }),
                    onTap: () {
                      setState(() {
                        status = !status;
                        saveStatus();
                      });
                    },
                    title: Text(
                      "Tap the screen\nto increase the count.",
                      style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[800]),
                    ),
                  ),
                ),
                Card(
                  elevation: 10.0,
                  shadowColor: Colors.orange[900],
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                    onTap: () {
                      Navigator.pushNamed(context, "about");
                    },
                    title: Text(
                      "About us",
                      style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[800]),
                    ),
                  ),
                ),
                Card(
                  elevation: 10.0,
                  shadowColor: Colors.orange[900],
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                    onTap: () {
                      Navigator.pushNamed(context, "support");
                    },
                    title: Text(
                      "Support us",
                      style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[800]),
                    ),
                  ),
                ),
              ],
            )));
  }
}
