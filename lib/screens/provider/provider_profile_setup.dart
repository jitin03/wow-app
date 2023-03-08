import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:maven_class/services/provider_service.dart';
import 'package:maven_class/utils/config.dart';
import 'package:maven_class/utils/images.dart';
import 'package:snippet_coder_utils/FormHelper.dart';

import '../../model/provider_profile_response_bck.dart';

class ProviderProfileSetup extends StatefulWidget {
  final firstname;
  final lastname;
  final email;
  final phonenumber;

  ProviderProfileSetup(
      {this.firstname, this.lastname, this.email, this.phonenumber});

  @override
  State<ProviderProfileSetup> createState() => _ProviderProfileSetupState();
}

class _ProviderProfileSetupState extends State<ProviderProfileSetup> {
  late String fullname;
  String? selectedCity = null;
  String? selectedState = null;
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  Address address = new Address();
  List<ServiceList> serviceLists = [];
  SubCategory subCategory = new SubCategory(name: "name", price: 0);
  ServiceList serviceList =
      new ServiceList(name: "", price: 0, subCategory: []);
  ProviderProfileResponse serviceRequest = new ProviderProfileResponse();

  late String email;
  late String phonenumber;
  @override
  void initState() {
    super.initState();
    fullname = widget.firstname + " " + widget.lastname;
    email = widget.email;
    phonenumber = widget.phonenumber;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Text(
                "Almost done?, Tell us What service you can bring with you?",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: "Work Sans",
                  fontSize: 16,
                  color: Color(0XFF6C757D),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Expanded(
              child: Center(
                  child: Form(
                key: formkey,
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
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
                              initialValue: fullname,
                              onSaved: (value) {
                                serviceRequest.name = value;
                              },
                              onChanged: (input) => serviceRequest!.name =
                                  input == null ? email : input,
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
                                  labelText: "Full Name",
                                  hintText: "Full Name"),
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
                              initialValue: email,
                              onChanged: (input) {
                                serviceRequest!.email =
                                    input == null ? email : input;
                              },
                              onSaved: (value) {
                                serviceRequest.email = value;
                              },
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
                              initialValue: phonenumber,
                              onSaved: (value) {
                                serviceRequest.phonenumber = int.parse(value!);
                              },
                              onChanged: (input) =>
                                  serviceRequest!.phonenumber = input == null
                                      ? int.parse(phonenumber)
                                      : int.parse(input),
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
                                  labelText: "Phone number",
                                  hintText: "Phone number"),
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
                              onChanged: (input) => address.address1 = input,
                              decoration: InputDecoration(
                                  suffixIcon: Align(
                                    widthFactor: 1.0,
                                    heightFactor: 1.0,
                                    child: Image.asset(ic_location,
                                        height: 20,
                                        width: 20,
                                        color: Color(0xFF6C757D)),
                                  ),
                                  border: InputBorder.none,
                                  labelText: "Address Line 1",
                                  hintText: "Address Line 1"),
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
                              onChanged: (input) => address.address2 = input,
                              decoration: InputDecoration(
                                  suffixIcon: Align(
                                    widthFactor: 1.0,
                                    heightFactor: 1.0,
                                    child: Image.asset(ic_location,
                                        height: 20,
                                        width: 20,
                                        color: Color(0xFF6C757D)),
                                  ),
                                  border: InputBorder.none,
                                  labelText: "Address Line 2",
                                  hintText: "Address Line 2"),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 24),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                child: DropdownButtonFormField<String>(
                                    decoration: InputDecoration(
                                      labelText: "City",
                                      isDense: true,
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: primaryColor, width: 2),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: primaryColor, width: 2),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      filled: true,
                                      fillColor: Colors.white,
                                    ),
                                    dropdownColor: Colors.white,
                                    value: selectedCity,
                                    onChanged: (String? newValue) {
                                      address.city = newValue!;
                                      setState(() {
                                        selectedCity = newValue;
                                      });
                                    },
                                    items: getdropdownItems()),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Container(
                                child: DropdownButtonFormField<String>(
                                    decoration: InputDecoration(
                                      labelText: "State",
                                      isDense: true,
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: primaryColor, width: 2),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: primaryColor, width: 2),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      filled: true,
                                      fillColor: Colors.white,
                                    ),
                                    dropdownColor: Colors.white,
                                    value: selectedState,
                                    onChanged: (String? newValue) {
                                      address.state = newValue!;
                                      setState(() {
                                        selectedState = newValue!;
                                      });
                                    },
                                    items: getStateItems()),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 24,
                      ),
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
                              onChanged: (input) => address.pincode = input,
                              decoration: InputDecoration(
                                  suffixIcon: Align(
                                    widthFactor: 1.0,
                                    heightFactor: 1.0,
                                  ),
                                  border: InputBorder.none,
                                  hintText: "Pincode",
                                  labelText: "Pincode"),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 24,
                      ),
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
                              initialValue: "India",
                              decoration: InputDecoration(
                                  suffixIcon: Align(
                                    widthFactor: 1.0,
                                    heightFactor: 1.0,
                                  ),
                                  border: InputBorder.none,
                                  hintText: "Country",
                                  labelText: "Country"),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 24,
                      ),
                      Container(
                        child: Column(
                          children: [
                            Container(
                              width: double.infinity,
                              margin: EdgeInsets.only(left: 10, right: 10),
                              decoration: BoxDecoration(
                                color: Color(
                                  0XffF6F7F9,
                                ),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: Color(0XFFF6F7F9),
                                                border: Border.all(
                                                    color: Color(0XFF6F7F9)),
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: TextFormField(
                                              onChanged: (input) =>
                                                  serviceList.name = input,
                                              decoration: InputDecoration(
                                                  filled: true,
                                                  isDense: true,
                                                  fillColor: Colors.white,
                                                  contentPadding:
                                                      const EdgeInsets
                                                              .symmetric(
                                                          vertical: 2.0,
                                                          horizontal: 10.0),
                                                  border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0)),
                                                  hintText: "Service Name",
                                                  labelText: "Service Name"),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Expanded(
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: Color(0XFFF6F7F9),
                                                border: Border.all(
                                                    color: Color(0XFF6F7F9)),
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: TextFormField(
                                              onChanged: (input) => serviceList
                                                  .price = double.parse(input),
                                              decoration: InputDecoration(
                                                  isDense: true,
                                                  fillColor: Colors.white,
                                                  contentPadding:
                                                      const EdgeInsets
                                                              .symmetric(
                                                          vertical: 2.0,
                                                          horizontal: 10.0),
                                                  border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0)),
                                                  hintText: "Price",
                                                  labelText: "Service Charge"),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Divider(
                                      height: 2,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Container(
                                          // width: double.infinity,
                                          // margin: EdgeInsets.only(left: 25, right: 25),
                                          child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  Color(0Xff5F60B9),
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0)),
                                              // Background color
                                            ),
                                            onPressed: () {
                                              setState(() {
                                                SubCategory newSubCategory =
                                                    new SubCategory(
                                                        name: "name", price: 0);
                                                serviceList.subCategory!
                                                    .add(newSubCategory);
                                              });
                                            },
                                            child: const Padding(
                                              padding: EdgeInsets.all(15.0),
                                              child: Text(
                                                "ADD",
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Container(
                                          // width: double.infinity,
                                          // margin: EdgeInsets.only(left: 25, right: 25),
                                          child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  Color(0Xff5F60B9),
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0)),
                                              // Background color
                                            ),
                                            onPressed: () {
                                              setState(() {
                                                if (this
                                                        .serviceList
                                                        .subCategory!
                                                        .length >
                                                    0) {
                                                  this
                                                      .serviceList
                                                      .subCategory!
                                                      .removeLast();
                                                }
                                              });
                                            },
                                            child: const Padding(
                                              padding: EdgeInsets.all(15.0),
                                              child: Text(
                                                "REMOVE",
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Column(
                                      children: [
                                        Container(
                                          // height: 200,
                                          child: subCategoryContainerUI(),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
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
                            // print(serviceList.toJson());
                            // print(address.toJson());

                            serviceLists.add(serviceList);
                            // print(serviceLists);

                            if (formkey.currentState!.validate()) {
                              serviceRequest.address ??= [];
                              serviceRequest.serviceLists ??= [];

                              serviceRequest.address?.add(address);
                              serviceRequest.serviceLists?.add(serviceList);
                              if (serviceRequest.name == null ||
                                  serviceRequest.email == null ||
                                  serviceRequest.phonenumber == null) {
                                serviceRequest.name = fullname;
                                serviceRequest.phonenumber =
                                    int.parse(phonenumber);
                                serviceRequest.email = email;
                              }
                              print(serviceRequest.toJson().toString());
                              ProviderService.saveProviderServiceProfile(
                                      serviceRequest)
                                  .then((response) {
                                if (response) {
                                  Navigator.pushNamedAndRemoveUntil(
                                    context,
                                    '/sigin',
                                    (route) => false,
                                  );
                                } else {
                                  FormHelper.showSimpleAlertDialog(
                                    context,
                                    Config.appName,
                                    "Something went wrong !!",
                                    "OK",
                                    () {
                                      Navigator.of(context).pop();
                                    },
                                  );
                                }
                              });
                            }
                          },
                          child: const Padding(
                            padding: EdgeInsets.all(15.0),
                            child: Text(
                              "SAVE",
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
                    ],
                  ),
                ),
              )),
            ),
          ],
        ),
      ),
    );
  }

  List<DropdownMenuItem<String>> getdropdownItems() {
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(child: Text("Jaipur"), value: "Jaipur"),
      DropdownMenuItem(child: Text("Alwar"), value: "Alwar"),
      DropdownMenuItem(child: Text("Jodhpur"), value: "Jodhpur"),
    ];
    return menuItems;
  }

  List<DropdownMenuItem<String>> getStateItems() {
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(child: Text("Rajasthan"), value: "Rajasthan"),
    ];
    return menuItems;
  }

  Widget subCategoryContainerUI() {
    return ListView.separated(
      shrinkWrap: true,
      physics: ScrollPhysics(),
      itemCount: serviceList.subCategory!.length,
      itemBuilder: (context, index) {
        return Column(
          children: <Widget>[
            Row(children: <Widget>[
              Flexible(
                fit: FlexFit.loose,
                child: generateServiceType(index),
              ),
            ]),
          ],
        );
      },
      separatorBuilder: (context, index) => Divider(),
    );
  }

  Widget generateServiceType(index) {
    return Row(
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
                color: Color(0XFFF6F7F9),
                border: Border.all(color: Color(0XFF6F7F9)),
                borderRadius: BorderRadius.circular(10)),
            child: TextFormField(
              onChanged: (input) =>
                  serviceList.subCategory![index].name = input,
              decoration: InputDecoration(
                  filled: true,
                  isDense: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 5.0, horizontal: 10.0),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  hintText: "Service Name",
                  labelText: "Service Name"),
            ),
          ),
        ),
        SizedBox(
          width: 5,
        ),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
                color: Color(0XFFF6F7F9),
                border: Border.all(color: Color(0XFF6F7F9)),
                borderRadius: BorderRadius.circular(10)),
            child: TextFormField(
              onChanged: (input) =>
                  serviceList.subCategory![index].price = double.parse(input),
              decoration: InputDecoration(
                  filled: true,
                  isDense: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 2.0, horizontal: 10.0),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  hintText: "Price",
                  labelText: "Service Charge"),
            ),
          ),
        )
      ],
    );
  }
}
