import 'package:app_to_do/home/settings/settings_tap.dart';
import 'package:app_to_do/home/task_list/add_task_bottom_sheet.dart';
import 'package:app_to_do/home/task_list/task_list_tap.dart';
import 'package:app_to_do/my_theme.dart';
import 'package:app_to_do/providers/list_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../authentication/register/login_screen.dart';
import '../providers/auth_providers.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = 'Home_Screen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    var authProviders = Provider.of<AuthProviders>(context, listen: false);
    var listProvider = Provider.of<ListProvider>(context);
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: MediaQuery.of(context).size.height * 0.20,
        title: Text(
          """${AppLocalizations.of(context)!.app_title} : ${authProviders.currentUser!.name} """,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        actions: [
          IconButton(
              onPressed: () {
                if (listProvider.taskList.isEmpty) {
                  Navigator.pushReplacementNamed(
                      context, LoginScreen.routeName);
                } else {
                  listProvider.taskList = [];
                  authProviders.currentUser = null;
                  Navigator.pushReplacementNamed(
                      context, LoginScreen.routeName);
                }
              },
              icon: Icon(Icons.login)),
        ],
      ),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(canvasColor: Colors.red),
        child: BottomAppBar(
          notchMargin: 7,
          child: BottomNavigationBar(
            currentIndex: selectedIndex,
            onTap: (index) {
              selectedIndex = index;
              setState(() {});
            },
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.list),
                label: AppLocalizations.of(context)!.task_list,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: AppLocalizations.of(context)!.settings,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Container(
        decoration: BoxDecoration(shape: BoxShape.circle, boxShadow: [
          BoxShadow(
            color: MyTheme.greyColor,
            blurRadius: 7,
          )
        ]),
        child: FloatingActionButton(
          onPressed: () {
            showAddTaskBottomShee();
          },
          child: Icon(
            Icons.add,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: selectedIndex == 0 ? TaskListTap() : SettingsTap(),
    );
  }

  void showAddTaskBottomShee() {
    showModalBottomSheet(
        context: context, builder: (context) => AddTaskBottomSheet());
  }
}
