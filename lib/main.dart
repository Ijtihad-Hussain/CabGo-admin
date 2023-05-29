import 'package:cab_go_admin/utils/button.dart';
import 'package:cab_go_admin/utils/customTextFormField.dart';
import 'package:cab_go_admin/utils/firebase_services.dart';
import 'package:cab_go_admin/home_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyBIf_jgj9w56EEe064dbgOPMmRU2MnGOgo",
          authDomain: "cabgo-user.firebaseapp.com",
          projectId: "cabgo-user",
          storageBucket: "cabgo-user.appspot.com",
          messagingSenderId: "363027437872",
          appId: "1:363027437872:web:ef3458a496c75adc9950f5",
          measurementId: "G-TG17XYKSBY"));
  runApp(
    ScreenUtilInit(
      builder: (context, _) => MyApp(),
      designSize: const Size(375, 812),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Taxi Admin',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:
          // WebHomeScreen(),
          LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  bool obsText = true;
  TextEditingController emailC = TextEditingController();
  TextEditingController passwordC = TextEditingController();
  bool formStateLoading = false;
  String email = 'eusestaxi1@gmail.com';
  String password = 'Amraajladulibaci01';

  void toggle() {
    setState(() {
      obsText = !obsText;
    });
  }

  Future<void> ecoDialogue(String error) async {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: Text(error),
            actions: [
              Button(
                buttonText: 'CLOSE',
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }

  submit(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      if (emailC.text == email && passwordC.text == password) {
        setState(() {
          formStateLoading = true;
        });

        String? accountstatus =
            await FirebaseServices.signInAccount(emailC.text, passwordC.text);

        // print(accountstatus);
        if (accountstatus != null) {
          ecoDialogue(accountstatus);
          setState(() {
            formStateLoading = false;
          });
        } else {
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => WebHomeScreen()));
        }
      }
    }
  }

  @override
  void dispose() {
    emailC.dispose();
    passwordC.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(2),
        // padding: EdgeInsets.symmetric(
        //   horizontal: 20.w
        // ),
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          // decoration: PageDecoration.pageDecoration,
          padding: const EdgeInsets.symmetric(vertical: 120),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: Column(
                  children: [
                    const Text(
                      'Welcome Admin',
                      style: TextStyle(
                          color: Colors.black87,
                          fontFamily: 'Rubik',
                          fontWeight: FontWeight.w600,
                          fontSize: 24),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    CustomTextFormField(
                      validate: (v) {
                        if (v!.isEmpty) {
                          return "Email can't be empty";
                        }
                        return null;
                      },
                      width: double.infinity,
                      hintText: 'Email...',
                      controller: emailC,
                      border: const OutlineInputBorder(),
                    ),
                    CustomTextFormField(
                      hintText: 'Password...',
                      controller: passwordC,
                      validate: (v) {
                        if (v!.isEmpty) {
                          return "password can not be empty";
                        }
                        return null;
                      },
                      suffixIcon: IconButton(
                        icon: obsText == false
                            ? const Icon(Icons.visibility)
                            : const Icon(Icons.visibility_off),
                        onPressed: toggle,
                      ),
                      obscureText: obsText,
                      width: double.infinity,
                      border: const OutlineInputBorder(),
                    ),
                    Button(
                      // color: kInGreen,
                      isLoading: formStateLoading,
                      buttonText: 'Log In',
                      width: 180,
                      onPressed: () {
                        submit(context);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
