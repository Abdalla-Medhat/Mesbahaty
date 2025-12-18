import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class About extends StatefulWidget {
  const About({super.key});

  @override
  State<About> createState() => _AboutState();
}

class _AboutState extends State<About> {
  final Uri repoUrl = Uri.parse('https://github.com/Abdalla-Medhat/Tasabeeh');
  Future<void> launchURL(Uri url) async {
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("About us"),
      ),
      body: ListView(children: [
        Column(
          children: [
            Container(
                margin: const EdgeInsets.all(10),
                child: const Card(
                    child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text("""
About the Developer
          
I’m a passionate developer who believes that technology can be a powerful tool to enhance spirituality and bring us closer to Allah in a modern way.
          
With that vision in mind, I created this app to be your daily companion for Tasbeeh and remembrance, anytime and anywhere — in a simple, user-friendly, and contemporary style.
          
I'm always striving to deliver digital experiences that blend benefit with ease, and I welcome any suggestions that help improve and grow this app.
          
— Abdullah Medhat"""),
                ))),
            const SizedBox(
              height: 10,
            ),
            Container(
                margin: const EdgeInsets.only(
                    top: 15, left: 10, right: 10, bottom: 20),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                            """You can also check out the source code, contribute, or explore how the app was built:"""),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                              onTap: () => launchURL(repoUrl),
                              child: const Text("View on GitHub",
                                  style: TextStyle(
                                    color: Color(0xFFF4A300),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  ),
                                  textAlign: TextAlign.left)),
                        )
                      ],
                    ),
                  ),
                )),
          ],
        ),
      ]),
    );
  }
}
