import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasabeeh/homepage.dart';
import 'dart:convert';
import 'package:awesome_dialog/awesome_dialog.dart';

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
    loadingZekr(); // تحميل الأذكار
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

  @override
  Widget build(BuildContext context) {
    Orientation orientation = MediaQuery.of(context).orientation;
    return orientation == Orientation.portrait
        ? Scaffold(
            bottomNavigationBar: BottomNavigationBar(
                currentIndex: index,
                unselectedFontSize: 15,
                selectedItemColor: const Color(0xFFF4A300),
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
                              boxShadow: const [
                                BoxShadow(
                                    color: Colors.black,
                                    blurRadius: 1.3,
                                    offset: Offset(0, 2),
                                    spreadRadius: -0.10)
                              ],
                              color: index == 1
                                  ? const Color(0xFFF4A300)
                                  : Colors.grey[700],
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Center(
                                child: Text(
                              "Azkar",
                              style: TextStyle(
                                fontWeight: index == 1
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                                color: index == 1
                                    ? Colors.grey[700]
                                    : Colors.white,
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
                  child: MaterialButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      height: 50,
                      minWidth: 200,
                      onPressed: () {
                        Navigator.pushNamed(context, "addzekr");
                      },
                      color: const Color(0xFFF4A300),
                      child: const Text("Add Zekr",
                          style: TextStyle(fontSize: 20))),
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
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height * 0.22,
                          child: Card(
                              elevation: 8.0,
                              shadowColor: const Color(0xFFF4A300),
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
                                                      const Color.fromARGB(
                                                          255, 66, 66, 66),
                                                  shadowColor:
                                                      const Color(0xFFF4A300),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                  ),
                                                  backgroundColor:
                                                      const Color(0xFFF4A300),
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
                                                      const Color.fromARGB(
                                                          255, 66, 66, 66),
                                                  shadowColor:
                                                      const Color(0xFFF4A300),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                  ),
                                                  backgroundColor:
                                                      const Color(0xFFF4A300),
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
                                                      const Color.fromARGB(
                                                          255, 66, 66, 66),
                                                  shadowColor:
                                                      const Color(0xFFF4A300),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                  ),
                                                  backgroundColor:
                                                      const Color(0xFFF4A300),
                                                  minimumSize:
                                                      const Size(45, 40),
                                                  maximumSize:
                                                      const Size(90, 50),
                                                ),
                                                onPressed: () {
                                                  setController.text =
                                                      counterMap[azkar[index]]
                                                          .toString();
                                                  AwesomeDialog(
                                                    context: context,
                                                    customHeader: Container(
                                                      alignment:
                                                          Alignment.center,
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.5,
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.5,
                                                      decoration:
                                                          const BoxDecoration(
                                                        color:
                                                            Color(0xFFF4A300),
                                                        shape: BoxShape.circle,
                                                      ),
                                                      child: const FittedBox(
                                                        fit: BoxFit.scaleDown,
                                                        child: Icon(
                                                          Icons.info,
                                                          size: 150,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ),
                                                    isDense: false,
                                                    body: Column(
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Text(
                                                              "Set Counter",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                          .grey[
                                                                      800],
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize:
                                                                      20)),
                                                        ),
                                                        Row(
                                                          children: [
                                                            const Icon(
                                                                Icons.edit_note,
                                                                size: 40),
                                                            SizedBox(
                                                              width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  0.6,
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .only(
                                                                        left:
                                                                            10),
                                                                child: Form(
                                                                  key: formKey,
                                                                  child:
                                                                      TextFormField(
                                                                    controller:
                                                                        setController,
                                                                    validator:
                                                                        (value) {
                                                                      if (value ==
                                                                              null ||
                                                                          value
                                                                              .isEmpty) {
                                                                        return 'Please Set a number';
                                                                      } else if (int.tryParse(
                                                                              value) ==
                                                                          null) {
                                                                        return 'Please Set a number';
                                                                      } else if (int.tryParse(
                                                                              value)! <
                                                                          1) {
                                                                        return 'Please Set a number more than 0';
                                                                      } else {
                                                                        return null;
                                                                      }
                                                                    },
                                                                    decoration:
                                                                        InputDecoration(
                                                                      filled:
                                                                          true,
                                                                      fillColor:
                                                                          Colors
                                                                              .grey[300],
                                                                      enabledBorder:
                                                                          const OutlineInputBorder(
                                                                              borderSide: BorderSide.none),
                                                                      border: OutlineInputBorder(
                                                                          borderRadius:
                                                                              BorderRadius.circular(10)),
                                                                      hintText:
                                                                          "Count",
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                    btnOkText: "Save",
                                                    buttonsTextStyle: TextStyle(
                                                      color: Colors.grey[800],
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 18,
                                                    ),
                                                    btnOkColor:
                                                        const Color(0xFFF4A300),
                                                    btnOkOnPress: () {
                                                      if (formKey.currentState!
                                                          .validate()) {
                                                        setState(() {
                                                          counterMap[azkar[
                                                                  index]] =
                                                              int.parse(
                                                                  setController
                                                                      .text);
                                                          prefs.setString(
                                                              "counterMap",
                                                              jsonEncode(
                                                                  counterMap));
                                                        });
                                                      }
                                                    },
                                                  ).show();
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
                                                  decoration:
                                                      const BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: Color(0xFFF4A300),
                                                  ),
                                                  padding: const EdgeInsets
                                                      .symmetric(horizontal: 8),
                                                  margin: const EdgeInsets
                                                      .symmetric(horizontal: 8),
                                                  child: Text(
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: const TextStyle(
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
                unselectedFontSize: 15,
                selectedItemColor: const Color(0xFFF4A300),
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
                              boxShadow: const [
                                BoxShadow(
                                    color: Colors.black,
                                    blurRadius: 1.3,
                                    offset: Offset(0, 2),
                                    spreadRadius: -0.10)
                              ],
                              color: index == 1
                                  ? const Color(0xFFF4A300)
                                  : Colors.grey[700],
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Center(
                                child: Text(
                              "Azkar",
                              style: TextStyle(
                                fontWeight: index == 1
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                                color: index == 1
                                    ? Colors.grey[700]
                                    : Colors.white,
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
                  child: MaterialButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      height: 50,
                      minWidth: 200,
                      onPressed: () {
                        Navigator.pushNamed(context, "addzekr");
                      },
                      color: const Color(0xFFF4A300),
                      child: const Text("Add Zekr",
                          style: TextStyle(fontSize: 20))),
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
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.5,
                          height: MediaQuery.of(context).size.height * 0.46,
                          child: Card(
                              elevation: 8.0,
                              shadowColor: const Color(0xFFF4A300),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Align(
                                      alignment: Alignment.topCenter,
                                      child: Text(
                                        textAlign: TextAlign.start,
                                        textDirection: TextDirection.ltr,
                                        style: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
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
                                                    const Color.fromARGB(
                                                        255, 66, 66, 66),
                                                shadowColor:
                                                    const Color(0xFFF4A300),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                ),
                                                backgroundColor:
                                                    const Color(0xFFF4A300),
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
                                                    const Color.fromARGB(
                                                        255, 66, 66, 66),
                                                shadowColor:
                                                    const Color(0xFFF4A300),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                ),
                                                backgroundColor:
                                                    const Color(0xFFF4A300),
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
                                                    const Color.fromARGB(
                                                        255, 66, 66, 66),
                                                shadowColor:
                                                    const Color(0xFFF4A300),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                ),
                                                backgroundColor:
                                                    const Color(0xFFF4A300),
                                                minimumSize: const Size(65, 40),
                                                maximumSize:
                                                    const Size(100, 50),
                                              ),
                                              onPressed: () {
                                                setController.text =
                                                    counterMap[azkar[index]]
                                                        .toString();

                                                AwesomeDialog(
                                                  context: context,
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.8,
                                                  title: 'Set Count',
                                                  titleTextStyle:
                                                      const TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold,
                                                    color: Color(0xFFF4A300),
                                                  ),
                                                  customHeader: Container(
                                                    alignment: Alignment.center,
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .shortestSide *
                                                            0.5,
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .shortestSide *
                                                            0.5,
                                                    decoration: BoxDecoration(
                                                      color: const Color(
                                                          0xFFF4A300),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              70),
                                                    ),
                                                    child: const FittedBox(
                                                      fit: BoxFit.scaleDown,
                                                      child: Icon(
                                                        Icons.info,
                                                        size: 300,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                  body: Column(
                                                    children: [
                                                      const Padding(
                                                        padding:
                                                            EdgeInsets.all(8.0),
                                                        child: Text(
                                                          "Set Count",
                                                          style: TextStyle(
                                                              fontSize: 18,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: Color
                                                                  .fromARGB(
                                                                      255,
                                                                      41,
                                                                      41,
                                                                      41)),
                                                        ),
                                                      ),
                                                      Row(
                                                        children: [
                                                          const Icon(
                                                              Icons.edit_note,
                                                              size: 40),
                                                          Form(
                                                            key: formKey,
                                                            child: SizedBox(
                                                              width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  0.6,
                                                              child:
                                                                  TextFormField(
                                                                controller:
                                                                    setController,
                                                                validator:
                                                                    (value) {
                                                                  if (value ==
                                                                          null ||
                                                                      value
                                                                          .isEmpty) {
                                                                    return 'Please Set a number';
                                                                  } else if (int
                                                                          .tryParse(
                                                                              value) ==
                                                                      null) {
                                                                    return 'Please Set a number';
                                                                  } else if (int
                                                                          .tryParse(
                                                                              value)! <
                                                                      1) {
                                                                    return 'Please Set a number more than 0';
                                                                  } else {
                                                                    return null;
                                                                  }
                                                                },
                                                                decoration:
                                                                    InputDecoration(
                                                                  filled: true,
                                                                  fillColor:
                                                                      Colors.grey[
                                                                          300],
                                                                  enabledBorder:
                                                                      const OutlineInputBorder(
                                                                          borderSide:
                                                                              BorderSide.none),
                                                                  border: OutlineInputBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              10)),
                                                                  hintText:
                                                                      "Count",
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                  btnOkText: "Save",
                                                  btnOkColor:
                                                      const Color(0xFFF4A300),
                                                  btnOkOnPress: () {
                                                    if (formKey.currentState!
                                                        .validate()) {
                                                      setState(() {
                                                        counterMap[
                                                                azkar[index]] =
                                                            int.parse(
                                                                setController
                                                                    .text);
                                                        prefs.setString(
                                                            "counterMap",
                                                            jsonEncode(
                                                                counterMap));
                                                      });
                                                    }
                                                  },
                                                ).show();
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
                                                decoration: const BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Color(0xFFF4A300),
                                                ),
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 8),
                                                margin:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 8),
                                                child: Text(
                                                    textAlign: TextAlign.center,
                                                    style: const TextStyle(
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
