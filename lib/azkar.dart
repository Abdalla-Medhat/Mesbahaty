import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasabeeh/homepage.dart';
import 'dart:convert';
import 'package:awesome_dialog/awesome_dialog.dart';

class Azkar extends StatefulWidget {
  // final List<String>? zekr;
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

    // if (widget.zekr != null && widget.zekr!.isNotEmpty) {
    //   storedData.addAll(widget.zekr!);
    //   await prefs.setStringList("zekr", storedData);
    // }
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

  SetCounter(String val) {}

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
          color: Colors.grey[800],
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 70, left: 85, right: 50),
                child: MaterialButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    height: 50,
                    minWidth: 200,
                    onPressed: () {
                      Navigator.pushNamed(context, "addzekr");
                    },
                    color: Colors.orange,
                    child:
                        const Text("Add Zekr", style: TextStyle(fontSize: 20))),
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
                    child: Card(
                        elevation: 8.0,
                        shadowColor: Colors.orange,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                azkar[index],
                                overflow: TextOverflow.ellipsis,
                              ),
                              Row(children: [
                                MaterialButton(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  height: 50,
                                  minWidth: 100,
                                  onPressed: () {
                                    setState(() {
                                      deleteZeker(index);
                                    });
                                  },
                                  color: Colors.orange,
                                  child: const Text("Delete"),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                MaterialButton(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  height: 50,
                                  minWidth: 100,
                                  onPressed: () {
                                    setState(() {
                                      resetCounter(index);
                                    });
                                  },
                                  color: Colors.orange,
                                  child: const Text("Reset"),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                // isSet == true
                                //     ?
                                MaterialButton(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  height: 50,
                                  minWidth: 100,
                                  onPressed: () {
                                    setController.text =
                                        counterMap[azkar[index]].toString();
                                    AwesomeDialog(
                                      context: context,
                                      customHeader: Container(
                                        alignment: Alignment.center,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.8,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.8,
                                        decoration: BoxDecoration(
                                          color: Colors.orange,
                                          borderRadius:
                                              BorderRadius.circular(70),
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

                                      // dialogType: DialogType.info,
                                      // animType: AnimType.bottomSlide,
                                      isDense: false,
                                      title: 'Set Count',
                                      body: Row(
                                        children: [
                                          const Icon(Icons.edit_note, size: 30),
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.6,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 10),
                                              child: Form(
                                                key: formKey,
                                                child: TextFormField(
                                                  controller: setController,
                                                  validator: (value) {
                                                    if (value == null ||
                                                        value.isEmpty) {
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
                                                  decoration: InputDecoration(
                                                    filled: true,
                                                    fillColor: Colors.grey[300],
                                                    enabledBorder:
                                                        const OutlineInputBorder(
                                                            borderSide:
                                                                BorderSide
                                                                    .none),
                                                    border: OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10)),
                                                    hintText: "Count",
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      btnOkText: "Save",
                                      btnOkColor: Colors.orange,
                                      btnOkOnPress: () {
                                        if (formKey.currentState!.validate()) {
                                          setState(() {
                                            counterMap[azkar[index]] =
                                                int.parse(setController.text);
                                            prefs.setString("counterMap",
                                                jsonEncode(counterMap));
                                          });
                                        }
                                      },
                                    ).show();
                                  },
                                  color: Colors.orange,
                                  child: const Text("Set"),
                                ),
                              ]),
                              Text("Count: ${counterMap[azkar[index]] ?? 0}"),
                            ],
                          ),
                        )),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
