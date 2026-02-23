import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:tasabeeh/homepage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Azkar extends StatefulWidget {
  const Azkar({super.key});

  @override
  State<Azkar> createState() => _ZekrState();
}

class _ZekrState extends State<Azkar> {
  int index = 1;
  List<String> azkar = [];
  bool isSet = false;

  final formKey = GlobalKey<FormState>(); // formKey
  TextEditingController setController =
      TextEditingController(); // setController

  late SharedPreferences prefs;
  initAll() async {
    prefs = await SharedPreferences.getInstance();
    loadingZekr(); // Loading Azkar
    loadCounterData(); // تحميل العدادات من SharedPreferences
  }

  Future<void> loadingZekr() async {
    List<String> storedData = prefs.getStringList("zekr") ?? [];

    setState(() {
      azkar = storedData;
    });
  }

  @override
  void initState() {
    super.initState();
    initAll();
  }

//خريطة تخزن عدد التكرارات لكل ذِكر.
  Map<String, dynamic> counterMap = {};

  // دالة تسترجع البيانات المخزنة من SharedPreferences وتحولها إلى خريطة.
  Future<void> loadCounterData() async {
    String? counterData = prefs.getString("counterMap");
    if (counterData != null) {
      setState(() {
        // نحول النص إلى خريطة باستخدام JSON.
        counterMap = jsonDecode(counterData);
      });
    }
  }

  Future<void> resetCounter(int index) async {
    // حدد الذكر اللي هيتم تصفير عداده
    String zekr = azkar[index];

    setState(() {
      counterMap[zekr] = 0;
    });

    // خزّن البيانات المعدلة
    await prefs.setString("counterMap", jsonEncode(counterMap));
  }

  Future<void> deleteZeker(int index) async {
    String removedZekr = azkar[index];

    setState(() {
      azkar.removeAt(index);
      counterMap.remove(removedZekr);
    });

    await prefs.setStringList("zekr", azkar);
    await prefs.setString("counterMap", jsonEncode(counterMap));
  }

  setCounter(String val) {}

