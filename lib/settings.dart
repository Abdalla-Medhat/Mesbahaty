import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasabeeh/themes.dart';

class Settings extends StatefulWidget {
  const Settings({super.key, this.onThemeChanged});
  final void Function(ThemeData)? onThemeChanged;
  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  int index = 2;
  bool status = false;
  late SharedPreferences prefs;
  initialPrefs() async {
    prefs = await SharedPreferences.getInstance();
  }

  setTheme(String val) {
    prefs.setString("theme", val);
  }

  Future<void> saveStatus() async {
    await prefs.setBool("status", status);
  }

  Future<bool> getStatus() async {
    return prefs.getBool("status") ?? false;
  }

  @override
  void initState() {
    super.initState();
    initialPrefs().then((_) {
      getStatus().then((value) {
        setState(() {
          status = value;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Orientation orientation = MediaQuery.of(context).orientation;
    return Scaffold(
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).colorScheme.secondary,
                blurRadius: 7,
                spreadRadius: 0.5,
              ),
              BoxShadow(
                color: Theme.of(context).colorScheme.secondary,
                blurRadius: 15,
                spreadRadius: 2,
              )
            ],
          ),
          child: BottomNavigationBar(
              currentIndex: index,
              unselectedFontSize: 15,
              backgroundColor: Theme.of(context).colorScheme.surface,
              selectedItemColor: Theme.of(context).colorScheme.primary,
              unselectedItemColor:
                  Theme.of(context).colorScheme.onSurface.withAlpha(200),
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
                            boxShadow: [
                              BoxShadow(
                                  color:
                                      Theme.of(context).scaffoldBackgroundColor,
                                  blurRadius: 1.3,
                                  offset: const Offset(0, 2),
                                  spreadRadius: -0.10)
                            ],
                            color: Theme.of(context)
                                .colorScheme
                                .onSurface
                                .withAlpha(200),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Center(
                              child: Text(
                            "Azkar",
                            style: TextStyle(
                              fontWeight: index == 1
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                              color: Colors.white,
                              fontSize: 13,
                            ),
                          )),
                        ),
                      ),
                    ),
                    label: ''),
                const BottomNavigationBarItem(
                    icon: Icon(Icons.settings), label: 'settings'),
              ]),
        ),
        body: orientation == Orientation.portrait
            ? Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.09,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Theme.of(context)
                                .colorScheme
                                .primary
                                .withAlpha(200),
                            blurRadius: 7,
                            spreadRadius: -10,
                            offset: const Offset(0, 5),
                          ),
                          BoxShadow(
                            color: Theme.of(context)
                                .colorScheme
                                .primary
                                .withAlpha(128),
                            blurRadius: 15,
                            spreadRadius: -10,
                            offset: const Offset(0, 5),
                          ),
                          BoxShadow(
                            color: Theme.of(context)
                                .colorScheme
                                .primary
                                .withAlpha(76),
                            blurRadius: 25,
                            spreadRadius: -10,
                            // offset: const Offset(0, 5),
                          ),
                        ]),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Theme.of(context)
                                  .colorScheme
                                  .primary
                                  .withAlpha(200),
                              blurRadius: 7,
                              spreadRadius: -10,
                              offset: const Offset(0, 5),
                            ),
                            BoxShadow(
                              color: Theme.of(context)
                                  .colorScheme
                                  .primary
                                  .withAlpha(128),
                              blurRadius: 15,
                              spreadRadius: -10,
                              offset: const Offset(0, 5),
                            ),
                            BoxShadow(
                              color: Theme.of(context)
                                  .colorScheme
                                  .primary
                                  .withAlpha(76),
                              blurRadius: 25,
                              spreadRadius: -10,
                            ),
                          ]),
                      child: Card(
                        color: Theme.of(context).colorScheme.primaryContainer,
                        elevation: 15,
                        shadowColor: Theme.of(context).colorScheme.primary,
                        margin: const EdgeInsets.all(10),
                        child: ListTile(
                          trailing: Switch(
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
                              color: Theme.of(context)
                                  .colorScheme
                                  .onPrimaryContainer,
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Theme.of(context)
                                .colorScheme
                                .primary
                                .withAlpha(200),
                            blurRadius: 7,
                            spreadRadius: -10,
                            offset: const Offset(0, 5),
                          ),
                          BoxShadow(
                            color: Theme.of(context)
                                .colorScheme
                                .primary
                                .withAlpha(128),
                            blurRadius: 15,
                            spreadRadius: -10,
                            offset: const Offset(0, 5),
                          ),
                          BoxShadow(
                            color: Theme.of(context)
                                .colorScheme
                                .primary
                                .withAlpha(76),
                            blurRadius: 25,
                            spreadRadius: -10,
                          ),
                        ]),
                    child: Card(
                      color: Theme.of(context).colorScheme.primaryContainer,
                      elevation: 10.0,
                      shadowColor: Theme.of(context).colorScheme.primary,
                      margin: const EdgeInsets.all(10),
                      child: Row(
                        children: [
                          Expanded(
                            child: ListTile(
                              title: Text(
                                "Choose theme",
                                style: TextStyle(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onPrimaryContainer,
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 30.0),
                            child: Row(
                              children: [
                                //Green Theme Circle
                                GestureDetector(
                                  onTap: () {
                                    widget
                                        .onThemeChanged!(AppThemes.greenTheme);
                                    setTheme("green");
                                  },
                                  child: Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.08,
                                    height: MediaQuery.of(context).size.height *
                                        0.08,
                                    decoration: const BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                            color: Color(0XFF101827),
                                            spreadRadius: 3)
                                      ],
                                      shape: BoxShape.circle,
                                      color: Colors.green,
                                    ),
                                  ),
                                ),

                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.05,
                                ),
                                //Golden Theme Circle
                                GestureDetector(
                                  onTap: () {
                                    widget
                                        .onThemeChanged!(AppThemes.goldenTheme);
                                    setTheme("golden");
                                  },
                                  child: Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.08,
                                    height: MediaQuery.of(context).size.height *
                                        0.08,
                                    decoration: const BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                            color: Color(0XFF101827),
                                            spreadRadius: 3)
                                      ],
                                      shape: BoxShape.circle,
                                      color: Color(0xffF4A300),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Theme.of(context)
                                .colorScheme
                                .primary
                                .withAlpha(200),
                            blurRadius: 7,
                            spreadRadius: -10,
                            offset: const Offset(0, 5),
                          ),
                          BoxShadow(
                            color: Theme.of(context)
                                .colorScheme
                                .primary
                                .withAlpha(128),
                            blurRadius: 15,
                            spreadRadius: -10,
                            offset: const Offset(0, 5),
                          ),
                          BoxShadow(
                            color: Theme.of(context)
                                .colorScheme
                                .primary
                                .withAlpha(76),
                            blurRadius: 25,
                            spreadRadius: -10,
                          ),
                        ]),
                    child: Card(
                      color: Theme.of(context).colorScheme.primaryContainer,
                      elevation: 10.0,
                      shadowColor: Theme.of(context).colorScheme.primary,
                      margin: const EdgeInsets.all(10),
                      child: ListTile(
                        onTap: () {
                          Navigator.pushNamed(context, "about");
                        },
                        title: Text(
                          "About us",
                          style: TextStyle(
                            color: Theme.of(context)
                                .colorScheme
                                .onPrimaryContainer,
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Theme.of(context)
                                .colorScheme
                                .primary
                                .withAlpha(200),
                            blurRadius: 7,
                            spreadRadius: -10,
                            offset: const Offset(0, 5),
                          ),
                          BoxShadow(
                            color: Theme.of(context)
                                .colorScheme
                                .primary
                                .withAlpha(128),
                            blurRadius: 15,
                            spreadRadius: -10,
                            offset: const Offset(0, 5),
                          ),
                          BoxShadow(
                            color: Theme.of(context)
                                .colorScheme
                                .primary
                                .withAlpha(76),
                            blurRadius: 25,
                            spreadRadius: -10,
                          ),
                        ]),
                    child: Card(
                      color: Theme.of(context).colorScheme.primaryContainer,
                      elevation: 10.0,
                      shadowColor: Theme.of(context).colorScheme.primary,
                      margin: const EdgeInsets.all(10),
                      child: ListTile(
                        onTap: () {
                          Navigator.pushNamed(context, "support");
                        },
                        title: Text(
                          "Support us",
                          style: TextStyle(
                            color: Theme.of(context)
                                .colorScheme
                                .onPrimaryContainer,
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            : ListView(children: [
                Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.04,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .primary
                                      .withAlpha(200),
                                  blurRadius: 7,
                                  spreadRadius: -10,
                                  offset: const Offset(0, 5),
                                ),
                                BoxShadow(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .primary
                                      .withAlpha(128),
                                  blurRadius: 15,
                                  spreadRadius: -10,
                                  offset: const Offset(0, 5),
                                ),
                                BoxShadow(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .primary
                                      .withAlpha(76),
                                  blurRadius: 25,
                                  spreadRadius: -10,
                                ),
                              ]),
                          child: Card(
                            color:
                                Theme.of(context).colorScheme.primaryContainer,
                            elevation: 10,
                            shadowColor: Theme.of(context).colorScheme.primary,
                            margin: const EdgeInsets.all(10),
                            child: ListTile(
                              trailing: Switch(
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
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onPrimaryContainer,
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .primary
                                      .withAlpha(200),
                                  blurRadius: 7,
                                  spreadRadius: -10,
                                  offset: const Offset(0, 5),
                                ),
                                BoxShadow(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .primary
                                      .withAlpha(128),
                                  blurRadius: 15,
                                  spreadRadius: -10,
                                  offset: const Offset(0, 5),
                                ),
                                BoxShadow(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .primary
                                      .withAlpha(76),
                                  blurRadius: 25,
                                  spreadRadius: -10,
                                ),
                              ]),
                          child: Card(
                            color:
                                Theme.of(context).colorScheme.primaryContainer,
                            elevation: 10.0,
                            shadowColor: Theme.of(context).colorScheme.primary,
                            margin: const EdgeInsets.all(10),
                            child: Row(
                              children: [
                                Expanded(
                                  child: ListTile(
                                    title: Text(
                                      "Choose theme",
                                      style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onPrimaryContainer,
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 30.0),
                                  child: Row(
                                    children: [
                                      //Green Theme Circle
                                      GestureDetector(
                                        onTap: () {
                                          widget.onThemeChanged!(
                                              AppThemes.greenTheme);
                                          setTheme("green");
                                        },
                                        child: Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.1,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.1,
                                          decoration: const BoxDecoration(
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Color(0XFF101827),
                                                  spreadRadius: 3)
                                            ],
                                            shape: BoxShape.circle,
                                            color: Colors.green,
                                          ),
                                        ),
                                      ),

                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.03,
                                      ),
                                      //Golden Theme Circle
                                      GestureDetector(
                                        onTap: () {
                                          widget.onThemeChanged!(
                                              AppThemes.goldenTheme);
                                          setTheme("golden");
                                        },
                                        child: Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.1,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.1,
                                          decoration: const BoxDecoration(
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Color(0XFF101827),
                                                  spreadRadius: 3)
                                            ],
                                            shape: BoxShape.circle,
                                            color: Color(0xffF4A300),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .primary
                                      .withAlpha(200),
                                  blurRadius: 7,
                                  spreadRadius: -10,
                                  offset: const Offset(0, 5),
                                ),
                                BoxShadow(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .primary
                                      .withAlpha(128),
                                  blurRadius: 15,
                                  spreadRadius: -10,
                                  offset: const Offset(0, 5),
                                ),
                                BoxShadow(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .primary
                                      .withAlpha(76),
                                  blurRadius: 25,
                                  spreadRadius: -10,
                                ),
                              ]),
                          child: Card(
                            color:
                                Theme.of(context).colorScheme.primaryContainer,
                            elevation: 10.0,
                            shadowColor: Theme.of(context).colorScheme.primary,
                            margin: const EdgeInsets.all(10),
                            child: ListTile(
                              onTap: () {
                                Navigator.pushNamed(context, "about");
                              },
                              title: Text(
                                "About us",
                                style: TextStyle(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onPrimaryContainer,
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .primary
                                      .withAlpha(200),
                                  blurRadius: 7,
                                  spreadRadius: -10,
                                  offset: const Offset(0, 5),
                                ),
                                BoxShadow(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .primary
                                      .withAlpha(128),
                                  blurRadius: 15,
                                  spreadRadius: -10,
                                  offset: const Offset(0, 5),
                                ),
                                BoxShadow(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .primary
                                      .withAlpha(76),
                                  blurRadius: 25,
                                  spreadRadius: -10,
                                ),
                              ]),
                          child: Card(
                            color:
                                Theme.of(context).colorScheme.primaryContainer,
                            elevation: 10.0,
                            shadowColor: Theme.of(context).colorScheme.primary,
                            margin: const EdgeInsets.all(10),
                            child: ListTile(
                              onTap: () {
                                Navigator.pushNamed(context, "support");
                              },
                              title: Text(
                                "Support us",
                                style: TextStyle(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onPrimaryContainer,
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )),
              ]));
  }
}
