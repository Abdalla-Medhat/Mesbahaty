import 'package:flutter/material.dart';
import 'package:tasabeeh/azkar.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class AddZekr extends StatefulWidget {
  const AddZekr({super.key});
  @override
  State<AddZekr> createState() => _AddZekrState();
}

class _AddZekrState extends State<AddZekr> {
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Color primary = Theme.of(context).colorScheme.primary;
    Orientation orientation = MediaQuery.of(context).orientation;

    return Scaffold(
        body: orientation == Orientation.portrait
            ? Column(children: [
                const SizedBox(height: 50),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 15, right: 15, bottom: 25),
                  child: TextFormField(
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                      ),
                      maxLines: 10,
                      controller: controller,
                      decoration: InputDecoration(
                        fillColor:
                            Theme.of(context).colorScheme.primaryContainer,
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        filled: true,
                        hintText: "Enter your Zekr",
                        hintStyle: TextStyle(
                          color:
                              Theme.of(context).colorScheme.onPrimaryContainer,
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(color: primary, width: 3)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(color: primary, width: 3)),
                      )),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.5,
                  height: MediaQuery.of(context).size.height * 0.07,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: primary, blurRadius: 25, spreadRadius: 1.5)
                    ],
                  ),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: primary,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20))),
                      onPressed: () async {
                        // 1. نجلب SharedPreferences
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();

                        // 2. نضيف الذكر لقائمة الأذكار
                        List<String> storedAzkar =
                            prefs.getStringList("zekr") ?? [];
                        storedAzkar.add(controller.text);
                        await prefs.setStringList("zekr", storedAzkar);

                        // 3. نجهز خريطة العدادات القديمة (لو فيه)
                        String? counterJson = prefs.getString("counterMap");
                        Map<String, dynamic> counterMap =
                            counterJson != null ? jsonDecode(counterJson) : {};

                        // 4. نضيف الذكر الجديد بعدّاد صفر
                        counterMap[controller.text] = 0;

                        // 5. نخزن الخريطة في SharedPreferences بصيغة JSON
                        await prefs.setString(
                            "counterMap", jsonEncode(counterMap));

                        // 6. نروح لصفحة الأذكار
                        if (context.mounted) {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Azkar()));
                        }
                      },
                      child: const Text("Submit",
                          style: TextStyle(
                            fontSize: 20,
                          ))),
                )
              ])
            : ListView(children: [
                Column(children: [
                  const SizedBox(height: 50),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 20, right: 20, bottom: 25),
                    child: TextFormField(
                        style: TextStyle(
                            color: Theme.of(context)
                                .colorScheme
                                .onPrimaryContainer),
                        maxLines: 5,
                        controller: controller,
                        decoration: InputDecoration(
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          filled: true,
                          fillColor:
                              Theme.of(context).colorScheme.primaryContainer,
                          hintText: "Enter your Zekr",
                          hintStyle: TextStyle(
                            color: Theme.of(context)
                                .colorScheme
                                .onPrimaryContainer,
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(color: primary, width: 3)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(color: primary, width: 3)),
                        )),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.35,
                    height: MediaQuery.of(context).size.height * 0.15,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            color: primary, blurRadius: 25, spreadRadius: 1.5)
                      ],
                    ),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: primary,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20))),
                        onPressed: () async {
                          // 1. نجلب SharedPreferences
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();

                          // 2. نضيف الذكر لقائمة الأذكار
                          List<String> storedAzkar =
                              prefs.getStringList("zekr") ?? [];
                          storedAzkar.add(controller.text);
                          await prefs.setStringList("zekr", storedAzkar);

                          // 3. نجهز خريطة العدادات القديمة (لو فيه)
                          String? counterJson = prefs.getString("counterMap");
                          Map<String, dynamic> counterMap = counterJson != null
                              ? jsonDecode(counterJson)
                              : {};

                          // 4. نضيف الذكر الجديد بعدّاد صفر
                          counterMap[controller.text] = 0;

                          // 5. نخزن الخريطة في SharedPreferences بصيغة JSON
                          await prefs.setString(
                              "counterMap", jsonEncode(counterMap));

                          // 6. نروح لصفحة الأذكار
                          if (context.mounted) {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Azkar()));
                          }
                        },
                        child: const Text("Save",
                            style:
                                TextStyle(fontSize: 20, color: Colors.white))),
                  )
                ])
              ]));
  }
}
