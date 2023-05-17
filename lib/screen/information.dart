import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:url_launcher/url_launcher.dart';

import '../screen/about_page.dart';

class Info extends StatelessWidget {
  const Info({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            child: Center(
              child: Image.asset('assets/images/a.png'),
            ),
          ),
          ListTile(
            leading: const Icon(Iconsax.hierarchy_2),
            title: Text(
              "Mã nguồn",
              style: TextStyle(
                  fontSize: 16,
                  color: Theme.of(context).colorScheme.secondary,
                  fontFamily: 'Arial'),
            ),
            subtitle: Text(
              "Link Github",
              style: TextStyle(
                color: Theme.of(context).colorScheme.secondary,
                fontWeight: FontWeight.bold,
                fontFamily: 'Arial',
              ),
            ),
            onTap: () async {
              final Uri url = Uri.parse(
                  'https://github.com/LeeDuonng/ImageAI');
              if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
                throw Exception('Could not launch $url');
              }
            },
          ),

          ListTile(
            leading: const Icon(Iconsax.info_circle),
            title: Text(
              "Giới thiệu",
              style: TextStyle(
                  fontSize: 16,
                  color: Theme.of(context).colorScheme.secondary,
                  fontFamily: 'Arial'),
            ),
            subtitle: Text(
              "Thông tin về dự án",
              style: TextStyle(
                color: Theme.of(context).colorScheme.secondary,
                fontWeight: FontWeight.bold,
                fontFamily: 'Arial',
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AboutPage(),
                ),
              );
            },
          ),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Text(
                  'v1.0.0',
                  style: TextStyle(
                      fontSize: 16,
                      color: Theme.of(context).colorScheme.secondary,
                      fontFamily: 'Arial'),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
