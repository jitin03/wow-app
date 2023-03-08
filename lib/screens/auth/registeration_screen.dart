import 'package:flutter/material.dart';
import 'package:maven_class/model/registration_request_model.dart';
import 'package:maven_class/services/auth_service.dart';
import 'package:maven_class/utils/config.dart';
import 'package:maven_class/utils/images.dart';
import 'package:snippet_coder_utils/FormHelper.dart';

import '../provider/provider_profile_setup.dart';

class ProviderRegistrationScreen extends StatefulWidget {
  @override
  State<ProviderRegistrationScreen> createState() =>
      _ProviderRegistrationScreenState();
}

class _ProviderRegistrationScreenState
    extends State<ProviderRegistrationScreen> {
  bool isApiCallProcess = false;
  bool hidePassword = true;
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  RegistrationRequest registrationRequest = new RegistrationRequest();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
            child: Center(
          child: Form(
            key: formkey,
            child: SingleChildScrollView(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: primaryColor),
                    child: Image.asset(profile,
                        height: 80, width: 80, color: Colors.white),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    child: Text(
                      "Create your account for better experience!",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: "Work Sans",
                        fontSize: 16,
                        color: Color(0XFF6C757D),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  SizedBox(height: 32),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Color(0XFFF6F7F9),
                          border: Border.all(color: Color(0XFF6F7F9)),
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: TextFormField(
                          onChanged: (input) =>
                              registrationRequest.firstname = input,
                          decoration: InputDecoration(
                              suffixIcon: Align(
                                widthFactor: 1.0,
                                heightFactor: 1.0,
                                child: Image.asset(profile,
                                    height: 20,
                                    width: 20,
                                    color: Color(0xFF6C757D)),
                              ),
                              border: InputBorder.none,
                              hintText: "First Name"),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 24),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Color(0XFFF6F7F9),
                          border: Border.all(color: Color(0XFF6F7F9)),
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: TextFormField(
                          onChanged: (input) =>
                              registrationRequest.lastname = input,
                          decoration: InputDecoration(
                              suffixIcon: Align(
                                widthFactor: 1.0,
                                heightFactor: 1.0,
                                child: Image.asset(profile,
                                    height: 20,
                                    width: 20,
                                    color: Color(0xFF6C757D)),
                              ),
                              border: InputBorder.none,
                              hintText: "Last Name"),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 24),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Color(0XFFF6F7F9),
                          border: Border.all(color: Color(0XFF6F7F9)),
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: TextFormField(
                          onChanged: (input) =>
                              registrationRequest.email = input,
                          decoration: InputDecoration(
                              suffixIcon: Align(
                                widthFactor: 1.0,
                                heightFactor: 1.0,
                                child: Image.asset(ic_message,
                                    height: 20,
                                    width: 20,
                                    color: Color(0xFF6C757D)),
                              ),
                              border: InputBorder.none,
                              hintText: "Email Address",
                              labelText: "Email"),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 24),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Color(0XFFF6F7F9),
                          border: Border.all(color: Color(0XFF6F7F9)),
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: TextFormField(
                          onChanged: (input) =>
                              registrationRequest.phonenumber = input,
                          decoration: InputDecoration(
                              suffixIcon: Align(
                                widthFactor: 1.0,
                                heightFactor: 1.0,
                                child: Image.asset(calling,
                                    height: 20,
                                    width: 20,
                                    color: Color(0xFF6C757D)),
                              ),
                              border: InputBorder.none,
                              hintText: "Phone number"),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 24),

                  SizedBox(height: 24),
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(left: 25, right: 25),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0Xff5F60B9),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0)),
                        // Background color
                      ),
                      onPressed: () {
                        print(registrationRequest);
                        if (validateAndSave()) {
                          setState(() {
                            isApiCallProcess = true;
                          });
                          registrationRequest.role = "PROVIDER";
                          registrationRequest.password="Password";
                          print(registrationRequest);

                          AUTHService.register(registrationRequest).then(
                            (response) {
                              setState(() {
                                isApiCallProcess = false;
                              });

                              if (response != null) {
                                FormHelper.showSimpleAlertDialog(
                                  context,
                                  Config.appName,
                                  "Registration Successful. Please login to the account",
                                  "OK",
                                  () {
                                    // Navigator.pushNamedAndRemoveUntil(
                                    //   context,
                                    //   '/profile-setup',
                                    //   (route) => false,
                                    // );
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) {
                                      return ProviderProfileSetup(
                                        firstname:
                                            registrationRequest.firstname,
                                        lastname: registrationRequest.lastname,
                                        phonenumber:
                                            registrationRequest.phonenumber,
                                        email: registrationRequest.email,
                                      );
                                    }));
                                  },
                                );
                              } else {
                                FormHelper.showSimpleAlertDialog(
                                  context,
                                  Config.appName,
                                  "Registraion failed!",
                                  "OK",
                                  () {
                                    Navigator.of(context).pop();
                                  },
                                );
                              }
                            },
                          );
                        }
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Text(
                          "SIGN UP",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              fontFamily: "Work Sans"),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have an account?",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0XFF6C757D),
                            fontFamily: "Work Sans",
                            fontSize: 14),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      InkWell(
                        child: Text(
                          "Sign In",
                          style: TextStyle(
                              color: Color(0Xff5F60B9),
                              decoration: TextDecoration.underline,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Work Sans",
                              fontSize: 14),
                        ),
                        onTap: () {
                          Navigator.pushNamedAndRemoveUntil(
                              context, ("/sigin"), (route) => false);
                        },
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        )),
      ),
    );
  }

  bool validateAndSave() {
    final form = formkey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }
}
