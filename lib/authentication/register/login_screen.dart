import 'package:app_to_do/authentication/custom_text_form_field.dart';
import 'package:app_to_do/authentication/register/register_screen.dart';
import 'package:app_to_do/dialog_yutils.dart';
import 'package:app_to_do/firebase_utils.dart';
import 'package:app_to_do/home/home_screen.dart';
import 'package:app_to_do/my_theme.dart';
import 'package:app_to_do/providers/auth_providers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = 'login_screen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController =
      TextEditingController(text: 'amr@yahoo.com');

  TextEditingController passwordController =
      TextEditingController(text: '123456');
  bool obscureText = true;

  var formkey = GlobalKey<FormState>();

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
            backgroundColor: Colors.transparent,
            title: Text('Login'),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.23,
                ),
                Text(
                  'WelcomeBack',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
                Form(
                  key: formkey,
                  child: Column(
                    children: [
                      CustomTextFormField(
                        lableText: 'Email',
                        keyboardType: TextInputType.emailAddress,
                        controller: emailController,
                        validator: (email) {
                          if (email!.trim().isEmpty) {
                            return 'Please Enter Email';
                          }
                          bool emailValid = RegExp(
                                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(email);
                          if (!emailValid) {
                            return 'Please enter valid email';
                          }
                          return null;
                        },
                      ),
                      CustomTextFormField(
                        suffixIcon: IconButton(
                            onPressed: () {
                              // if(obscureText == true){
                              //   obscureText = false;
                              // }else{
                              //   obscureText = true;
                              // }
                              obscureText == true
                                  ? obscureText = false
                                  : obscureText = true;
                              setState(() {});
                            },
                            icon: Icon(Icons.remove_red_eye_outlined)),
                        obscureText: obscureText,
                        lableText: 'Password',
                        keyboardType: TextInputType.phone,
                        controller: passwordController,
                        validator: (password) {
                          if (password == null || password.trim().isEmpty) {
                            return 'Please Enter Password';
                          }
                          if (password.length < 6) {
                            return 'Password Should be at least  6 chars. ';
                          }
                          return null;
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black),
                          onPressed: () {
                            login();
                          },
                          child: Text('Login',
                              style: Theme.of(context).textTheme.titleLarge),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextButton(
                          onPressed: () {
                            Navigator.pushReplacementNamed(
                                context, RegisterScreen.routeName);
                          },
                          child: Text('Or Create Account',
                              style: Theme.of(context).textTheme.titleMedium),
                        ),
                      ),
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

  Future<void> login() async {
    if (formkey.currentState!.validate() == true) {
      // todo: show loading
      DialogUtils.showLoading(
          context: context, message: 'Loading...', isBarrierDismissible: false);
      // await Future.delayed(Duration(seconds: 2));
      try {
        final credential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: emailController.text, password: passwordController.text);
        var user = await FirebaseUtils.readUserFromFireStore(
            credential.user?.uid ?? '');
        if (user == null) {
          return;
        }
        var authProviders = Provider.of<AuthProviders>(context, listen: false);
        authProviders.updateUser(user);

        /// todo : hide loading
        DialogUtils.hideLoading(context);

        /// todo : show Message

        DialogUtils.showMessage(
            context: context,
            message: 'Login Successfully.',
            posActionName: 'ok',
            posAction: () {
              Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
            });
        print('Login Successfully');
        print(credential.user?.uid ?? '');
      } on FirebaseAuthException catch (e) {
        if (e.code == 'invalid-credential') {
          /// todo : hide loading
          DialogUtils.hideLoading(context);

          /// todo : show Message

          DialogUtils.showMessage(
            context: context,
            message:
                'The supplied auth credential is incorrect, malformed or has expired.',
            title: 'Error',
            posActionName: 'ok',
          );
          print(
              'The supplied auth credential is incorrect, malformed or has expired.');
        }
      } catch (e) {
        /// todo : hide loading
        DialogUtils.hideLoading(context);

        /// todo : show Message

        DialogUtils.showMessage(
          context: context,
          message: '${e.toString()}',
          title: 'Error',
          posActionName: 'ok',
        );
        print(e.toString());
      }
    }
  }
}
