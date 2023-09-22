import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../palette.dart';
import '../../utils/routes/routes_name.dart';
import '../../utils/utils.dart';
import '../../widgets/custom_text_form_field.dart';
import '../../widgets/round_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final _auth = FirebaseAuth.instance;

  bool loading = false;

  // sign in with phone and password
  void login() {
    setState(() {
      loading = true;
    });
    _auth
        .signInWithEmailAndPassword(
      email: emailController.text.toString(),
      password: passwordController.text.toString(),
    )
        .then((value) {
      setState(() {
        loading = false;
      });
      Navigator.pushNamed(context, RouteName.homeScreen);
      Utils().toastMessage("Signed in as ${emailController.text}", context);
    }).onError((error, stackTrace) {
      debugPrint(error.toString());
      setState(() {
        loading = false;
      });
      Utils().toastMessage(error.toString(), context);
    });
  }

  // sign in with google
  Future<void> signInWithGoogle() async {
    setState(() {
      loading = false;
    });
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      if (googleAuth?.accessToken != null && googleAuth?.idToken != null) {
        setState(() {
          loading = false;
        });
        //create a new credential
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken,
          idToken: googleAuth?.idToken,
        );
        UserCredential userCredential =
            await _auth.signInWithCredential(credential);
        if (userCredential.user != null) {
          Navigator.pushNamed(context, RouteName.homeScreen);
          Utils().toastMessage(
              "Signed in as " + googleUser!.email.toString(), context);
        }
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        loading = false;
      });
      Utils().toastMessage(e.toString(), context);
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return true;
      },
      child: SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: MediaQuery.sizeOf(context).height * 0.15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          bottom: 40,
                        ),
                        child: Text(
                          "Sign In",
                          style: GoogleFonts.poppins(
                            fontSize: 35,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 1.5,
                            color: Palette.blackColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        //email text form field
                        CustomTextFormField(
                          controller: emailController,
                          hintText: "Enter your E-mail",
                          icon: Icons.alternate_email_outlined,
                          keyboardType: TextInputType.emailAddress,
                          obscureText: false,
                          validatorText: "Enter E-mail",
                        ),
                        SizedBox(
                          height: MediaQuery.sizeOf(context).height * 0.02,
                        ),
                        //password text form field
                        CustomTextFormField(
                          controller: passwordController,
                          hintText: "Enter your password",
                          icon: Icons.key_outlined,
                          keyboardType: TextInputType.text,
                          obscureText: true,
                          validatorText: "Enter password",
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.sizeOf(context).height * 0.05,
                  ),
                  RoundButton(
                    loading: loading,
                    showImage: false,
                    borderColor: Palette.turquoiseColor,
                    buttonColor: Palette.turquoiseColor,
                    width: 0,
                    textColor: Palette.whiteColor,
                    title: "SIGN IN",
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        login();
                      }
                    },
                  ),
                  Row(
                    children: [
                      Text(
                        "Don't have an account ?",
                        style: GoogleFonts.poppins(
                            fontSize: 13,
                            fontWeight: FontWeight.w200,
                            color: Palette.greyColour),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, RouteName.signupScreen);
                        },
                        child: Text(
                          "Sign up",
                          style: GoogleFonts.poppins(
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                              color: Palette.turquoiseColor),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.sizeOf(context).height * 0.03,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                            margin:
                                const EdgeInsets.only(left: 10.0, right: 15.0),
                            child: const Divider(
                              color: Palette.lightGreyColour,
                              height: 50,
                            )),
                      ),
                      Text(
                        "OR",
                        style: GoogleFonts.poppins(
                          color: Palette.greyColour,
                          fontSize: 14,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      Expanded(
                        child: Container(
                            margin:
                                const EdgeInsets.only(left: 15.0, right: 10.0),
                            child: const Divider(
                              color: Palette.lightGreyColour,
                              height: 50,
                            )),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.sizeOf(context).height * 0.04,
                  ),
                  RoundButton(
                    showImage: true,
                    title: "Sign in with Google",
                    onTap: signInWithGoogle,
                    width: 0.7,
                    textColor: Palette.lightGreyColour,
                    buttonColor: Theme.of(context).scaffoldBackgroundColor,
                    borderColor: Palette.lightGreyColour,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
