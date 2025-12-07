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
    return Scaffold(
      body: Container(
        color: Colors.grey[800],
        child: Column(children: [
          const SizedBox(height: 50),
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextFormField(
                style: const TextStyle(color: Colors.black),
                maxLines: 8,
                controller: controller,
                decoration: InputDecoration(
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  fillColor: Colors.white70,
                  filled: true,
                  hintText: "Enter your Zekr",
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(color: Colors.orange, width: 2),
                  ),
                  enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.orange, width: 2)),
                  focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.orange, width: 2)),
                  label: const Text(
                    "Azkar",
                  ),
                  labelStyle: TextStyle(
                    color: Colors.grey[800],
                  ),
                )),
          ),
          ElevatedButton(
              onPressed: () async {
                // 1. نجلب SharedPreferences
                SharedPreferences prefs = await SharedPreferences.getInstance();

                // 2. نضيف الذكر لقائمة الأذكار
                List<String> storedAzkar = prefs.getStringList("zekr") ?? [];
                storedAzkar.add(controller.text);
                await prefs.setStringList("zekr", storedAzkar);

                // 3. نجهز خريطة العدادات القديمة (لو فيه)
                String? counterJson = prefs.getString("counterMap");
                Map<String, dynamic> counterMap =
                    counterJson != null ? jsonDecode(counterJson) : {};

                // 4. نضيف الذكر الجديد بعدّاد صفر
                counterMap[controller.text] = 0;

                // 5. نخزن الخريطة في SharedPreferences بصيغة JSON
                await prefs.setString("counterMap", jsonEncode(counterMap));

                // 6. نروح لصفحة الأذكار
                if (context.mounted) {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => const Azkar()));
                }
              },
              child: const Text("Submit"))
        ]),
      ),
    );
  }
}
