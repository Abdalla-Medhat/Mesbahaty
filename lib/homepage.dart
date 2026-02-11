import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

late Orientation? orientation;
late Color primary;

class Homepage extends StatefulWidget {
  final String? zekr;
  const Homepage({super.key, this.zekr});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  bool islinked = false;
  int index = 0;
  int count = 0;
  // هذا يحدد اذا كان خيار الضغط علي الصفحة كلها مفعل لزيداة الذكر
  bool? clickablePage;

  late SharedPreferences prefs;
  initAll() async {
    prefs = await SharedPreferences.getInstance();
    getclickablePage();
    loadCounterData();
  }

  Future<void> getclickablePage() async {
    return setState(() {
      clickablePage = prefs.getBool("status") ?? false;
    });
  }

  // دالة لتحميل العدّاد من SharedPreferences
  Future<void> loadCounterData() async {
    String? counterData = prefs.getString("counterMap");
    Map<String, dynamic> counterMap =
        counterData != null ? jsonDecode(counterData) : {};

    setState(() {
      count = counterMap[widget.zekr] ?? 0;
    });
  }

  // دالة لزيادة العدّاد وحفظه في SharedPreferences
  Future<void> incrementCount() async {
    String? counterData = prefs.getString("counterMap");
    Map<String, dynamic> counterMap =
        counterData != null ? jsonDecode(counterData) : {};

    // زيادة العدّاد
    counterMap[widget.zekr ?? ''] = (counterMap[widget.zekr] ?? 0) + 1;

    // حفظ البيانات في SharedPreferences
    await prefs.setString("counterMap", jsonEncode(counterMap));

    // تحديث واجهة المستخدم
    setState(() {
      if (widget.zekr != null) {
        count = counterMap[widget.zekr] ?? 0;
      } else {
        count += 1;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    initAll();
  }

  @override
  Widget build(BuildContext context) {
    orientation = MediaQuery.of(context).orientation;
    primary = Theme.of(context).colorScheme.primary;

    return Scaffold(
        extendBody: false,
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
                  if (index == 2) {
                    Navigator.pushNamed(context, "settings");
                  } else if (index == 1) {
                    Navigator.pushNamed(context, "azkar");
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
                            color: index == 1 ? primary : Colors.grey[700],
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Center(
                              child: Text(
                            "Azkar",
                            style: TextStyle(
                              fontWeight: index == 1
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                              color:
                                  index == 1 ? Colors.grey[700] : Colors.white,
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
        ),
        body: Column(
          children: [
            Expanded(
              child: clickablePage == null
                  ? Center(child: CircularProgressIndicator(color: primary))
                  : mainContent(),
            ),
          ],
        ));
  }

  Widget mainContent() {
    if (clickablePage == true) {
      if (orientation == Orientation.portrait) {
        return GestureDetector(
          onTap: () {
            incrementCount();
          },
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: MediaQuery.of(context).size.height * 0.25,
                  margin: const EdgeInsets.only(top: 40),
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primaryContainer,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Theme.of(context).colorScheme.secondary,
                          blurRadius: 7,
                        ),
                        BoxShadow(
                            color: Theme.of(context).colorScheme.secondary,
                            blurRadius: 20,
                            spreadRadius: 2)
                      ]),
                  child: Column(mainAxisSize: MainAxisSize.min, children: [
                    const SizedBox(
                      height: 25,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Text(
                        widget.zekr ??
                            "You can add a zekr here from the Azkar page",
                        style: const TextStyle(
                          fontSize: 17,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 5,
                      ),
                    ),
                  ]),
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: primary,
                      blurRadius: 10,
                      spreadRadius: 1.5,
                    ),
                    BoxShadow(color: primary, blurRadius: 30, spreadRadius: 3)
                  ],
                  shape: BoxShape.circle,
                  color: primary,
                ),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.65,
                  height: MediaQuery.of(context).size.width * 0.65,
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        incrementCount();
                      });
                    },
                    child: Center(
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          "$count",
                          style: TextStyle(
                            fontSize: 100,
                            color: Theme.of(context)
                                .scaffoldBackgroundColor
                                .withAlpha(230),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.08,
              ),
            ],
          ),
        );
      } else {
        return GestureDetector(
            onTap: () {
              incrementCount();
            },
            child: ListView(children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Center(
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      height: MediaQuery.of(context).size.height * 0.4,
                      margin: const EdgeInsets.only(top: 40),
                      decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primaryContainer,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Theme.of(context).colorScheme.secondary,
                              blurRadius: 7,
                            ),
                            BoxShadow(
                                color: Theme.of(context).colorScheme.secondary,
                                blurRadius: 20,
                                spreadRadius: 2)
                          ]),
                      child: Column(mainAxisSize: MainAxisSize.min, children: [
                        const SizedBox(
                          height: 25,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: Text(
                            widget.zekr ??
                                "You can add a zekr here from the Azkar page",
                            style: const TextStyle(fontSize: 17),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 3,
                          ),
                        ),
                      ]),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.1,
                  ),
                  Flexible(
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: primary,
                            blurRadius: 10,
                            spreadRadius: 1.5,
                          ),
                          BoxShadow(
                              color: primary, blurRadius: 30, spreadRadius: 3)
                        ],
                        shape: BoxShape.circle,
                        color: primary,
                      ),
                      child: ClipOval(
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.45,
                          height: MediaQuery.of(context).size.width * 0.45,
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                incrementCount();
                              });
                            },
                            child: Center(
                              child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  "$count",
                                  style: TextStyle(
                                    fontSize: 100,
                                    color: Theme.of(context)
                                        .scaffoldBackgroundColor
                                        .withAlpha(230),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ]));
      }
      // If page is not clickable
    } else {
      if (orientation == Orientation.portrait) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.9,
                height: MediaQuery.of(context).size.height * 0.25,
                margin: const EdgeInsets.only(top: 40),
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Theme.of(context).colorScheme.secondary,
                        blurRadius: 7,
                      ),
                      BoxShadow(
                          color: Theme.of(context).colorScheme.secondary,
                          blurRadius: 20,
                          spreadRadius: 2)
                    ]),
                child: Column(mainAxisSize: MainAxisSize.min, children: [
                  const SizedBox(
                    height: 25,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Text(
                      widget.zekr ??
                          "You can add a zekr here from the Azkar page",
                      style: const TextStyle(fontSize: 17),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 5,
                    ),
                  ),
                ]),
              ),
            ),
            const Spacer(),
            Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: primary,
                    blurRadius: 10,
                    spreadRadius: 1.5,
                  ),
                  BoxShadow(color: primary, blurRadius: 30, spreadRadius: 3)
                ],
                shape: BoxShape.circle,
                color: primary,
              ),
              child: ClipOval(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.65,
                  height: MediaQuery.of(context).size.width * 0.65,
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        incrementCount();
                      });
                    },
                    child: Center(
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          "$count",
                          style: TextStyle(
                            fontSize: 100,
                            color: Theme.of(context)
                                .scaffoldBackgroundColor
                                .withAlpha(230),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.08,
            ),
          ],
        );
      } else {
        return ListView(children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: MediaQuery.of(context).size.height * 0.4,
                  margin: const EdgeInsets.only(top: 40),
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primaryContainer,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Theme.of(context).colorScheme.secondary,
                          blurRadius: 7,
                        ),
                        BoxShadow(
                            color: Theme.of(context).colorScheme.secondary,
                            blurRadius: 20,
                            spreadRadius: 2)
                      ]),
                  child: Column(mainAxisSize: MainAxisSize.min, children: [
                    const SizedBox(
                      height: 25,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Text(
                        widget.zekr ??
                            "You can add a zekr here from the Azkar page",
                        style: const TextStyle(fontSize: 17),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                      ),
                    ),
                  ]),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.15,
              ),
              Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: primary,
                      blurRadius: 10,
                      spreadRadius: 1.5,
                    ),
                    BoxShadow(color: primary, blurRadius: 30, spreadRadius: 3)
                  ],
                  shape: BoxShape.circle,
                  color: primary,
                ),
                child: ClipOval(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.45,
                    height: MediaQuery.of(context).size.width * 0.45,
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          incrementCount();
                        });
                      },
                      child: Center(
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            "$count",
                            style: TextStyle(
                              fontSize: 100,
                              color: Colors.grey[800],
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ]);
      }
    }
  }
}
