import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:maven_class/provider/data_provider.dart';
import 'package:maven_class/utils/config.dart';
import 'package:snippet_coder_utils/FormHelper.dart';

import '../../model/provide_profile_email.dart';

class ProviderServices extends ConsumerStatefulWidget {
  // List<ServiceList>? serviceList;
  ProviderDetail providerDetail;

  ProviderServices({required this.providerDetail});

  @override
  ConsumerState<ProviderServices> createState() => _ProviderServices();
}

class _ProviderServices extends ConsumerState<ProviderServices> {
  List<ServiceList>? serviceLists;
  late ProviderDetail providerDetail;
  SubCategory subCategory = new SubCategory(name: "", price: 0);
  ServiceList serviceList =
  new ServiceList(name: "", price: 0, subCategory: []);
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  void initState() {
    super.initState();
    providerDetail = widget.providerDetail!;
    print(providerDetail.toJson());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "My Services",
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

            SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [


                      ElevatedButton(
                        style: ElevatedButton.styleFrom(

                          backgroundColor: Color(0Xff5F60B9),
                          shape: RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.circular(10.0)),
                          // Background color
                        ),
                        onPressed: () {
                          print("add new service");
                          setState(() {
                            ServiceList serviceList =
                            new ServiceList(name: "name", price: 0, subCategory: []);
                            providerDetail
                                .serviceLists!
                                .add(serviceList);
                          });
                        },
                        child: Text(
                          "ADD SERVICE",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),

                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0Xff5F60B9),
                          shape: RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.circular(10.0)),
                          // Background color
                        ),
                        onPressed: () {
                          print("Remove new service");
                          setState(() {
                            setState(() {
                              if (this
                                  .providerDetail
                                  .serviceLists!
                                  .length >
                                  0) {
                                this
                                    .providerDetail
                                    .serviceLists!
                                    .removeLast();
                              }
                            });
                          });
                        },
                        child: Text(
                          "REMOVE SERVICE",
                          style: TextStyle(color: Colors.white),
                        ),
                      )
                    ],
                  ),
                  serviceListContainerUI(),
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
                    // Background color
                  ),
                  onPressed: () async {
                    if (formkey.currentState!.validate()) {
                      print(providerDetail.toJson());

                      var response = await ref
                          .read(providerProfileProvider)
                          .updateProviderProfile(
                              providerDetail, providerDetail.id!);

                      if (response != null) {
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          '/dashboard',
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
                    }
                  },
                  child: const Text(
                    'UPDATE',
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

  Widget subCategoryContainerUI(index) {
    return ListView.separated(
      shrinkWrap: true,
      physics: ScrollPhysics(),
      // itemCount: serviceList.subCategory!.length,
      itemCount: providerDetail.serviceLists![index].subCategory!.length,
      itemBuilder: (context, index) {
        return Column(
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            Row(
              children: <Widget>[
                Flexible(
                  fit: FlexFit.loose,
                  child: generateSubCategoryServiceType(index),
                ),
              ],
            ),
          ],
        );
      },
      separatorBuilder: (context, index) => Divider(),
    );
  }

  Widget serviceListContainerUI() {
    return ListView.separated(
      shrinkWrap: true,
      physics: ScrollPhysics(),
      itemCount: providerDetail.serviceLists!.length,
      // itemCount: 1,
      itemBuilder: (context, index) {
        return Column(
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            Row(
              children: <Widget>[
                Flexible(
                  fit: FlexFit.loose,
                  child: generateServiceType(index),
                ),
              ],
            ),
          ],
        );
      },
      separatorBuilder: (context, index) => Divider(),
    );
  }

  Widget generateServiceType(index) {
    return Container(
      // margin: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 40,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              "Pricing:",
              style: TextStyle(
                  fontFamily: 'Work Sans',
                  fontWeight: FontWeight.w800,
                  fontSize: 16),
            ),
          ),
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
                              border:
                              Border.all(color: Color(0XFF6F7F9)),
                              borderRadius: BorderRadius.circular(10)),
                          child: TextFormField(
                            initialValue:
                            providerDetail.serviceLists![index].name,
                            onChanged: (input) =>
                            serviceLists![0].name = input,
                            decoration: InputDecoration(
                                filled: true,
                                isDense: true,
                                fillColor: Colors.white,
                                contentPadding:
                                const EdgeInsets.symmetric(
                                    vertical: 2.0,
                                    horizontal: 10.0),
                                border: OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.circular(10.0)),
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
                              border:
                              Border.all(color: Color(0XFF6F7F9)),
                              borderRadius: BorderRadius.circular(10)),
                          child: TextFormField(
                            initialValue: providerDetail
                                .serviceLists![index].price
                                .toString(),
                            onChanged: (input) => providerDetail
                                .serviceLists![index]
                                .price = double.parse(input),
                            decoration: InputDecoration(
                                isDense: true,
                                fillColor: Colors.white,
                                contentPadding:
                                const EdgeInsets.symmetric(
                                    vertical: 2.0,
                                    horizontal: 10.0),
                                border: OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.circular(10.0)),
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
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        // width: double.infinity,
                        // margin: EdgeInsets.only(left: 25, right: 25),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0Xff5F60B9),
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.circular(10.0)),
                            // Background color
                          ),
                          onPressed: () {
                            setState(() {
                              SubCategory newSubCategory =
                              new SubCategory(
                                  name: "name", price: 0);
                              providerDetail
                                  .serviceLists![index].subCategory!
                                  .add(newSubCategory);
                            });
                          },
                          child: const Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Text(
                              "ADD",
                              style: TextStyle(color: Colors.white),
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
                            backgroundColor: Color(0Xff5F60B9),
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.circular(10.0)),
                            // Background color
                          ),
                          onPressed: () {
                            setState(() {
                              if (this
                                  .providerDetail
                                  .serviceLists![index]
                                  .subCategory!
                                  .length >
                                  0) {
                                this
                                    .providerDetail
                                    .serviceLists![index]
                                    .subCategory!
                                    .removeLast();
                              }
                            });
                          },
                          child: const Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Text(
                              "REMOVE",
                              style: TextStyle(color: Colors.white),
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
                      SingleChildScrollView(
                        child: Container(
                          // height: 200,
                          child: subCategoryContainerUI(index),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget generateSubCategoryServiceType(index) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Container(
            decoration: BoxDecoration(
                color: Color(0XFFF6F7F9),
                border: Border.all(color: Color(0XFF6F7F9)),
                borderRadius: BorderRadius.circular(10)),
            child: TextFormField(
              initialValue:
                  providerDetail.serviceLists![0].subCategory![index].name,
              onChanged: (input) => providerDetail
                  .serviceLists![index].subCategory![index].name = input,
              decoration: InputDecoration(
                  filled: true,
                  isDense: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 5.0, horizontal: 10.0),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0)),
                  hintText: "Service Name",
                  labelText: "Service Name"),
            ),
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Expanded(
          flex: 1,
          child: Container(
            decoration: BoxDecoration(
                color: Color(0XFFF6F7F9),
                border: Border.all(color: Color(0XFF6F7F9)),
                borderRadius: BorderRadius.circular(10)),
            child: TextFormField(
              initialValue: providerDetail
                  .serviceLists![index].subCategory![index].price
                  .toString(),
              onChanged: (input) => providerDetail.serviceLists![0]
                  .subCategory![index].price = double.parse(input),
              decoration: InputDecoration(
                  filled: true,
                  isDense: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 2.0, horizontal: 10.0),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0)),
                  hintText: "Price",
                  labelText: "Service Charge"),
            ),
          ),
        )
      ],
    );
  }
}
