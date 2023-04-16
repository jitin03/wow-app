import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import 'package:maven_class/model/update_booking_request.dart';

import 'package:maven_class/provider/data_provider.dart';

import 'package:maven_class/services/shared_service.dart';

import 'package:maven_class/utils/config.dart';
import 'package:maven_class/utils/images.dart';

import '../../model/all_booking_response.dart';
import '../../model/booking_model.dart';
import '../../model/customer_booking_response.dart';
import '../../model/notification_response.dart';

enum PaymentOptions { Cash_only, online }

class CustomerOrderReviewScreen extends ConsumerStatefulWidget {
  final AllBookingResponse booking;
  final String serviceName;
  final String providername;

  const CustomerOrderReviewScreen(
      {super.key,
      required this.booking,
      required this.serviceName,
      required this.providername});

  @override
  ConsumerState<CustomerOrderReviewScreen> createState() =>
      _GenerateBillScreenState();
}

class _GenerateBillScreenState
    extends ConsumerState<CustomerOrderReviewScreen> {
  int value = 0;
  bool isSelect_OnlinePaymentSelected = false;
  bool isSelect_CashOnly = false;
  bool isSelect_UPIOnly = false;
  bool isApiCallProcess = false;
  PaymentOptions? _character = PaymentOptions.Cash_only;
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  static final ValueNotifier<List<int>> quantity = ValueNotifier([0]);

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int indexOfServiceName = -1;

    final _billing_data = ref
        .watch(bookingDetailDataProvider(widget.booking.bookingId.toString()));
    var _notifications = ref.watch(
        providerNotificationDataProvider(widget.booking.bookingId.toString()));
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        title: Text("Booking details",
            style: TextStyle(
                fontFamily: 'Work Sans',
                fontWeight: FontWeight.w500,
                fontSize: 18,
                color: Colors.white)),
        actions: <Widget>[
          InkWell(
            onTap: () async {
              ref.invalidate(providerNotificationDataProvider);
              print("asdasd");
              _bottomSheetMore(
                  context, widget.booking.bookingId.toString(), ref);
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 15.0),
              child: Text(
                'Check Status',
                style: TextStyle(
                    fontFamily: 'Work Sans',
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    color: Colors.white),
              ),
            ),
          ),
        ],
        backgroundColor: primaryColor,
        titleTextStyle: TextStyle(
            color: Colors.white,
            fontFamily: "Work Sans",
            fontSize: 18,
            fontWeight: FontWeight.w800),
      ),
      body: _billing_data.when(
        data: (_data) {
          if (_data!.length > 0) {
            for (int i = 0; i < _data[0].serviceLists!.length; i++) {
              if (_data[0].serviceLists![i].name == widget.serviceName) {
                indexOfServiceName = i;
                break;
              }
            }
          }
          return Stack(
            children: [
              SingleChildScrollView(
                child: Container(
                  margin: EdgeInsets.only(left: 25, right: 25),
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Booking ID",
                              style: TextStyle(
                                  fontFamily: 'Work Sans',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500)),
                          Text('#' + widget.booking.bookingId.toString(),
                              style: TextStyle(
                                  fontFamily: 'Work Sans',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: primaryColor))
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Divider(height: 2, thickness: 2),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("About Provider",
                                style: TextStyle(
                                    fontFamily: 'Work Sans',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500)),
                            Container(
                              decoration: BoxDecoration(
                                color: Color(0XFFF6F7F9),
                                border: Border.all(
                                  color: Color(0XFF6F7F9),
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              margin: EdgeInsets.only(top: 20, bottom: 20),
                              padding:
                                  const EdgeInsets.fromLTRB(10, 20, 40, 20),
                              child: Row(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(color: primaryColor),
                                        shape: BoxShape.circle,
                                        color: Colors.white),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          border:
                                              Border.all(color: primaryColor),
                                          shape: BoxShape.circle,
                                          color: Colors.white),
                                      child: ClipOval(
                                        child: Material(
                                          color: Colors.transparent,
                                          child: Ink.image(
                                            image: AssetImage(
                                                male_default_profile_iamge),
                                            fit: BoxFit.cover,
                                            width: 30,
                                            height: 30,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Container(
                                    child: Text(
                                      widget.providername,
                                      style: TextStyle(
                                          fontFamily: 'Work Sans',
                                          fontSize: 16,
                                          fontWeight: FontWeight.w800),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Price Details",
                          style: TextStyle(
                              fontFamily: 'Work Sans',
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height / 5,
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            border: Border.all(color: primaryColor),
                            shape: BoxShape.rectangle,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(4))),
                        child: ListView.separated(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount:
                              _data[0].serviceLists![0].subCategories!.length,
                          itemBuilder: (context, index) {
                            return Align(
                              alignment: Alignment.center,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    child: Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            softWrap: true,
                                            _data[0]
                                                .serviceLists[
                                                    indexOfServiceName]
                                                .subCategories[index]
                                                .name,
                                            style: TextStyle(
                                                fontWeight: FontWeight.w800,
                                                fontFamily: 'Work Sans',
                                                fontSize: 16),
                                          ),
                                          Text(
                                              ' (${_data[0].serviceLists![indexOfServiceName].subCategories![index].price} per piece)',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w800,
                                                  fontFamily: 'Work Sans',
                                                  fontSize: 16))
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    child: Text(
                                      softWrap: true,
                                      'Items: ${_data[0].serviceLists![indexOfServiceName].subCategories![index].count}',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w800,
                                          fontFamily: 'Work Sans',
                                          fontSize: 16),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 40,
                                  ),
                                  Container(
                                    child: Text(
                                      softWrap: true,
                                      '\u{20B9}' +
                                          (_data[0]
                                                      .serviceLists![
                                                          indexOfServiceName]
                                                      .subCategories![index]
                                                      .price! *
                                                  double.parse(_data[0]
                                                      .serviceLists![
                                                          indexOfServiceName]
                                                      .subCategories![index]
                                                      .count!))
                                              .toStringAsFixed(2),
                                      style: TextStyle(
                                          fontWeight: FontWeight.w800,
                                          fontFamily: 'Work Sans',
                                          fontSize: 16),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) =>
                              const Divider(),
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // Text("Items (${cartList.length})"),
                                // Text("\$${totalAmount.toStringAsFixed(2)}"),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                Text("Shipping"),
                                Text("\u{20B9}00.00"),
                              ],
                            ),
                            const SizedBox(height: 8),
                            // Row(
                            //   mainAxisAlignment:
                            //       MainAxisAlignment.spaceBetween,
                            //   children: [
                            //     const Text("GST (18%)"),
                            //     Text(
                            //         "\u{20B9}${(double.parse(_data[0].grossAmount) * 0.18).toStringAsFixed(2)}",
                            //         style: const TextStyle(
                            //             fontWeight: FontWeight.bold,
                            //             color: primaryColor))
                            //
                            //     // Text("\u{20B9}${(totalAmount * 0.18).toStringAsFixed(2)}")
                            //   ],
                            // ),
                            const SizedBox(height: 8),
                            const Divider(color: primaryColor),
                            const SizedBox(height: 8),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Total Amount",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                                // Text(
                                //     "\u{20B9}${(double.parse(_data[0].grossAmount) + double.parse(_data[0].grossAmount) * 0.18).toStringAsFixed(2)}",
                                //     style: const TextStyle(
                                //         fontWeight: FontWeight.bold,
                                //         color: primaryColor))
                                Text(
                                    "\u{20B9}${(double.parse(_data[0].grossAmount!))}",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor))
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          );
        },
        error: (err, s) => Text(err.toString()),
        loading: () => Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
void _bottomSheetMore(BuildContext context, String bookingId, WidgetRef ref) {
  int _currentStep = 0;
  var _notifications =
  ref.watch(providerNotificationDataProvider(bookingId));
  showModalBottomSheet(
    context: context,
    isScrollControlled:true,
    enableDrag: true,
    builder: (builder) {

      print("asdasd");
      return StatefulBuilder(builder: (context, setState) {
        return Container(
          height: MediaQuery.of(context).size.height*2/5,
          padding: EdgeInsets.only(
            left: 5.0,
            right: 5.0,
            top: 5.0,
            bottom: 5.0,
          ),
          decoration: new BoxDecoration(
              color: Colors.white,
              borderRadius: new BorderRadius.only(
                  topLeft: const Radius.circular(10.0),
                  topRight: const Radius.circular(10.0))),
          child: _notifications.when(
            data: (_data) {
              List<NotificationResponse> notifications = _data;
              return Wrap(
                children: <Widget>[
                  Container(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(15),
                          child: Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Track Order",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w800,
                                      fontFamily: 'Work Sans'),
                                ),
                                Text(
                                  "ID: #" + bookingId,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w800,
                                      fontFamily: 'Work Sans',
                                      color: primaryColor),
                                )
                              ],
                            ),
                          ),
                        ),
                        new Divider(
                          height: 10.0,
                        ),
                        Stepper(
                          steps: notifications.length>0? notifications.map((notification) {
                            return Step(
                              content: Container(),
                              title: FittedBox(
                                child: Column(
                                  children: [
                                    Text(notification.message),
                                    Text(DateFormat('hh:mm a dd MMM').format(
                                        DateTime.parse(notification.createTime!))),
                                  ],
                                ),
                              ),
                              isActive: _currentStep >= 0,
                              state: _currentStep >= 0
                                  ? StepState.complete
                                  : StepState.disabled,
                            );
                          }).toList() : <Step>[
                            Step(
                              title: const Text('History is missing for this order'),
                              content: Container(),
                              isActive: _currentStep >= 0,
                              state: _currentStep >= 0
                                  ? StepState.error
                                  : StepState.disabled,
                            ),

                          ],
                          type: StepperType.vertical,
                          controlsBuilder: (context, controller) {
                            return Container();
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
            error: (err, s) => Text(err.toString()),
            loading: () => Center(
              child: CircularProgressIndicator(),
            ),
          ),
        );
      });
    },
  );
}