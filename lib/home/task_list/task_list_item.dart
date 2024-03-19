import 'package:app_to_do/firebase_utils.dart';
import 'package:app_to_do/home/task_list/editing_task.dart';
import 'package:app_to_do/model/task.dart';
import 'package:app_to_do/my_theme.dart';
import 'package:app_to_do/providers/app_Config_provider.dart';
import 'package:app_to_do/providers/list_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

import '../../providers/auth_providers.dart';

class TaskListItem extends StatelessWidget {
  Task task;

  TaskListItem({required this.task});

  late ListProvider listProvider;

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ProviderConfig>(context);
    listProvider = Provider.of<ListProvider>(context);
    var authProviders = Provider.of<AuthProviders>(context, listen: false);
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(EditingText.routeName, arguments: task);
        // listProvider.getTaskFromFireStore();
        // task = Task(dateTime: task.dateTime = DateTime.now(), description: task.description , title: task.title );
        // FirebaseUtils.udateText(task);
      },
      child: Container(
        margin: EdgeInsets.all(10),
        child: Slidable(
          // The start action pane is the one at the left or the top side.
          startActionPane: ActionPane(
            extentRatio: 0.25,
            // A motion is a widget used to control how the pane animates.
            motion: const ScrollMotion(),

            // All actions are defined in the children parameter.
            children: [
              // A SlidableAction can have an icon and/or a label.
              SlidableAction(
                borderRadius: BorderRadius.circular(25),
                onPressed: (context) {
                  FirebaseUtils.deleteTaskFromFireStore(
                          task, authProviders.currentUser!.id!)
                      .then((value) {
                    print('task deleted successfully');
                    listProvider
                        .getTaskFromFireStore(authProviders.currentUser!.id!);
                  }).timeout(Duration(milliseconds: 500), onTimeout: () {
                    print('task deleted successfully');
                    listProvider
                        .getTaskFromFireStore(authProviders.currentUser!.id!);
                  });
                },
                backgroundColor: MyTheme.redColor,
                foregroundColor: MyTheme.whiteColor,
                icon: Icons.delete,
                label: 'Delete',
              ),
            ],
          ),
          child: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: provider.isDarkMode()
                  ? MyTheme.greyDarkColor
                  : MyTheme.whiteColor,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: EdgeInsets.all(12),
                  color: task.change == true
                      ? MyTheme.greenColor
                      : MyTheme.primaryColor,
                  height: MediaQuery.of(context).size.height * 0.08,
                  width: 4,
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      task.title ?? '',
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          color: task.change == true
                              ? MyTheme.greenColor
                              : MyTheme.primaryColor),
                    ),
                    Text(task.description ?? '',
                        style: Theme.of(context).textTheme.titleSmall),
                  ],
                )),
                task.change == true
                    ? Text(
                        'Done!',
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge!
                            .copyWith(color: MyTheme.greenColor),
                      )
                    : Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width * 0.05,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: MyTheme.primaryColor,
                        ),
                        child: InkWell(
                          onTap: () {
                            if (task.change == false) {
                              FirebaseUtils.updateUser(
                                  task, authProviders.currentUser!.id!);
                              listProvider.getTaskFromFireStore(
                                  authProviders.currentUser!.id!);
                            }

                            // setState(() {
                            //
                            // });
                            print(task.change);
                            print('color change');
                          },

                          //     onTap: () {
                          //       provider.changeLanguage('en');
                          //     },
                          //     child: provider.languageApp == 'en'
                          //         ? selectedItem(AppLocalizations.of(context)!.english)
                          //         : unSelectedItem(AppLocalizations.of(context)!.english),
                          //   ),
                          // ),
                          child: Icon(
                            Icons.check,
                            color: MyTheme.whiteColor,
                            size: 30,
                          ),
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
