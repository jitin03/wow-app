import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:maven_class/model/billing_request_model.dart';
import 'package:maven_class/model/booking_model.dart';
import 'package:maven_class/model/cart.dart';
import 'package:maven_class/provider/cart_view_model.dart';
import 'package:maven_class/provider/data_provider.dart';
import 'package:maven_class/screens/components/round_button_icon.dart';
import 'package:maven_class/utils/config.dart';
import 'package:snippet_coder_utils/FormHelper.dart';

class LaundryGenerateBillScreen extends ConsumerStatefulWidget {
  BookingResponseModel? bookingResponseModel;

  LaundryGenerateBillScreen({this.bookingResponseModel});

  @override
  ConsumerState<LaundryGenerateBillScreen> createState() =>
      _GenerateBillScreenState();
}

class _GenerateBillScreenState
    extends ConsumerState<LaundryGenerateBillScreen> {
  int value = 0;
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  static final ValueNotifier<List<int>> quantity = ValueNotifier([0]);
  BookingResponseModel? bookingResponseModel;
  BillingRequest billingRequest = BillingRequest();
  List<ServiceLists> serviceLists = [];
  List<SubCategories> subCategoriesList = [];
  ServiceLists serviceList = ServiceLists();
  bool isEdit = false;

  void initState() {
    super.initState();
    bookingResponseModel = widget.bookingResponseModel;

    ref.refresh(
        billingDataProvider(bookingResponseModel!.bookingId.toString()));
  }

  @override
  Widget build(BuildContext context) {
    final _billing_data = ref
        .watch(billingDataProvider(bookingResponseModel!.bookingId.toString()));

    final _providerFiledata = ref
        .watch(generateBillState(bookingResponseModel!.bookingId.toString()));

    var cartList = ref.watch(cartListProvider).list =
        (ref.watch(cartListProvider).list.length == 0)
            ? [
                Cart(id: 0, title: "", price: 1, count: 0),
                Cart(id: 1, title: "", price: 1, count: 0),
                Cart(id: 2, title: "", price: 1, count: 0),
                Cart(id: 3, title: "", price: 1, count: 0),
                Cart(id: 4, title: "", price: 1, count: 0),
                Cart(id: 6, title: "", price: 1, count: 0),
                Cart(id: 7, title: "", price: 1, count: 0),
                Cart(id: 8, title: "", price: 1, count: 0),
                Cart(id: 9, title: "", price: 1, count: 0),
                Cart(id: 10, title: "", price: 1, count: 0),
                Cart(id: 11, title: "", price: 1, count: 0),
                Cart(id: 12, title: "", price: 1, count: 0),
                Cart(id: 13, title: "", price: 1, count: 0),
                Cart(id: 14, title: "", price: 1, count: 0),
                Cart(id: 15, title: "", price: 1, count: 0),
                Cart(id: 16, title: "", price: 1, count: 0),
                Cart(id: 17, title: "", price: 1, count: 0),
                Cart(id: 18, title: "", price: 1, count: 0),
                Cart(id: 19, title: "", price: 1, count: 0),
              ]
            : ref.watch(cartListProvider).list;

    var totalAmount = ref.read(totalAmountProvider);

    int indexOfServiceName = -1;
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onTap: () async {
            // ref.invalidate(totalAmountProvider);
            ref.invalidate(cartListProvider);
            ref.invalidate(billingDataProvider(
                bookingResponseModel!.bookingId.toString()));
            totalAmount = 0.0;
            cartList = [];
            Navigator.pop(context);
          },
        ),
        title: Text(
          "Generate bill",
        ),
        backgroundColor: primaryColor,
        titleTextStyle: TextStyle(
            color: Colors.white,
            fontFamily: "Work Sans",
            fontSize: 18,
            fontWeight: FontWeight.w800),
      ),
      body: _providerFiledata.when(
        data: (_data) {
          for (int i = 0; i < _data.profileData.serviceLists!.length; i++) {
            if (_data.profileData.serviceLists![i].name ==
                bookingResponseModel!.serviceType.toString()) {
              indexOfServiceName = i;
              break;
            }
          }
          return Stack(children: [
            SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.fromLTRB(25, 20, 25, 20),
                alignment: Alignment.center,
                child: Form(
                  key: formkey,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0, right: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Booking ID"),
                            Text('#' + bookingResponseModel!.bookingId.toString())
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Divider(height: 2, thickness: 2),
                      SizedBox(
                        height: 20,
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10.0, right: 10),
                          child:
                              Text(bookingResponseModel!.serviceType.toString()),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        child: Column(
                          children: [
                            Container(
                              height: 320,
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  border: Border.all(color: primaryColor),
                                  shape: BoxShape.rectangle,
                                  borderRadius:
                                      const BorderRadius.all(Radius.circular(4))),
                              child: ListView.builder(
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                itemCount: _data
                                    .profileData
                                    .serviceLists![indexOfServiceName]
                                    .subCategory!
                                    .length,
                                itemBuilder: (context, index) {
                                  cartList[index].price = _data
                                      .profileData
                                      .serviceLists![indexOfServiceName]
                                      .subCategory![index]
                                      .price!;
                                  serviceList.name = _data.profileData
                                      .serviceLists![indexOfServiceName].name;
                                  serviceList.price = _data.profileData
                                      .serviceLists![indexOfServiceName].price;

                                  if (!isEdit) {
                                    if (_data.billingResponse != null &&
                                        _data.billingResponse.isNotEmpty &&
                                        _data.billingResponse[0].serviceLists !=
                                            null &&
                                        _data.billingResponse[0].serviceLists
                                            .isNotEmpty) {
                                      var subCategories = _data.billingResponse[0]
                                          .serviceLists[0].subCategories;
                                      if (subCategories != null &&
                                          index < subCategories.length) {
                                        cartList[index].count = int.tryParse(
                                                subCategories[index].count) ??
                                            0;
                                        totalAmount = double.parse(_data
                                            .billingResponse![0].grossAmount);
                                      } else {
                                        cartList[index].count = 0;
                                      }
                                    } else {
                                      cartList[index].count = 0;
                                    }
                                  }

                                  return Align(
                                    alignment: Alignment.center,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Container(
                                          child: Expanded(
                                            child: Text(
                                              softWrap: true,
                                              _data
                                                      .profileData
                                                      .serviceLists![
                                                          indexOfServiceName]
                                                      .subCategory![index]
                                                      .name! +
                                                  ' (${_data.profileData.serviceLists![indexOfServiceName].subCategory![index].price} per piece)',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontFamily: 'Work Sans',
                                                  fontSize: 14),
                                            ),
                                          ),
                                        ),

                                        Container(
                                          margin: EdgeInsets.only(left: 10),
                                          child: Row(
                                            children: [
                                              RoundedIconButton(
                                                icon: Icons.remove,
                                                iconSize: 22.0,
                                                onPress: () {
                                                  ref
                                                      .read(cartListProvider)
                                                      .decrement(index);
                                                  setState(() {
                                                    isEdit = true;
                                                  });
                                                },
                                              ),
                                              Container(
                                                child: Text(
                                                  cartList[index]
                                                      .count
                                                      .toString(),
                                                  style: TextStyle(
                                                    fontSize: 22.0 * 0.7,
                                                  ),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                              RoundedIconButton(
                                                icon: Icons.add,
                                                iconSize: 22.0,
                                                onPress: () {
                                                  ref
                                                      .read(cartListProvider)
                                                      .increment(index);
                                                  setState(() {
                                                    isEdit = true;
                                                  });
                                                },
                                              ),
                                            ],
                                          ),
                                        ),

                                        // Text(cartList[index].count.toString() ?? 'asdsad'),
                                        // Text((_data.profileData.serviceLists![0]
                                        //         .subCategory![index].price! * (cartList[index].count!)).toStringAsFixed(1) ),
                                        Expanded(
                                          child: FittedBox(
                                            fit: BoxFit.scaleDown,
                                            child: Container(
                                              child: Align(
                                                alignment: Alignment.center,
                                                child: Text(
                                                  '\u{20B9}' +
                                                      (cartList[index].price! *
                                                              (cartList[index]
                                                                  .count!))
                                                          .toStringAsFixed(1),
                                                  style: TextStyle(
                                                      fontFamily: 'Work Sans',
                                                      fontSize: 14),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),

                                        // Text("Items (${cartList.length})"),
                                        // Text("\$${totalAmount.toStringAsFixed(2)}"),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(16),
                              margin: const EdgeInsets.only(top: 8),
                              decoration: BoxDecoration(
                                  border: Border.all(color: primaryColor),
                                  shape: BoxShape.rectangle,
                                  borderRadius:
                                      const BorderRadius.all(Radius.circular(4))),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Items price"),
                                      !isEdit && _data.billingResponse!.length > 0
                                          ? Text(
                                              "\u{20B9}${_data.billingResponse![0].grossAmount}",
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.blue))
                                          : Text(
                                              "\u{20B9}${(totalAmount).toStringAsFixed(2)}",
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.blue),
                                            )
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  // Row(
                                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  //   children: const [
                                  //     Text("Shipping"),
                                  //     Text("\$40.00"),
                                  //   ],
                                  // ),
                                  const SizedBox(height: 8),
                                  // Row(
                                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  //   children: [
                                  //     const Text("GST (18%)"),
                                  //     Text("\$${(totalAmount * 0.18).toStringAsFixed(2)}")
                                  //   ],
                                  // ),
                                  const SizedBox(height: 8),
                                  const Divider(color: primaryColor),
                                  const SizedBox(height: 8),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        "Total Price",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black),
                                      ),
                                      !isEdit && _data.billingResponse!.length > 0
                                          ? Text(
                                              "\u{20B9}${_data.billingResponse[0].grossAmount}",
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.blue))
                                          : Text(
                                              "\u{20B9}${(totalAmount).toStringAsFixed(2)}",
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.blue))
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            (_billing_data.value != null && _billing_data.value!.length > 0)
                ? Align(
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
                        onPressed: _data.billingResponse[0].status != "Paid"
                            ? () async {
                                billingRequest.providerId =
                                    _data.profileData.id;
                                billingRequest.customerId =
                                    bookingResponseModel!.customerId![0].id;
                                billingRequest.grossAmount =
                                    totalAmount.toStringAsFixed(2);
                                billingRequest.status = "Pending";

                                for (int index = 0;
                                    index <
                                        _data
                                            .profileData!
                                            .serviceLists![indexOfServiceName]
                                            .subCategory!
                                            .length;
                                    index++) {
                                  var subCategories = SubCategories();
                                  subCategories.name = _data
                                      .profileData
                                      ?.serviceLists?[indexOfServiceName]
                                      .subCategory?[index]
                                      .name;
                                  subCategories.price = _data
                                      .profileData
                                      ?.serviceLists?[indexOfServiceName]
                                      .subCategory?[index]
                                      .price;
                                  subCategories.count =
                                      cartList?[index].count.toString() ?? "";
                                  subCategoriesList.add(subCategories);
                                }

                                serviceList.subCategories = subCategoriesList;
                                serviceLists.add(serviceList);

                                billingRequest.serviceLists = serviceLists;
                                var response = await ref
                                    .read(billingProvider)
                                    .updateBilling(
                                        billingRequest,
                                        bookingResponseModel!.bookingId
                                            .toString());

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
                            : null,
                        child: const Text(
                          'UPDATE BILL',
                          style: TextStyle(
                              color: Colors.white, fontFamily: 'Work Sans'),
                        ),
                      ),
                    ),
                  )
                : Align(
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
                        onPressed: () async {
                          billingRequest.providerId = _data.profileData.id;
                          billingRequest.customerId =
                              bookingResponseModel!.customerId![0].id;
                          billingRequest.grossAmount =
                              totalAmount.toStringAsFixed(2);
                          billingRequest.status = "Pending";

                          for (int index = 0;
                              index <
                                  _data
                                      .profileData!
                                      .serviceLists![indexOfServiceName]
                                      .subCategory!
                                      .length;
                              index++) {
                            var subCategories = SubCategories();
                            subCategories.name = _data
                                .profileData
                                ?.serviceLists?[indexOfServiceName]
                                .subCategory?[index]
                                .name;
                            subCategories.price = _data
                                .profileData
                                ?.serviceLists?[indexOfServiceName]
                                .subCategory?[index]
                                .price;
                            subCategories.count =
                                cartList?[index].count.toString() ?? "";
                            subCategoriesList.add(subCategories);
                          }

                          serviceList.subCategories = subCategoriesList;
                          serviceLists.add(serviceList);

                          billingRequest.serviceLists = serviceLists;
                          var response = await ref
                              .read(billingProvider)
                              .generateBilling(billingRequest,
                                  bookingResponseModel!.bookingId.toString());

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
                        },
                        child: const Text(
                          'GENERATE BILL',
                          style: TextStyle(
                              color: Colors.white, fontFamily: 'Work Sans'),
                        ),
                      ),
                    ),
                  )
          ]);
        },
        error: (err, s) => Text(err.toString()),
        loading: () => Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
