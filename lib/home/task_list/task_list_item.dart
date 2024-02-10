import 'package:app_to_do/my_theme.dart';
import 'package:flutter/material.dart';

class TaskListItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15), color: MyTheme.whiteColor),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            margin: EdgeInsets.all(12),
            color: MyTheme.primaryColor,
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
                'Task',
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      color: MyTheme.primaryColor,
                    ),
              ),
              Text('Des', style: Theme.of(context).textTheme.titleSmall),
            ],
          )),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 10,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: MyTheme.primaryColor,
            ),
            child: Icon(
              Icons.check,
              color: MyTheme.whiteColor,
              size: 30,
            ),
          ),
        ],
      ),
    );
  }
}
