import 'package:app_to_do/home/task_list/task_list_item.dart';
import 'package:app_to_do/my_theme.dart';
import 'package:app_to_do/providers/app_Config_provider.dart';
import 'package:app_to_do/providers/list_provider.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/auth_providers.dart';

class TaskListTap extends StatefulWidget {
  @override
  State<TaskListTap> createState() => _TaskListTapState();
}

class _TaskListTapState extends State<TaskListTap> {
  @override
  Widget build(BuildContext context) {
    var listProvider = Provider.of<ListProvider>(context);
    var authProviders = Provider.of<AuthProviders>(context, listen: false);
    if (listProvider.taskList.isEmpty) {
      listProvider.getTaskFromFireStore(authProviders.currentUser!.id!);
    }
    // for (var obj in listProvider.taskList) {
    //   print("Name: ${obj.title}, Age: ${obj.isDone}");
    // }

    ProviderConfig provider = Provider.of<ProviderConfig>(context);
    return Container(
      child: Column(
        children: [
          EasyDateTimeLine(
            onDateChange: (date) {
              listProvider.changeSelectedDate(
                  date, authProviders.currentUser!.id!);
            },
            initialDate: listProvider.selectedDate,
            activeColor: provider.isDarkMode()
                ? MyTheme.whiteColor
                : MyTheme.greyDarkColor,
            dayProps: EasyDayProps(
              todayHighlightStyle: TodayHighlightStyle.withBackground,
              inactiveDayStyle: DayStyle(
                  dayStrStyle: TextStyle(
                      color: provider.isDarkMode()
                          ? MyTheme.whiteColor
                          : MyTheme.blackColor),
                  monthStrStyle: TextStyle(
                      color: provider.isDarkMode()
                          ? MyTheme.whiteColor
                          : MyTheme.blackColor),
                  dayNumStyle: TextStyle(
                      color: provider.isDarkMode()
                          ? MyTheme.whiteColor
                          : MyTheme.blackColor),
                  decoration: BoxDecoration(
                      color: provider.isDarkMode()
                          ? MyTheme.greyDarkColor
                          : MyTheme.whiteColor,
                      borderRadius: BorderRadius.circular(12))),
            ),
            locale: provider.languageApp,
          ),
          // CalendarTimeline(
          //   initialDate: DateTime.now(),
          //   firstDate: DateTime.now().subtract(Duration(days: 365)),
          //   lastDate: DateTime.now().add(Duration(days: 365)),
          //   onDateSelected: (date) => print(date),
          //   leftMargin: 20,
          //   monthColor: MyTheme.blackColor,
          //   dayColor: MyTheme.blackColor,
          //   activeDayColor: MyTheme.whiteColor,
          //   activeBackgroundDayColor: MyTheme.primaryColor,
          //   dotsColor: MyTheme.whiteColor,
          //   selectableDayPredicate: (date) => date.day != 23,
          //
          //   /// or true
          //   locale: 'en_ISO',
          // ),
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) {
                return TaskListItem(
                  task: listProvider.taskList[index],
                );
              },
              itemCount: listProvider.taskList.length,
            ),
          ),
        ],
      ),
    );
  }
}
