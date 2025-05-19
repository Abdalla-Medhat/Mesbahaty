import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class About extends StatefulWidget {
  const About({super.key});

  @override
  State<About> createState() => _AboutState();
}

class _AboutState extends State<About> {
  // final Uri _urlPaypal =
  //     Uri.parse('https://www.paypal.com/paypalme/AbdallahMedhat99');
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
      body: Column(
        children: [
          Container(
              margin: const EdgeInsets.all(10),
              height: 415,
              width: 370,
              child: const Card(
                  child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text("""About the Developer
          
I’m a passionate developer who believes that technology can be a powerful tool to enhance spirituality and bring us closer to Allah in a modern way.
          
With that vision in mind, I created this app to be your daily companion for Tasbeeh and remembrance, anytime and anywhere — in a simple, user-friendly, and contemporary style.
          
I'm always striving to deliver digital experiences that blend benefit with ease, and I welcome any suggestions that help improve and grow this app.
          
          — Abdullah Medhat"""),
              ))),
          const SizedBox(
            height: 10,
          ),
          Container(
              margin: const EdgeInsets.all(10),
              height: 100,
              width: 370,
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                          """You can also check out the source code, contribute, or explore how the app was built:"""),
                      InkWell(
                          onTap: () => launchURL(repoUrl),
                          child: const Text("View on GitHub",
                              style: TextStyle(
                                color: Colors.orange,
                                fontSize: 15,
                              ),
                              textAlign: TextAlign.left))
                    ],
                  ),
                ),
              )),
        ],
      ),
    );
  }
}
