import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:cookbook/router_names.dart';
import 'package:cookbook/app_config.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Color.fromRGBO(31, 137, 39, 1),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Icon(
                  Icons.restaurant_menu,
                  size: 48,
                  color: Colors.white,
                ),
                const SizedBox(height: 12),
                const Text(
                  'Personal Cookbook',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (AppConfig.isDev)
                  const Padding(
                    padding: EdgeInsets.only(top: 4.0),
                    child: Text(
                      'DEV MODE',
                      style: TextStyle(
                        color: Colors.orange,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () {
              context.pop(); // Close drawer
              context.goNamed(RouteNames.home);
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () {
              context.pop(); // Close drawer
              context.pushNamed(RouteNames.settings);
            },
          ),
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text('About'),
            onTap: () {
              context.pop(); // Close drawer
              context.pushNamed(RouteNames.about);
            },
          ),
        ],
      ),
    );
  }
}
