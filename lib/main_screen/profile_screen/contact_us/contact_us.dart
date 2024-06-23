import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:study_stats/global_comonents/custom_button_tile.dart';
import 'package:study_stats/global_comonents/custom_messageHandler.dart';
import 'package:study_stats/settings/constants.dart';

class ContactUs extends StatefulWidget {
  const ContactUs({key});

  @override
  State<ContactUs> createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  static const _channel = MethodChannel("flutter_launcher_plus");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Contact us'),
        actions: [
          Image.asset(
            'assets/image/Star.png',
          ),
          Constants.gap(width: 20)
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            ButtonTile(
              title: "View our website",
              leading: Icon(Icons.web),
              traling: Icon(Icons.chevron_right),
              onTap: () async {
                var url = "gdsc.community.dev/babcock-university";

                print(url);
                try {
                  if (!url.contains('https') || !url.contains('http')) {
                    url = 'https:' + url;
                  }

                  await _channel.invokeMethod(
                    'launchUrl',
                    <String, String>{'website_url': url},
                  );
                } catch (e) {
                  print(e.toString());

                  MyMessageHandler.showSnackBar(context, "Unable to open link");
                }
              },
            ),
            ButtonTile(
              title: "Join Us",
              leading: Icon(Icons.join_full),
              traling: Icon(Icons.chevron_right),
              onTap: () async {
                var url = "chat.whatsapp.com/HFalfCnfQXT5w0MhHYHjHi";

                print(url);
                try {
                  if (!url.contains('https') || !url.contains('http')) {
                    url = 'https:' + url;
                  }

                  await _channel.invokeMethod(
                    'launchUrl',
                    <String, String>{'website_url': url},
                  );
                } catch (e) {
                  print(e.toString());

                  MyMessageHandler.showSnackBar(context, "Unable to open link");
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
