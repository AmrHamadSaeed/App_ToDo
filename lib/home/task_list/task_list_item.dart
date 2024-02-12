import 'package:app_to_do/my_theme.dart';
import 'package:app_to_do/providers/app_Config_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class TaskListItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ProviderConfig>(context);
    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color:
            provider.isDarkMode() ? MyTheme.greyDarkColor : MyTheme.whiteColor,
      ),
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
                AppLocalizations.of(context)!.task,
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      color: MyTheme.primaryColor,
                    ),
              ),
              Text(AppLocalizations.of(context)!.description,
                  style: Theme.of(context).textTheme.titleSmall),
            ],
              )),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.05,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
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
