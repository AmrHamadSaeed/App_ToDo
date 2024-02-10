import 'package:app_to_do/my_theme.dart';
import 'package:flutter/material.dart';

class SettingsTap extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Language',
            style: Theme.of(context).textTheme.titleSmall,
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: MyTheme.whiteColor,
                border: Border.all(color: MyTheme.primaryColor),
              ),
              child: InkWell(
                onTap: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'English',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    Icon(Icons.keyboard_arrow_down_sharp),
                  ],
                ),
              ),
            ),
          ),
          Text(
            'Mode',
            style: Theme.of(context).textTheme.titleSmall,
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: MyTheme.whiteColor,
                border: Border.all(color: MyTheme.primaryColor),
              ),
              child: InkWell(
                onTap: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Light',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    Icon(Icons.keyboard_arrow_down_sharp),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
