import 'package:app_to_do/home/settings/tap_language_bottom.dart';
import 'package:app_to_do/home/settings/tap_theme_bottom.dart';
import 'package:app_to_do/my_theme.dart';
import 'package:app_to_do/providers/app_Config_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class SettingsTap extends StatefulWidget {
  // savePrefs ()async{
  //   SharedPreferences prefs =await SharedPreferences.getInstance();
  //   prefs.setString('en', 'en');
  //   print('success perfs');
  // }
  @override
  State<SettingsTap> createState() => _SettingsTapState();
}

class _SettingsTapState extends State<SettingsTap> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ProviderConfig>(context);
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context)!.language,
            style: Theme.of(context).textTheme.titleMedium,
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
                onTap: () {
                  showLanguageBottom();
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      provider.languageApp == 'en'
                          ? AppLocalizations.of(context)!.english
                          : AppLocalizations.of(context)!.arabic,
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall!
                          .copyWith(color: MyTheme.primaryColor),
                    ),
                    Icon(Icons.keyboard_arrow_down_sharp),
                  ],
                ),
              ),
            ),
          ),
          Text(
            AppLocalizations.of(context)!.mode,
            style: Theme.of(context).textTheme.titleMedium,
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
                onTap: () {
                  showThemeBottom();
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      provider.isDarkMode()
                          ? AppLocalizations.of(context)!.night
                          : AppLocalizations.of(context)!.light,
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall!
                          .copyWith(color: MyTheme.primaryColor),
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

  void showLanguageBottom() {
    // SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    // sharedPreferences.setString('en','amr');
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return TapLanguageBottom();
        });
  }

  void showThemeBottom() {
    showModalBottomSheet(
        context: context, builder: (context) => TapThemeBottom());
  }
}
