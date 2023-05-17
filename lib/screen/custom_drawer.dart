import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:url_launcher/url_launcher.dart';

import '../screen/about_page.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);

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
              "Source code",
              style: TextStyle(
                  fontSize: 16,
                  color: Theme.of(context).colorScheme.secondary,
                  fontFamily: 'Arial'),
            ),
            subtitle: Text(
              "Github link",
              style: TextStyle(
                color: Theme.of(context).colorScheme.secondary,
                fontWeight: FontWeight.bold,
                fontFamily: 'Arial',
              ),
            ),
            onTap: () async {
              final Uri url = Uri.parse(
                  'https://github.com/VikramadityaDev/text_to_image_gen/');
              if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
                throw Exception('Could not launch $url');
              }
            },
          ),
          ListTile(
            leading: const Icon(Iconsax.refresh_circle),
            title: Text(
              "Check for update",
              style: TextStyle(
                  fontSize: 16,
                  color: Theme.of(context).colorScheme.secondary,
                  fontFamily: 'Arial'),
            ),
            subtitle: Text(
              "Check releases",
              style: TextStyle(
                color: Theme.of(context).colorScheme.secondary,
                fontWeight: FontWeight.bold,
                fontFamily: 'Arial',
              ),
            ),
            onTap: () async {
              final Uri url = Uri.parse(
                  'https://github.com/VikramadityaDev/text_to_image_gen/releases/');
              if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
                throw Exception('Could not launch $url');
              }
            },
          ),
          ListTile(
            leading: const Icon(
              Iconsax.sms_tracking,
            ),
            title: Text(
              "Join us on telegram",
              style: TextStyle(
                  fontSize: 16,
                  color: Theme.of(context).colorScheme.secondary,
                  fontFamily: 'Arial'),
            ),
            subtitle: Text(
              "For more new apps",
              style: TextStyle(
                color: Theme.of(context).colorScheme.secondary,
                fontWeight: FontWeight.bold,
                fontFamily: 'Arial',
              ),
            ),
            onTap: () async {
              final Uri url =
                  Uri.parse('https://telegram.me/vikimediaofficial/');
              if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
                throw Exception('Could not launch $url');
              }
            },
          ),
          ListTile(
            leading: const Icon(Iconsax.info_circle),
            title: Text(
              "About",
              style: TextStyle(
                  fontSize: 16,
                  color: Theme.of(context).colorScheme.secondary,
                  fontFamily: 'Arial'),
            ),
            subtitle: Text(
              "About this project",
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
          ListTile(
            leading: const Icon(
              Iconsax.verify,
            ),
            title: Text(
              "</> & Crafted with 💛",
              style: TextStyle(
                  fontSize: 16,
                  color: Theme.of(context).colorScheme.secondary,
                  fontFamily: 'Arial'),
            ),
            subtitle: Text(
              "VikramadityaDev & DJ-Yacine",
              style: TextStyle(
                color: Theme.of(context).colorScheme.secondary,
                fontWeight: FontWeight.bold,
                fontFamily: 'Arial',
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Text(
                  'v1.0.5',
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
