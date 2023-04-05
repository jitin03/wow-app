import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:maven_class/model/booking_status.dart';
import 'package:maven_class/utils/config.dart';

import '../../model/update_booking_request.dart';
import '../../provider/data_provider.dart';

class CashPaymentVerification extends ConsumerStatefulWidget {
  final Object? bookingId;

  CashPaymentVerification({this.bookingId});

  @override
  ConsumerState<CashPaymentVerification> createState() =>
      _CashPaymentVerificationState();
}

class _CashPaymentVerificationState
    extends ConsumerState<CashPaymentVerification> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  TextEditingController otpController = TextEditingController();
  bool isApiCallProcess = false;
  void initState() {
    super.initState();
    print("asdasd");
    print(widget.bookingId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onTap: () async {
            Navigator.pop(context);
          },
        ),
        title: Text(
          "Payment Verification",
        ),
        backgroundColor: primaryColor,
        titleTextStyle: TextStyle(
            color: Colors.white,
            fontFamily: "Work Sans",
            fontSize: 18,
            fontWeight: FontWeight.w800),
      ),
      body: Form(
        key: formkey,
        child: Stack(
          children: [
            Center(
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 50),
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    child: Text(
                      "Enter the Customer's OTP to complete verification of booking: #${widget.bookingId} ",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: "Work Sans",
                        fontSize: 16,
                        color: Color(0XFF6C757D),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
                      margin: EdgeInsets.only(top: 50),
                      decoration: BoxDecoration(
                          color: Color(0XFFF6F7F9),
                          border: Border.all(color: Color(0XFF6F7F9)),
                          borderRadius: BorderRadius.circular(10)),
                      padding: EdgeInsets.symmetric(horizontal: 30),
                      child: TextFormField(
                        validator: (value) {
                          if (value!.isEmpty || value == null) {
                            return 'Please enter the customer OTP';
                          }
                        },
                        controller: otpController,
                        decoration: InputDecoration(
                            suffixIcon: Align(
                              widthFactor: 1.0,
                              heightFactor: 1.0,
                            ),
                            border: InputBorder.none,
                            hintText: "Enter OTP"),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: const EdgeInsets.all(5),
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0Xff5F60B9),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                  ),
                  onPressed: () {
                    if (validateAndSave()) {

                      setState(() {
                        isApiCallProcess =true;
                      });
                      BookingStatus updateRequest = BookingStatus(status: "Done");
                      var bookingOrderProvider_response = ref
                          .read(billingProvider)
                          .modifyBookingStatus(
                              updateRequest, widget.bookingId.toString());
                      print("pring payment response");
                      setState(() {
                        isApiCallProcess =false;
                      });
                      if (bookingOrderProvider_response != null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Verification Done')),
                        );

                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          '/dashboard',
                          (route) => false,
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Something went wrong!')),
                        );
                      }
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
                  ) :const Text(
                    'VERIFY',
                    style:
                        TextStyle(color: Colors.white, fontFamily: 'Work Sans'),
                  ),
                ),
              ),
            )
          ],
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
