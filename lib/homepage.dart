import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

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
  bool? status;

  Future<void> getStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return setState(() {
      status = prefs.getBool("status") ?? false;
    });
  }

  // دالة لتحميل العدّاد من SharedPreferences
  Future<void> loadCounterData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? counterData = prefs.getString("counterMap");
    Map<String, dynamic> counterMap =
        counterData != null ? jsonDecode(counterData) : {};

    setState(() {
      count = counterMap[widget.zekr] ?? 0;
    });
  }

  // دالة لزيادة العدّاد وحفظه في SharedPreferences
  Future<void> incrementCount() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
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
    loadCounterData();
    getStatus(); // تحميل العدّاد عند بدء التطبيق
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
        body: Column(
          children: [
            Expanded(
              child: status == null
                  ? const Center(
                      child: CircularProgressIndicator(color: Colors.orange))
                  : mainContent(),
            ),
          ],
        ));
  }

  Widget mainContent() {
    if (status == true) {
      return InkWell(
        onTap: () {
          incrementCount();
        },
        child: Container(
          decoration: BoxDecoration(color: Colors.grey[800]),
          child: Column(
            children: [
              Center(
                child: Container(
                  width: 320,
                  height: 192,
                  margin: const EdgeInsets.only(top: 40),
                  decoration: BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
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
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 85,
              ),
              Expanded(
                child: SizedBox(
                  height: 290,
                  width: 290,
                  child: MaterialButton(
                    shape: const CircleBorder(),
                    color: Colors.orange,
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
                            fontSize:
                                200, // كبير لكن لا يشكل خطر لأن FittedBox يتحكم
                            color: Colors.grey[800],
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      return Container(
        decoration: BoxDecoration(color: Colors.grey[800]),
        child: Column(
          children: [
            Center(
              child: Container(
                width: 320,
                height: 192,
                margin: const EdgeInsets.only(top: 40),
                decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(children: [
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
            const SizedBox(
              height: 85,
            ),
            Expanded(
              child: SizedBox(
                height: 290,
                width: 290,
                child: MaterialButton(
                  shape: const CircleBorder(),
                  color: Colors.orange,
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
                          fontSize:
                              200, // كبير لكن لا يشكل خطر لأن FittedBox يتحكم
                          color: Colors.grey[800],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }
  }
}