  void showResponsiveDialog({
    required int index,
  }) {
    final formKey = GlobalKey<FormState>();

    showDialog(
      context: context,
      builder: (context) {
        final media = MediaQuery.of(context);
        final orientation = media.orientation;
        final width = media.size.width;
        final height = media.size.height;

        final dialogWidth =
            orientation == Orientation.portrait ? width * 0.8 : width * 0.7;
        final dialogHeight =
            orientation == Orientation.portrait ? height * 0.5 : height * 6;
        final iconSize = width * 0.15;
        final iconBoxSize = orientation == Orientation.portrait
            ? (width * 0.3).clamp(60, 120)
            : (width * 0.25).clamp(60, 120);

        // النسخة الطولية (Portrait)
        if (orientation == Orientation.portrait) {
          return PopScope(
            canPop: false,
            child: Dialog(
              backgroundColor: Colors.transparent,
              child: Stack(clipBehavior: Clip.none, children: [
                Container(
                  width: dialogWidth,
                  height: dialogHeight,
                  padding: EdgeInsets.only(top: iconBoxSize / 2),
                  decoration: BoxDecoration(
                    color: Theme.of(context)
                        .colorScheme
                        .primaryContainer
                        .withAlpha(225),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.only(top: 15.0),
                          child: Text(
                            "Set Counter",
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: Form(
                            key: formKey,
                            child: TextFormField(
                              //the form is not dismissed

                              cursorColor:
                                  Theme.of(context).colorScheme.primary,
                              style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary,
                                  fontWeight: FontWeight.bold),
                              controller: setController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please Set a number';
                                } else if (int.tryParse(value) == null) {
                                  return 'Please Set a number';
                                } else if (int.parse(value) < 1) {
                                  return 'Please Set a number more than 0';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Theme.of(context)
                                    .colorScheme
                                    .secondaryContainer
                                    .withAlpha(220),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: BorderSide(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                        width: 10)),
                                enabled: true,
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: BorderSide(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary
                                            .withAlpha(200),
                                        width: 3)),
                                hintText: "Count",
                              ),
                              keyboardType: TextInputType.number,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 15.0),
                          child: ElevatedButton(
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                setState(() {
                                  counterMap[azkar[index]] =
                                      int.parse(setController.text);
                                  prefs.setString(
                                      "counterMap", jsonEncode(counterMap));
                                });
                                Navigator.of(context).pop();
                              }
                            },
                            child: Text(
                              "Save",
                              style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            "Cancel",
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.onPrimary,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: -iconBoxSize / 2,
                  right: 0,
                  left: 0,
                  child: Container(
                    alignment: Alignment.center,
                    width: iconBoxSize.toDouble(),
                    height: iconBoxSize.toDouble(),
                    decoration: BoxDecoration(
                      color:
                          Theme.of(context).colorScheme.primary.withAlpha(200),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.info,
                      size: iconSize,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                ),
              ]),
            ),
          );
        }

        // النسخة العرضية (Landscape) مع scroll كامل للـ Dialog
        return PopScope(
          canPop: false,
          child: Dialog(
            backgroundColor: Colors.transparent,
            child: SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height * 0.8),
                child: Stack(clipBehavior: Clip.none, children: [
                  Container(
                    width: dialogWidth,
                    padding: EdgeInsets.only(top: iconBoxSize / 2),
                    decoration: BoxDecoration(
                      color: Theme.of(context)
                          .colorScheme
                          .primaryContainer
                          .withAlpha(225),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.only(top: 15.0),
                          child: Text(
                            "Set Counter",
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: Form(
                            key: formKey,
                            child: TextFormField(
                              cursorColor:
                                  Theme.of(context).colorScheme.primary,
                              style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary,
                                  fontWeight: FontWeight.bold),
                              controller: setController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please Set a number';
                                } else if (int.tryParse(value) == null) {
                                  return 'Please Set a number';
                                } else if (int.parse(value) < 1) {
                                  return 'Please Set a number more than 0';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Theme.of(context)
                                    .colorScheme
                                    .secondaryContainer
                                    .withAlpha(220),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: BorderSide(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                        width: 10)),
                                enabled: true,
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: BorderSide(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary
                                            .withAlpha(200),
                                        width: 3)),
                                hintText: "Count",
                              ),
                              keyboardType: TextInputType.number,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 15.0),
                          child: ElevatedButton(
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                setState(() {
                                  counterMap[azkar[index]] =
                                      int.parse(setController.text);
                                  prefs.setString(
                                      "counterMap", jsonEncode(counterMap));
                                });
                                Navigator.of(context).pop();
                              }
                            },
                            child: Text(
                              "Save",
                              style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            "Cancel",
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.onPrimary,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
                        )
                      ],
                    ),
                  ),
                  Positioned(
                    top: -iconBoxSize / 2,
                    right: 0,
                    left: 0,
                    child: Container(
                      margin: const EdgeInsets.only(top: 10),
                      alignment: Alignment.center,
                      width: iconBoxSize.toDouble(),
                      height: iconBoxSize.toDouble(),
                      decoration: BoxDecoration(
                        color: Theme.of(context)
                            .colorScheme
                            .primary
                            .withAlpha(200),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.info,
                        size: iconSize,
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                    ),
                  ),
                ]),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Color primary = Theme.of(context).colorScheme.primary;
    return orientation == Orientation.portrait
        ? Scaffold(
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
                  selectedLabelStyle:
                      const TextStyle(fontWeight: FontWeight.bold),
                  onTap: (value) {
                    setState(() {
                      index = value;
                      if (index == 2) {
                        Navigator.pushNamed(context, "settings");
                      }
                      if (index == 0) {
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
                            },
                            child: Container(
                              width: 80,
                              height: 40,
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                      color: Theme.of(context)
                                          .scaffoldBackgroundColor,
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
                                  color: Colors.white,
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
                Padding(
                  padding: const EdgeInsets.only(
                      top: 70, left: 85, right: 50, bottom: 10),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.5,
                    height: MediaQuery.of(context).size.height * 0.07,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                            color: primary, blurRadius: 25, spreadRadius: 1.5)
                      ],
                    ),
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, "addzekr");
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          backgroundColor: primary,
                        ),
                        child: Text("Add Zekr",
                            style: TextStyle(
                                fontSize: 20,
                                color:
                                    Theme.of(context).colorScheme.onPrimary))),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: azkar.length,
                    itemBuilder: (context, index) => InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    Homepage(zekr: azkar[index])));
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.22,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Theme.of(context)
                                    .colorScheme
                                    .primary
                                    .withAlpha(200),
                                blurRadius: 20,
                                spreadRadius: 2,
                              ),
                              BoxShadow(
                                color: Theme.of(context)
                                    .colorScheme
                                    .primary
                                    .withAlpha(128),
                                blurRadius: 40,
                                spreadRadius: 6,
                              ),
                              BoxShadow(
                                color: Theme.of(context)
                                    .colorScheme
                                    .primary
                                    .withAlpha(76),
                                blurRadius: 60,
                                spreadRadius: 12,
                              ),
                            ],
                          ),
                          child: Card(
                              color: Theme.of(context)
                                  .colorScheme
                                  .primaryContainer,
                              elevation: 15.0,
                              shadowColor: Theme.of(context)
                                  .colorScheme
                                  .primary
                                  .withAlpha(240),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Align(
                                        alignment: Alignment.topCenter,
                                        child: Text(
                                          textAlign: TextAlign.start,
                                          textDirection: TextDirection.ltr,
                                          style: const TextStyle(),
                                          azkar[index],
                                          maxLines: 3,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: Row(children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 4),
                                              child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  textStyle: const TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                  elevation: 6.0,
                                                  foregroundColor:
                                                      Theme.of(context)
                                                          .colorScheme
                                                          .onPrimary,
                                                  shadowColor: Theme.of(context)
                                                      .colorScheme
                                                      .secondary,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                  ),
                                                  backgroundColor: primary,
                                                  minimumSize:
                                                      const Size(45, 40),
                                                  maximumSize:
                                                      const Size(90, 50),
                                                ),
                                                onPressed: () {
                                                  setState(() {
                                                    deleteZeker(index);
                                                  });
                                                },
                                                child: const FittedBox(
                                                    child: Text("Delete")),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 4),
                                              child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  textStyle: const TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                  elevation: 6.0,
                                                  foregroundColor:
                                                      Theme.of(context)
                                                          .colorScheme
                                                          .onPrimary,
                                                  shadowColor: Theme.of(context)
                                                      .colorScheme
                                                      .secondary,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                  ),
                                                  backgroundColor: primary,
                                                  minimumSize:
                                                      const Size(45, 40),
                                                  maximumSize:
                                                      const Size(90, 50),
                                                ),
                                                onPressed: () {
                                                  setState(() {
                                                    resetCounter(index);
                                                  });
                                                },
                                                child: const FittedBox(
                                                    child: Text("Reset")),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 4),
                                              child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  textStyle: const TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                  elevation: 6.0,
                                                  foregroundColor:
                                                      Theme.of(context)
                                                          .colorScheme
                                                          .onPrimary,
                                                  shadowColor: Theme.of(context)
                                                      .colorScheme
                                                      .secondary,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                  ),
                                                  backgroundColor: primary,
                                                  minimumSize:
                                                      const Size(45, 40),
                                                  maximumSize:
                                                      const Size(90, 50),
                                                ),
                                                onPressed: () {
                                                  setController.text =
                                                      counterMap[azkar[index]]
                                                          .toString();

                                                  showResponsiveDialog(
                                                    index: index,
                                                  );
                                                },
                                                child: const FittedBox(
                                                    child: Text("Set")),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 70,
                                              child: LayoutBuilder(builder:
                                                  (context, constraints) {
                                                double size =
                                                    constraints.maxHeight *
                                                        0.85;
                                                return Container(
                                                  alignment: Alignment.center,
                                                  height: size,
                                                  width: size,
                                                  decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: primary,
                                                      boxShadow: [
                                                        BoxShadow(
                                                            color: Theme.of(
                                                                    context)
                                                                .colorScheme
                                                                .secondary
                                                                .withAlpha(180),
                                                            blurRadius: 4,
                                                            spreadRadius: 1.5,
                                                            offset:
                                                                const Offset(
                                                                    0, 3))
                                                      ]),
                                                  padding: const EdgeInsets
                                                      .symmetric(horizontal: 8),
                                                  margin: const EdgeInsets
                                                      .symmetric(horizontal: 8),
                                                  child: Text(
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          color:
                                                              Theme.of(context)
                                                                  .colorScheme
                                                                  .onPrimary,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 15,
                                                          overflow: TextOverflow
                                                              .ellipsis),
                                                      "${counterMap[azkar[index]] ?? 0}"),
                                                );
                                              }),
                                            ),
                                          ]),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              )),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        : Scaffold(
            bottomNavigationBar: BottomNavigationBar(
                currentIndex: index,
                selectedFontSize: 17,
                unselectedFontSize: 15,
                backgroundColor: Theme.of(context).colorScheme.surface,
                selectedItemColor: Theme.of(context).colorScheme.primary,
                unselectedItemColor:
                    Theme.of(context).colorScheme.onSurface.withAlpha(200),
                iconSize: 27,
                selectedLabelStyle:
                    const TextStyle(fontWeight: FontWeight.bold),
                onTap: (value) {
                  setState(() {
                    index = value;
                    if (index == 2) {
                      Navigator.pushNamed(context, "settings");
                    }
                    if (index == 0) {
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
                          },
                          child: Container(
                            width: 80,
                            height: 40,
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    color: Theme.of(context)
                                        .scaffoldBackgroundColor,
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
                                color: Colors.white,
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
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      top: 70, left: 85, right: 50, bottom: 10),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.4,
                    height: MediaQuery.of(context).size.height * 0.135,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                            color: primary, blurRadius: 25, spreadRadius: 1.5)
                      ],
                    ),
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, "addzekr");
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          backgroundColor: primary,
                        ),
                        child: Text("Add Zekr",
                            style: TextStyle(
                                fontSize: 20,
                                color:
                                    Theme.of(context).colorScheme.onPrimary))),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: azkar.length,
                    itemBuilder: (context, index) => InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    Homepage(zekr: azkar[index])));
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18),
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.5,
                          height: MediaQuery.of(context).size.height * 0.46,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Theme.of(context)
                                    .colorScheme
                                    .primary
                                    .withAlpha(200),
                                blurRadius: 20,
                                spreadRadius: 2,
                              ),
                              BoxShadow(
                                color: Theme.of(context)
                                    .colorScheme
                                    .primary
                                    .withAlpha(128),
                                blurRadius: 40,
                                spreadRadius: 6,
                              ),
                              BoxShadow(
                                color: Theme.of(context)
                                    .colorScheme
                                    .primary
                                    .withAlpha(76),
                                blurRadius: 60,
                                spreadRadius: 12,
                              ),
                            ],
                          ),
                          child: Card(
                              color: Theme.of(context)
                                  .colorScheme
                                  .primaryContainer,
                              elevation: 8.0,
                              shadowColor: Theme.of(context)
                                  .colorScheme
                                  .primary
                                  .withAlpha(240),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Align(
                                      alignment: Alignment.topCenter,
                                      child: Text(
                                        textAlign: TextAlign.start,
                                        textDirection: TextDirection.ltr,
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onPrimaryContainer,
                                        ),
                                        azkar[index],
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    const Spacer(),
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 4),
                                            child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                textStyle: const TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                                elevation: 6.0,
                                                foregroundColor:
                                                    Theme.of(context)
                                                        .colorScheme
                                                        .onPrimary,
                                                shadowColor: Theme.of(context)
                                                    .colorScheme
                                                    .secondary,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                ),
                                                backgroundColor: primary,
                                                minimumSize: const Size(65, 40),
                                                maximumSize:
                                                    const Size(100, 50),
                                              ),
                                              onPressed: () {
                                                setState(() {
                                                  deleteZeker(index);
                                                });
                                              },
                                              child: const Text("Delete"),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 4),
                                            child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                textStyle: const TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                                elevation: 6.0,
                                                foregroundColor:
                                                    Theme.of(context)
                                                        .colorScheme
                                                        .onPrimary,
                                                shadowColor: Theme.of(context)
                                                    .colorScheme
                                                    .secondary,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                ),
                                                backgroundColor: primary,
                                                minimumSize: const Size(65, 40),
                                                maximumSize:
                                                    const Size(100, 50),
                                              ),
                                              onPressed: () {
                                                setState(() {
                                                  resetCounter(index);
                                                });
                                              },
                                              child: const Text("Reset"),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 4),
                                            child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                textStyle: const TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                                elevation: 6.0,
                                                foregroundColor:
                                                    Theme.of(context)
                                                        .colorScheme
                                                        .onPrimary,
                                                shadowColor: Theme.of(context)
                                                    .colorScheme
                                                    .secondary,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                ),
                                                backgroundColor: primary,
                                                minimumSize: const Size(65, 40),
                                                maximumSize:
                                                    const Size(100, 50),
                                              ),
                                              onPressed: () {
                                                setController.text =
                                                    counterMap[azkar[index]]
                                                        .toString();
                                                showResponsiveDialog(
                                                  index: index,
                                                );
                                              },
                                              child: const Text("Set"),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 70,
                                            child: LayoutBuilder(builder:
                                                (context, constraints) {
                                              double size =
                                                  constraints.maxHeight * 0.85;
                                              return Container(
                                                alignment: Alignment.center,
                                                height: size,
                                                width: size,
                                                decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: primary,
                                                    boxShadow: [
                                                      BoxShadow(
                                                          color: Theme.of(
                                                                  context)
                                                              .colorScheme
                                                              .secondary
                                                              .withAlpha(180),
                                                          blurRadius: 4,
                                                          spreadRadius: 1.5,
                                                          offset: const Offset(
                                                              0, 3))
                                                    ]),
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 8),
                                                margin:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 8),
                                                child: Text(
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 15,
                                                        color: Theme.of(context)
                                                            .colorScheme
                                                            .onPrimary,
                                                        overflow: TextOverflow
                                                            .ellipsis),
                                                    "${counterMap[azkar[index]] ?? 0}"),
                                              );
                                            }),
                                          ),
                                        ]),
                                  ],
                                ),
                              )),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ));
  }
}
