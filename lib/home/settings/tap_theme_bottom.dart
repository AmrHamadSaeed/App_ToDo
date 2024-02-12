import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../my_theme.dart';
import '../../providers/app_Config_provider.dart';

class TapThemeBottom extends StatefulWidget {
  @override
  State<TapThemeBottom> createState() => _TapThemeBottomState();
}

class _TapThemeBottomState extends State<TapThemeBottom> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ProviderConfig>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: InkWell(
            onTap: () {
              provider.changeTheme(ThemeMode.dark);
            },
            child: provider.isDarkMode()
                ? selectedItem(AppLocalizations.of(context)!.night)
                : unSelectedItem(AppLocalizations.of(context)!.night),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: InkWell(
            onTap: () {
              provider.changeTheme(ThemeMode.light);
            },
            child: provider.isDarkMode()
                ? unSelectedItem(AppLocalizations.of(context)!.light)
                : selectedItem(AppLocalizations.of(context)!.light),
          ),
        ),
      ],
    );
  }

  Widget selectedItem(String text) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text,
          style: Theme.of(context).textTheme.titleSmall!.copyWith(
                color: MyTheme.primaryColor,
              ),
        ),
        Icon(Icons.check),
      ],
    );
  }

  Widget unSelectedItem(String text) {
    return Text(
      text,
      style: Theme.of(context).textTheme.titleSmall!.copyWith(
            color: MyTheme.primaryColor,
          ),
    );
  }
}
