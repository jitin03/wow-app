import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:maven_class/model/user_model.dart';
import 'package:maven_class/provider/data_provider.dart';
import 'package:maven_class/screens/auth/verify_otp_screen.dart';
import 'package:maven_class/screens/components/provider_button.dart';
import 'package:maven_class/services/auth_service.dart';
import 'package:maven_class/utils/ProgressHUG.dart';
import 'package:maven_class/utils/config.dart';
import 'package:snippet_coder_utils/FormHelper.dart';

class SignIn extends ConsumerStatefulWidget {
  @override
  ConsumerState<SignIn> createState() => _SignInState();
}

class _SignInState extends ConsumerState<SignIn> {
  //validate our form now
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  UserModel loginRequestModel = new UserModel();
  TextEditingController countryController = TextEditingController();
  TextEditingController phoneNoController = TextEditingController();
  bool isApiCallProcess = false;
  @override
  void initState() {
    super.initState();
    // TODO: implement initState
    countryController.text = "+91";
  }

  @override
  Widget build(BuildContext context) {
    return ProgressHUD(
      inAsyncCall: isApiCallProcess,
      opacity: 0.3,
      valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
      child: Scaffold(
        body: SafeArea(
          child: Center(
            child: Container(
              margin: EdgeInsets.only(left: 25, right: 25),
              alignment: Alignment.center,
              child: Form(
                key: formkey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Hello Again!",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontFamily: "Work Sans",
                          fontSize: 22),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Welcome Back, you\'ve been missed",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontFamily: "Work Sans",
                          fontSize: 16),
                    ),
                    SizedBox(
                      height: 70,
                    ),
                  
                    Container(
                      height: 55,
                      decoration: BoxDecoration(
                          border: Border.all(width: 1, color: Colors.grey),
                          borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 10,
                          ),
                          SizedBox(
                            width: 40,
                            child: TextFormField(
                              controller: countryController,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          Text(
                            "|",
                            style: TextStyle(fontSize: 33, color: Colors.grey),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: TextFormField(
                              // validator: (value) {
                              //   if (value == null || value.isEmpty) {
                              //     return 'Please enter valid phone number';
                              //   }
                              //   return null;
                              // },
                              controller: phoneNoController,
                              keyboardType: TextInputType.phone,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Phone",
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Container(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0Xff5F60B9),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0)),
                          // Background color
                        ),
                        onPressed: () async {
                          if (validateAndSave()) {
                            setState(() {
                              isApiCallProcess = true;
                            });
                            print(
                                countryController.text + phoneNoController.text);
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                                  return VerifyOtp(
                                      phoneNo:
                                      countryController.text + phoneNoController.text);
                                }));

                            await ref.read(authOtpProvider).requestOtp(countryController.text + phoneNoController.text);
                            setState(() {
                              isApiCallProcess = false;
                            });
                          }
                        },
                        child:  isApiCallProcess
                            ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Loading...",
                              style: TextStyle(
                                fontFamily: 'Work Sans',
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Transform.scale(
                              scale: 0.5,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              ),
                            )
                          ],
                        ):const Padding(
                          padding: EdgeInsets.all(15.0),
                          child: Text(
                            "SEND OTP",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Container(
                      width: double.infinity,
                      margin: EdgeInsets.only(left: 25, right: 25),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Don’t have an account?",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontFamily: "Work Sans",
                                fontSize: 14),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          InkWell(
                            child: Text(
                              "Sign Up",
                              style: TextStyle(
                                  color: Color(0Xff5F60B9),
                                  decoration: TextDecoration.underline,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "Work Sans",
                                  fontSize: 14),
                            ),
                            onTap: () {
                              Navigator.pushNamedAndRemoveUntil(
                                  context, ("/register"), (route) => false);
                            },
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
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
