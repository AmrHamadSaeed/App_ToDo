import 'package:app_to_do/firebase_utils.dart';
import 'package:app_to_do/model/task.dart';
import 'package:app_to_do/my_theme.dart';
import 'package:app_to_do/providers/app_Config_provider.dart';
import 'package:app_to_do/providers/list_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../dialog_yutils.dart';
import '../../providers/auth_providers.dart';

class EditingText extends StatefulWidget {
  static const String routeName = 'Editing_text';

  @override
  State<EditingText> createState() => _EditingTextState();
}

class _EditingTextState extends State<EditingText> {
  late ListProvider listProvider;

  var formKey = GlobalKey<FormState>();

  var selectedDate = DateTime.now();
  TextEditingController titleCon = TextEditingController();
  TextEditingController descriptionCon = TextEditingController();

  var id;

  // var datetime;
  late AuthProviders authProviders;

  @override
  Widget build(BuildContext context) {
    authProviders = Provider.of<AuthProviders>(context, listen: false);
    var provider = Provider.of<ProviderConfig>(context);
    listProvider = Provider.of<ListProvider>(context);
    var args = ModalRoute.of(context)!.settings.arguments as Task;
    titleCon.text = args.title!;
    descriptionCon.text = args.description!;
    id = args.id!;
    print("AAA" + args.title!);
    return Material(
      color: MyTheme.primaryColor,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(70)),
          border: Border.all(color: Colors.blue, width: 3),
        ),
        margin: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 100,
              ),
              Text(
                AppLocalizations.of(context)!.add_new_task,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleSmall,
              ),
              Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextFormField(
                        controller: titleCon,
                        style: TextStyle(
                            color: provider.isDarkMode()
                                ? MyTheme.whiteColor
                                : MyTheme.blackColor),
                        validator: (text) {
                          if (text == null || text.isEmpty) {
                            return AppLocalizations.of(context)!
                                .error_task_title;
                          }

                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: AppLocalizations.of(context)!.task_title,
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: MyTheme.greyColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextFormField(
                        controller: descriptionCon,
                        style: TextStyle(
                            color: provider.isDarkMode()
                                ? MyTheme.whiteColor
                                : MyTheme.blackColor),
                        validator: (text) {
                          if (text == null || text.trim().isEmpty) {
                            return AppLocalizations.of(context)!
                                .error_task_description;
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText:
                          AppLocalizations.of(context)!.description_title,
                          hintStyle:
                          Theme.of(context).textTheme.titleMedium!.copyWith(
                            color: MyTheme.colorInput,
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: MyTheme.greyColor),
                          ),
                        ),
                        maxLines: 4,
                      ),
                    ),
                    Text(
                      AppLocalizations.of(context)!.select_date,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Center(
                      child: InkWell(
                        onTap: () {
                          showCalendarPicker();
                        },
                        child: Text(
                          DateFormat(
                            'dd-MM-yyyy ',
                          ).format(selectedDate == args.dateTime
                              ? args.dateTime!
                              : selectedDate),
                          // '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(fontWeight: FontWeight.w400),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: TextButton(
                        onPressed: () {
                          checkTask();
                        },
                        child: Text('Save Changes'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showCalendarPicker() async {
    var chosenDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 365)));
    if (chosenDate != null) {
      selectedDate = chosenDate;
      setState(() {});
    }
  }

  void checkTask() {
    if (formKey.currentState!.validate() == true) {
      /// create object from class Task to found var

      Task task = Task(
        dateTime: selectedDate,
        description: descriptionCon.text,
        title: titleCon.text,
        id: id,
      );
      print(
          'title =${task.title} description = ${task.description} datetime = ${task.dateTime}id = ${task.id} ');
      Navigator.pop(context);

      FirebaseUtils.udateText(task, authProviders.currentUser!.id!)
          .then((value) {
        print('task added successfully');
        listProvider.getTaskFromFireStore(authProviders.currentUser!.id!);
        DialogUtils.showMessage(
          context: context,
          message: 'task added successfully',
        );
      }).timeout(Duration(milliseconds: 500), onTimeout: () {
        /// alert dialog -- tosk -- snakbar  // 8.00 offline
        print('task added successfully');
        listProvider.getTaskFromFireStore(authProviders.currentUser!.id!);
      });
    }
  }
}
