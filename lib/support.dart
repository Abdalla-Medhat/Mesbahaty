import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Support extends StatefulWidget {
  const Support({super.key});

  @override
  State<Support> createState() => _SupportState();
}

class _SupportState extends State<Support> {
  final Uri _paypalUrl =
      Uri.parse('https://www.paypal.com/paypalme/AbdallahMedhat99');
  Future<void> launchURL(Uri url) async {
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Support us"),
      ),
      body: Column(
        children: [
          Container(
              margin: const EdgeInsets.all(10),
              height: 335,
              width: 370,
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                          """If you find this app helpful and would like to support its continued development, you can do so through PayPal or any other future support method I may provide.
                
Your contribution — no matter how small — helps me stay motivated and keep delivering meaningful tools that blend technology with spiritual benefit.
                
Thank you for your kindness and support:
"""),
                      InkWell(
                          onTap: () => launchURL(_paypalUrl),
                          child: Text(
                            "Support me on PayPal",
                            style: TextStyle(
                                fontSize: 15,
                                color: Colors.orange,
                                decoration: TextDecoration.underline,
                                decorationColor: Colors.orange[600],
                                fontWeight: FontWeight.bold),
                          )),
                    ],
                  ),
                ),
              )),
        ],
      ),
    );
  }
}
