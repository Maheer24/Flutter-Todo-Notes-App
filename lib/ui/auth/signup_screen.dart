import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../palette.dart';
import '../../utils/routes/routes_name.dart';
import '../../utils/utils.dart';
import '../../widgets/custom_text_form_field.dart';
import '../../widgets/round_button.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool loading = false;
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final _auth = FirebaseAuth.instance;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  void signUp() {
    setState(() {
      loading = true;
    });
    _auth
        .createUserWithEmailAndPassword(
      email: emailController.text.toString(),
      password: passwordController.text.toString(),
    )
        .then((value) {
      setState(() {
        loading = false;
      });
      Navigator.pushNamed(context, RouteName.homeScreen);
      Utils().toastMessage("Signed up successfully", context);
    }).onError((error, stackTrace) {
      setState(() {
        loading = false;
      });
      Utils().toastMessage(error.toString(), context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 15).copyWith(
            top: 30,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //SizedBox(height: MediaQuery.sizeOf(context).height * 0.1),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      bottom: 40,
                    ),
                    child: Text(
                      "Sign Up",
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
                title: "SIGN UP",
                textColor: Palette.whiteColor,
                borderColor: Palette.turquoiseColor,
                buttonColor: Palette.turquoiseColor,
                width: 0,
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    signUp();
                  }
                },
              ),
              Row(
                children: [
                  Text(
                    "Already have an account ?",
                    style: GoogleFonts.poppins(
                        fontSize: 13,
                        fontWeight: FontWeight.w200,
                        color: Palette.greyColour),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, RouteName.loginScreen);
                    },
                    child: Text(
                      "Sign in",
                      style: GoogleFonts.poppins(
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                          color: Palette.turquoiseColor),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.04,
              ),

              ///---
              SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.04,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
