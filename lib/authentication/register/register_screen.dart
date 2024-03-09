import 'package:app_to_do/authentication/custom_text_form_field.dart';
import 'package:app_to_do/authentication/login/login_screen.dart';
import 'package:app_to_do/dialog_yutils.dart';
import 'package:app_to_do/firebase_utils.dart';
import 'package:app_to_do/home/home_screen.dart';
import 'package:app_to_do/model/my_user.dart';
import 'package:app_to_do/my_theme.dart';
import 'package:app_to_do/providers/auth_providers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  static const String routeName = 'register_screen';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController nameController = TextEditingController(text: 'amr');

  TextEditingController emailController =
      TextEditingController(text: 'amr@yahoo.com');

  TextEditingController passwordController =
      TextEditingController(text: '123456');

  TextEditingController confirmPasswordController =
      TextEditingController(text: '123456');

  var formkey = GlobalKey<FormState>();
  bool obscureText = true;
  bool obscureText1 = true;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: MyTheme.whiteColor,
          child: Image.asset(
            'assets/images/main_background.png',
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.fill,
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            leading: BackButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, LoginScreen.routeName);
              },
            ),
            backgroundColor: Colors.transparent,
            title: Text(AppLocalizations.of(context)!.create_account),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.23,
                ),
                Form(
                  key: formkey,
                  child: Column(
                    children: [
                      CustomTextFormField(
                        lableText: AppLocalizations.of(context)!.user_name,
                        controller: nameController,
                        validator: (name) {
                          if (name == null || name.trim().isEmpty) {
                            return AppLocalizations.of(context)!
                                .please_enter_user_name;
                          }
                          return null;
                        },
                      ),
                      CustomTextFormField(
                        lableText: AppLocalizations.of(context)!.email_address,
                        keyboardType: TextInputType.emailAddress,
                        controller: emailController,
                        validator: (email) {
                          if (email!.trim().isEmpty) {
                            return AppLocalizations.of(context)!
                                .please_enter_email;
                          }
                          bool emailValid = RegExp(
                                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(email);
                          if (!emailValid) {
                            return AppLocalizations.of(context)!
                                .please_enter_valid_email;
                          }
                          return null;
                        },
                      ),
                      CustomTextFormField(
                        suffixIcon: InkWell(
                            onTap: () {
                              obscureText == true
                                  ? obscureText = false
                                  : obscureText = true;
                              setState(() {});
                            },
                            child: Icon(
                              Icons.remove_red_eye,
                            )),
                        obscureText: obscureText,
                        lableText: AppLocalizations.of(context)!.password,
                        keyboardType: TextInputType.phone,
                        controller: passwordController,
                        validator: (password) {
                          if (password == null || password.trim().isEmpty) {
                            return AppLocalizations.of(context)!
                                .please_enter_password;
                          }
                          if (password.length < 6) {
                            return AppLocalizations.of(context)!
                                .password_should;
                          }
                          return null;
                        },
                      ),
                      CustomTextFormField(
                        obscureText: obscureText1,
                        lableText:
                            AppLocalizations.of(context)!.confirm_password,
                        keyboardType: TextInputType.phone,
                        controller: confirmPasswordController,
                        validator: (confirm) {
                          if (confirm == null || confirm.trim().isEmpty) {
                            return AppLocalizations.of(context)!
                                .please_enter_confirmPassword;
                          }
                          if (confirm != passwordController.text) {
                            return AppLocalizations.of(context)!
                                .invalid_confirmPassword;
                          }
                          return null;
                        },
                        suffixIcon: InkWell(
                            onTap: () {
                              obscureText1 == true
                                  ? obscureText1 = false
                                  : obscureText1 = true;
                              setState(() {});
                            },
                            child: Icon(
                              Icons.remove_red_eye,
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black),
                          onPressed: () {
                            register();
                          },
                          child: Text(
                              AppLocalizations.of(context)!.create_account,
                              style: Theme.of(context).textTheme.titleLarge),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void register() async {
    if (formkey.currentState!.validate() == true) {
      /// register
      /// todo: show loading
      DialogUtils.showLoading(
          context: context,
          message: AppLocalizations.of(context)!.loading,
          isBarrierDismissible: false);
      // await Future.delayed(Duration(seconds: 2));
      print('hello amr welcome');
      try {
        final credential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        print('hello amr welcome');
        MyUser myUser = MyUser(
            id: credential.user?.uid ?? '',
            name: nameController.text,
            email: emailController.text);
        await FirebaseUtils.addUserToFireStore(myUser);
        var authProviders = Provider.of<AuthProviders>(context, listen: false);
        authProviders.updateUser(myUser);

        /// todo : hide loading
        DialogUtils.hideLoading(context);

        /// todo : show Message

        DialogUtils.showMessage(
            context: context,
            message: AppLocalizations.of(context)!.register_successfully,
            posActionName: AppLocalizations.of(context)!.ok,
            posAction: () {
              Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
            });
        print('register successfully');
        print(credential.user?.uid ?? '');
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          /// todo : hide loading
          DialogUtils.hideLoading(context);

          /// todo : show Message

          DialogUtils.showMessage(
            context: context,
            message: AppLocalizations.of(context)!.too_weak,
            title: AppLocalizations.of(context)!.error,
            posActionName: AppLocalizations.of(context)!.error,
          );
          print('The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          /// todo : hide loading
          DialogUtils.hideLoading(context);

          /// todo : show Message

          DialogUtils.showMessage(
            context: context,
            message: AppLocalizations.of(context)!.already_exists,
            title: AppLocalizations.of(context)!.error,
            posActionName: AppLocalizations.of(context)!.ok,
          );
          print('The account already exists for that email.');
        }
      } catch (e) {
        /// todo : hide loading
        DialogUtils.hideLoading(context);

        /// todo : show Message

        DialogUtils.showMessage(
          context: context,
          message: '${e.toString()}',
          title: AppLocalizations.of(context)!.error,
          posActionName: AppLocalizations.of(context)!.ok,
        );
        print(e);
      }
    }
  }
}
