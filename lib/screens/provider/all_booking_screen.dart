import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:maven_class/model/all_booking_response.dart';
import 'package:maven_class/model/booking_model.dart';
import 'package:maven_class/model/booking_status.dart';
import 'package:maven_class/provider/data_provider.dart';
import 'package:maven_class/screens/components/booking_item.dart';
import 'package:maven_class/screens/provider/laundry_generate_bill.dart';
import 'package:maven_class/services/booking_service.dart';
import 'package:maven_class/utils/config.dart';
import 'package:maven_class/utils/images.dart';
import 'package:snippet_coder_utils/FormHelper.dart';

import 'customer_order.dart';

class AllBookings extends ConsumerWidget {
  const AllBookings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _data = ref.watch(allbookingProvider);

    BookingStatus bookingStatus = BookingStatus();

    return RefreshIndicator(
      onRefresh: () async {
        ref.refresh(allbookingProvider);
      },
      child: Container(
        child: _data.when(
          data: (_data) {
            List<AllBookingResponse> bookings = _data.map((e) => e).toList();

            return (bookings.length > 0)
                ? Column(
                    children: [
                      Container(
                        // child: Text(bookings[0].serviceType as String),

                        child: Expanded(
                          child: ListView.builder(
                              itemCount: bookings.length,
                              itemBuilder: (context, index) {

                                if (bookings[index].status == "New") {
                                  return ReusableCard(
                                      cardChild: Container(
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  bookings[index].serviceLists![0].name!,
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontFamily: 'Work Sans',
                                                      color: Color(0xFF1C1F34)),
                                                ),
                                              ),
                                              Expanded(
                                                child: Container(
                                                  width: 30,
                                                  height: 30,
                                                  margin: EdgeInsets.only(
                                                      left: 16, right: 5),
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                      color: Colors.white,
                                                      width: 2,
                                                    ),
                                                    color: Colors
                                                        .deepOrangeAccent
                                                        .withOpacity(0.5),
                                                    borderRadius:
                                                        BorderRadius.all(
                                                      Radius.circular(10),
                                                    ),
                                                  ),
                                                  child: Align(
                                                    alignment: Alignment.center,
                                                    child: Text(
                                                      bookings[index].status!,
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontFamily:
                                                              'Work Sans',
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 12),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                child: Container(
                                                  margin: EdgeInsets.only(
                                                      left: 16, right: 5),
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                      color: primaryColor,
                                                      width: 2,
                                                    ),
                                                    color: primaryColor,
                                                    borderRadius:
                                                        BorderRadius.all(
                                                      Radius.circular(10),
                                                    ),
                                                  ),
                                                  child: Align(
                                                    alignment: Alignment.center,
                                                    child: Text(
                                                      "ID #" +
                                                          bookings[index]
                                                              .bookingId!
                                                              .toString(),
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 16),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 30,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                child: Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: ImageIcon(
                                                    AssetImage(ic_location),
                                                    color: Color(0XFF130F26),
                                                  ),
                                                ),
                                                flex: 1,
                                              ),
                                              Expanded(
                                                flex: 2,
                                                child: Container(
                                                  margin: EdgeInsets.only(
                                                      left: 16, right: 5),
                                                  child: SelectableText(
                                                    bookings[index]
                                                        .bookingAddress!,
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 16),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                child: Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: ImageIcon(
                                                    AssetImage(calendar),
                                                    color: Color(0XFF130F26),
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 2,
                                                child: Container(
                                                  margin: EdgeInsets.only(
                                                      left: 16, right: 5),
                                                  child: Text(
                                                    bookings[index]
                                                        .bookingTime!,
                                                    // DateFormat('dd MMM, EEE, '
                                                    //         'yyyy GG hh:mm aaa')
                                                    //     .format(DateTime.parse(
                                                    //         bookings[index]
                                                    //             .bookingTime!)),
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 16),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                child: Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: ImageIcon(
                                                    AssetImage(profile),
                                                    color: Color(0XFF130F26),
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 2,
                                                child: Container(
                                                  margin: EdgeInsets.only(
                                                      left: 16, right: 5),
                                                  child: Text(
                                                    bookings[index].customerName![0],
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 16),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                child: Align(
                                                  alignment:
                                                  Alignment.centerLeft,
                                                  child: ImageIcon(
                                                    AssetImage(calling),
                                                    color: Color(0XFF130F26),
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 2,
                                                child: Container(
                                                  margin: EdgeInsets.only(
                                                      left: 16, right: 5),
                                                  child: SelectableText(
                                                    bookings[index]
                                                        .customerPhoneNo![0].toInt().toString(),
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 16),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                          const EdgeInsets.all(
                                              10),
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment
                                                .center,
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder:
                                                              (context) {
                                                            return CustomerOrderReviewScreen(
                                                                booking:
                                                                bookings![index],
                                                                serviceName: bookings[
                                                                index]
                                                                    .serviceLists![
                                                                0]
                                                                    .name!,
                                                                providername:
                                                                bookings[index]
                                                                    .providerName![0]);
                                                          }));
                                                },
                                                child: Text(
                                                  "ORDER PREVIEW",
                                                  style: TextStyle(
                                                      fontFamily:
                                                      'Work Sans',
                                                      color:
                                                      primaryColor),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(7.0),
                                          child: Divider(
                                            height: 2,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                child: Align(
                                                  alignment:
                                                  Alignment.centerLeft,
                                                  child: ImageIcon(
                                                    AssetImage(profile),
                                                    color: Colors.green,
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 2,
                                                child: Container(
                                                  margin: EdgeInsets.only(
                                                      left: 16, right: 5),
                                                  child: SelectableText(
                                                    bookings[index]
                                                        .providerName![0],
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 16),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),

                                        SizedBox(
                                          height: 10,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                child: Align(
                                                  alignment:
                                                  Alignment.centerLeft,
                                                  child: ImageIcon(
                                                    AssetImage(ic_location),
                                                    color: Colors.green,
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 2,
                                                child: Container(
                                                  margin: EdgeInsets.only(
                                                      left: 16, right: 5),
                                                  child: SelectableText(
                                                    bookings[index]
                                                        .providerAddress![0][0],
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 16),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                child: Align(
                                                  alignment:
                                                  Alignment.centerLeft,
                                                  child: ImageIcon(
                                                    AssetImage(calling),
                                                    color: Colors.green,
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 2,
                                                child: Container(
                                                  margin: EdgeInsets.only(
                                                      left: 16, right: 5),
                                                  child: SelectableText(
                                                    bookings[index]!
                                                        .providerPhoneNo![0].toInt().toString(),
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 16),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(7.0),
                                          child: Divider(
                                            height: 2,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        // Padding(
                                        //   padding: const EdgeInsets.all(7.0),
                                        //   child: Container(
                                        //     child: Row(
                                        //       children: [
                                        //         Expanded(
                                        //           child: ElevatedButton(
                                        //             style: ElevatedButton
                                        //                 .styleFrom(
                                        //               backgroundColor:
                                        //                   Color(0Xff5F60B9),
                                        //               shape:
                                        //                   RoundedRectangleBorder(
                                        //                       borderRadius:
                                        //                           BorderRadius
                                        //                               .circular(
                                        //                                   5.0)),
                                        //               // Background color
                                        //             ),
                                        //             onPressed: () {
                                        //               showDialogFunc(
                                        //                 context,
                                        //                 bookings[index]
                                        //                     .customerId![0]
                                        //                     .name,
                                        //                 bookings[index]
                                        //                     .bookingAddress,
                                        //                 bookings[index]
                                        //                     .bookingTime,
                                        //                 "pending",
                                        //                 () {
                                        //                   bookingStatus.status =
                                        //                       "Accepted";
                                        //                   BookingService.updateBookingStatus(
                                        //                           bookingStatus,
                                        //                           bookings[
                                        //                                   index]
                                        //                               .bookingId)
                                        //                       .then(
                                        //                     (response) {
                                        //                       if (response !=
                                        //                           null) {
                                        //                         FormHelper
                                        //                             .showSimpleAlertDialog(
                                        //                           context,
                                        //                           Config
                                        //                               .appName,
                                        //                           "Booking Request is accepted by you!",
                                        //                           "OK",
                                        //                           () {
                                        //                             ref.refresh(
                                        //                                 bookingDataProvider);
                                        //                             Navigator
                                        //                                 .pushNamedAndRemoveUntil(
                                        //                               context,
                                        //                               '/booking',
                                        //                               (route) =>
                                        //                                   false,
                                        //                             );
                                        //                           },
                                        //                         );
                                        //                       } else {
                                        //                         FormHelper
                                        //                             .showSimpleAlertDialog(
                                        //                           context,
                                        //                           Config
                                        //                               .appName,
                                        //                           "Something went wrong!",
                                        //                           "OK",
                                        //                           () {
                                        //                             ref.invalidate(
                                        //                                 bookingDataProvider);
                                        //                             Navigator.of(
                                        //                                     context)
                                        //                                 .pop();
                                        //                           },
                                        //                         );
                                        //                       }
                                        //                     },
                                        //                   );
                                        //                 },
                                        //               );
                                        //             },
                                        //             child: const Padding(
                                        //               padding:
                                        //                   EdgeInsets.all(15.0),
                                        //               child: Text(
                                        //                 "ACCEPT",
                                        //                 style: TextStyle(
                                        //                     color: Colors.white,
                                        //                     fontSize: 14,
                                        //                     fontWeight:
                                        //                         FontWeight.w500,
                                        //                     fontFamily:
                                        //                         "Work Sans"),
                                        //               ),
                                        //             ),
                                        //           ),
                                        //         ),
                                        //         SizedBox(
                                        //           width: 20,
                                        //         ),
                                        //         Expanded(
                                        //           child: ElevatedButton(
                                        //             style: ElevatedButton
                                        //                 .styleFrom(
                                        //               backgroundColor:
                                        //                   Color(0XffF6F7F9),
                                        //               shape:
                                        //                   RoundedRectangleBorder(
                                        //                       borderRadius:
                                        //                           BorderRadius
                                        //                               .circular(
                                        //                                   5.0)),
                                        //               // Background color
                                        //             ),
                                        //             onPressed: () {
                                        //               showDeclineFunc(context,
                                        //                   () {
                                        //                 bookingStatus.status =
                                        //                     "Rejected";
                                        //                 BookingService.updateBookingStatus(
                                        //                         bookingStatus,
                                        //                         bookings[index]
                                        //                             .bookingId)
                                        //                     .then(
                                        //                   (response) {
                                        //                     if (response !=
                                        //                         null) {
                                        //                       FormHelper
                                        //                           .showSimpleAlertDialog(
                                        //                         context,
                                        //                         Config.appName,
                                        //                         "Booking Request is rejcted by you!",
                                        //                         "OK",
                                        //                         () {
                                        //                           ref.invalidate(
                                        //                               bookingDataProvider);
                                        //                           Navigator
                                        //                               .pushNamedAndRemoveUntil(
                                        //                             context,
                                        //                             '/booking',
                                        //                             (route) =>
                                        //                                 false,
                                        //                           );
                                        //                         },
                                        //                       );
                                        //                     } else {
                                        //                       FormHelper
                                        //                           .showSimpleAlertDialog(
                                        //                         context,
                                        //                         Config.appName,
                                        //                         "Something went wrong!",
                                        //                         "OK",
                                        //                         () {
                                        //                           Navigator.of(
                                        //                                   context)
                                        //                               .pop();
                                        //                         },
                                        //                       );
                                        //                     }
                                        //                   },
                                        //                 );
                                        //               });
                                        //             },
                                        //             child: const Padding(
                                        //               padding:
                                        //                   EdgeInsets.all(15.0),
                                        //               child: Text(
                                        //                 "DECLINE",
                                        //                 style: TextStyle(
                                        //                     color: Color(
                                        //                         0xff1C1F34),
                                        //                     fontSize: 14,
                                        //                     fontWeight:
                                        //                         FontWeight.w500,
                                        //                     fontFamily:
                                        //                         "Work Sans"),
                                        //               ),
                                        //             ),
                                        //           ),
                                        //         )
                                        //       ],
                                        //     ),
                                        //   ),
                                        // )
                                      ],
                                    ),
                                  ));
                                } else if (bookings[index].status ==
                                    "Accepted") {
                                  return ReusableCard(
                                      cardChild: Container(
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  bookings[index].serviceLists![0].name!,
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontFamily: 'Work Sans',
                                                      color: Color(0xFF1C1F34)),
                                                ),
                                              ),
                                              Expanded(
                                                child: Container(
                                                  width: 30,
                                                  height: 30,
                                                  margin: EdgeInsets.only(
                                                      left: 16, right: 5),
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                      color: Colors.white,
                                                      width: 2,
                                                    ),
                                                    color: Colors.greenAccent
                                                        .withOpacity(0.5),
                                                    borderRadius:
                                                        BorderRadius.all(
                                                      Radius.circular(10),
                                                    ),
                                                  ),
                                                  child: Align(
                                                    alignment: Alignment.center,
                                                    child: Text(
                                                      bookings[index].status!,
                                                      style: TextStyle(
                                                          fontFamily:
                                                              'Work Sans',
                                                          color:
                                                              Colors.green[800],
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 12),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                child: Container(
                                                  margin: EdgeInsets.only(
                                                      left: 16, right: 5),
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                      color: primaryColor,
                                                      width: 2,
                                                    ),
                                                    color: primaryColor,
                                                    borderRadius:
                                                        BorderRadius.all(
                                                      Radius.circular(10),
                                                    ),
                                                  ),
                                                  child: Align(
                                                    alignment: Alignment.center,
                                                    child: Text(
                                                      "ID #" +
                                                          bookings[index]
                                                              .bookingId!
                                                              .toString(),
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 16),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 30,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                child: Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: ImageIcon(
                                                    AssetImage(ic_location),
                                                    color: Color(0XFF130F26),
                                                  ),
                                                ),
                                                flex: 1,
                                              ),
                                              Expanded(
                                                flex: 2,
                                                child: Container(
                                                  margin: EdgeInsets.only(
                                                      left: 16, right: 5),
                                                  child: SelectableText(
                                                    bookings[index]
                                                        .bookingAddress!,
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 16),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                child: Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: ImageIcon(
                                                    AssetImage(calendar),
                                                    color: Color(0XFF130F26),
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 2,
                                                child: Container(
                                                  margin: EdgeInsets.only(
                                                      left: 16, right: 5),
                                                  child: Text(
                                                    bookings[index]
                                                        .bookingTime!,
                                                    // DateFormat('dd MMM, EEE, '
                                                    //         'yyyy GG hh:mm aaa')
                                                    //     .format(DateTime.parse(
                                                    //         bookings[index]
                                                    //             .bookingTime!)),
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 16),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                child: Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: ImageIcon(
                                                    AssetImage(profile),
                                                    color: Color(0XFF130F26),
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 2,
                                                child: Container(
                                                  margin: EdgeInsets.only(
                                                      left: 16, right: 5),
                                                  child: Text(
                                                    bookings[index]
                                                        .customerName![0],
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 16),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                child: Align(
                                                  alignment:
                                                  Alignment.centerLeft,
                                                  child: ImageIcon(
                                                    AssetImage(calling),
                                                    color: Color(0XFF130F26),
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 2,
                                                child: Container(
                                                  margin: EdgeInsets.only(
                                                      left: 16, right: 5),
                                                  child: SelectableText(
                                                    bookings[index]
                                                        .customerPhoneNo![0].toString(),
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 16),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(7.0),
                                          child: Divider(
                                            height: 2,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                child: Align(
                                                  alignment:
                                                  Alignment.centerLeft,
                                                  child: ImageIcon(
                                                    AssetImage(profile),
                                                    color: Colors.green,
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 2,
                                                child: Container(
                                                  margin: EdgeInsets.only(
                                                      left: 16, right: 5),
                                                  child: SelectableText(
                                                    bookings[index]
                                                        .providerName![0],
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 16),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                          const EdgeInsets.all(
                                              10),
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment
                                                .center,
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder:
                                                              (context) {
                                                            return CustomerOrderReviewScreen(
                                                                booking:
                                                                bookings![index],
                                                                serviceName: bookings[
                                                                index]
                                                                    .serviceLists![
                                                                0]
                                                                    .name!,
                                                                providername:
                                                                bookings[index]
                                                                    .providerName![0]);
                                                          }));
                                                },
                                                child: Text(
                                                  "ORDER PREVIEW",
                                                  style: TextStyle(
                                                      fontFamily:
                                                      'Work Sans',
                                                      color:
                                                      primaryColor),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(7.0),
                                          child: Divider(
                                            height: 2,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        // Padding(
                                        //   padding: const EdgeInsets.all(7.0),
                                        //   child: Container(
                                        //     child: Row(
                                        //       children: [
                                        //         Expanded(
                                        //           child: ElevatedButton(
                                        //             style: ElevatedButton
                                        //                 .styleFrom(
                                        //               backgroundColor:
                                        //                   Color(0Xff5F60B9),
                                        //               shape:
                                        //                   RoundedRectangleBorder(
                                        //                       borderRadius:
                                        //                           BorderRadius
                                        //                               .circular(
                                        //                                   5.0)),
                                        //               // Background color
                                        //             ),
                                        //             onPressed: () {
                                        //               showDialogFunc(
                                        //                   context,
                                        //                   bookings[index]
                                        //                       .customerId![0]
                                        //                       .name,
                                        //                   bookings[index]
                                        //                       .bookingAddress,
                                        //                   bookings[index]
                                        //                       .bookingTime,
                                        //                   "Completed", () {
                                        //                 bookingStatus.status =
                                        //                     "Completed";
                                        //                 BookingService.updateBookingStatus(
                                        //                         bookingStatus,
                                        //                         bookings[index]
                                        //                             .bookingId)
                                        //                     .then(
                                        //                   (response) {
                                        //                     if (response !=
                                        //                         null) {
                                        //                       FormHelper
                                        //                           .showSimpleAlertDialog(
                                        //                         context,
                                        //                         Config.appName,
                                        //                         "Request is done!",
                                        //                         "OK",
                                        //                         () {
                                        //                           ref.invalidate(
                                        //                               bookingDataProvider);
                                        //                           Navigator
                                        //                               .pushNamedAndRemoveUntil(
                                        //                             context,
                                        //                             '/booking',
                                        //                             (route) =>
                                        //                                 false,
                                        //                           );
                                        //                         },
                                        //                       );
                                        //                     } else {
                                        //                       FormHelper
                                        //                           .showSimpleAlertDialog(
                                        //                         context,
                                        //                         Config.appName,
                                        //                         "Something went wrong!",
                                        //                         "OK",
                                        //                         () {
                                        //                           ref.invalidate(
                                        //                               bookingDataProvider);
                                        //                           Navigator.of(
                                        //                                   context)
                                        //                               .pop();
                                        //                         },
                                        //                       );
                                        //                     }
                                        //                   },
                                        //                 );
                                        //               });
                                        //             },
                                        //             child: const Padding(
                                        //               padding:
                                        //                   EdgeInsets.all(15.0),
                                        //               child: Text(
                                        //                 "COMPLETED",
                                        //                 style: TextStyle(
                                        //                     color: Colors.white,
                                        //                     fontSize: 14,
                                        //                     fontWeight:
                                        //                         FontWeight.w500,
                                        //                     fontFamily:
                                        //                         "Work Sans"),
                                        //               ),
                                        //             ),
                                        //           ),
                                        //         ),
                                        //         SizedBox(
                                        //           width: 20,
                                        //         ),
                                        //         Expanded(
                                        //           child: ElevatedButton(
                                        //             style: ElevatedButton
                                        //                 .styleFrom(
                                        //               backgroundColor:
                                        //                   Color(0XffF6F7F9),
                                        //               shape:
                                        //                   RoundedRectangleBorder(
                                        //                       borderRadius:
                                        //                           BorderRadius
                                        //                               .circular(
                                        //                                   5.0)),
                                        //               // Background color
                                        //             ),
                                        //             onPressed: () {
                                        //               showDeclineFunc(context,
                                        //                   () {
                                        //                 bookingStatus.status =
                                        //                     "Rejected";
                                        //                 BookingService.updateBookingStatus(
                                        //                         bookingStatus,
                                        //                         bookings[index]
                                        //                             .bookingId)
                                        //                     .then(
                                        //                   (response) {
                                        //                     if (response !=
                                        //                         null) {
                                        //                       FormHelper
                                        //                           .showSimpleAlertDialog(
                                        //                         context,
                                        //                         Config.appName,
                                        //                         "Booking Request is rejcted by you!",
                                        //                         "OK",
                                        //                         () {
                                        //                           ref.invalidate(
                                        //                               bookingDataProvider);
                                        //                           Navigator
                                        //                               .pushNamedAndRemoveUntil(
                                        //                             context,
                                        //                             '/booking',
                                        //                             (route) =>
                                        //                                 false,
                                        //                           );
                                        //                         },
                                        //                       );
                                        //                     } else {
                                        //                       FormHelper
                                        //                           .showSimpleAlertDialog(
                                        //                         context,
                                        //                         Config.appName,
                                        //                         "Something went wrong!",
                                        //                         "OK",
                                        //                         () {
                                        //                           ref.invalidate(
                                        //                               bookingDataProvider);
                                        //                           Navigator.of(
                                        //                                   context)
                                        //                               .pop();
                                        //                         },
                                        //                       );
                                        //                     }
                                        //                   },
                                        //                 );
                                        //               });
                                        //             },
                                        //             child: const Padding(
                                        //               padding:
                                        //                   EdgeInsets.all(15.0),
                                        //               child: Text(
                                        //                 "DECLINE",
                                        //                 style: TextStyle(
                                        //                     color: Color(
                                        //                         0xff1C1F34),
                                        //                     fontSize: 14,
                                        //                     fontWeight:
                                        //                         FontWeight.w500,
                                        //                     fontFamily:
                                        //                         "Work Sans"),
                                        //               ),
                                        //             ),
                                        //           ),
                                        //         )
                                        //       ],
                                        //     ),
                                        //   ),
                                        // )
                                      ],
                                    ),
                                  ));
                                } else if (bookings[index].status ==
                                    "Declined") {
                                  return ReusableCard(
                                      cardChild: Container(
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  bookings[index].serviceLists![0].name!,
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontFamily: 'Work Sans',
                                                      color: Color(0xFF1C1F34)),
                                                ),
                                              ),
                                              Expanded(
                                                child: Container(
                                                  width: 30,
                                                  height: 30,
                                                  margin: EdgeInsets.only(
                                                      left: 16, right: 5),
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                      color: Colors.white,
                                                      width: 2,
                                                    ),
                                                    color: Colors.redAccent
                                                        .withOpacity(0.5),
                                                    borderRadius:
                                                        BorderRadius.all(
                                                      Radius.circular(10),
                                                    ),
                                                  ),
                                                  child: Align(
                                                    alignment: Alignment.center,
                                                    child: Text(
                                                      bookings[index].status!,
                                                      style: TextStyle(
                                                          color:
                                                              Colors.red[800],
                                                          fontFamily:
                                                              'Work Sans',
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 12),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                child: Container(
                                                    margin: EdgeInsets.only(
                                                        left: 16, right: 5),
                                                    decoration: BoxDecoration(
                                                      border: Border.all(
                                                        color: primaryColor,
                                                        width: 2,
                                                      ),
                                                      color: primaryColor,
                                                      borderRadius:
                                                          BorderRadius.all(
                                                        Radius.circular(10),
                                                      ),
                                                    ),
                                                    child: Text(
                                                      bookings[index]
                                                          .bookingId!
                                                          .toString(),
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 16),
                                                    )),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 30,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                child: Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: ImageIcon(
                                                    AssetImage(ic_location),
                                                    color: Color(0XFF130F26),
                                                  ),
                                                ),
                                                flex: 1,
                                              ),
                                              Expanded(
                                                flex: 2,
                                                child: Container(
                                                  margin: EdgeInsets.only(
                                                      left: 16, right: 5),
                                                  child: SelectableText(
                                                    bookings[index]
                                                        .bookingAddress!,
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 16),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                child: Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: ImageIcon(
                                                    AssetImage(calendar),
                                                    color: Color(0XFF130F26),
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 2,
                                                child: Container(
                                                  margin: EdgeInsets.only(
                                                      left: 16, right: 5),
                                                  child: Text(
                                                    bookings[index]
                                                        .bookingTime!,
                                                    // DateFormat('dd MMM, EEE, '
                                                    //         'yyyy GG hh:mm aaa')
                                                    //     .format(DateTime.parse(
                                                    //         bookings[index]
                                                    //             .bookingTime!)),
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 16),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                child: Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: ImageIcon(
                                                    AssetImage(profile),
                                                    color: Color(0XFF130F26),
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 2,
                                                child: Container(
                                                  margin: EdgeInsets.only(
                                                      left: 16, right: 5),
                                                  child: Text(
                                                    bookings[index]
                                                        .customerName![0],
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 16),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                child: Align(
                                                  alignment:
                                                  Alignment.centerLeft,
                                                  child: ImageIcon(
                                                    AssetImage(calling),
                                                    color: Color(0XFF130F26),
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 2,
                                                child: Container(
                                                  margin: EdgeInsets.only(
                                                      left: 16, right: 5),
                                                  child: SelectableText(
                                                    bookings[index]
                                                        .customerPhoneNo![0].toString(),
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 16),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(7.0),
                                          child: Divider(
                                            height: 2,
                                          ),
                                        ),

                                        SizedBox(
                                          height: 10,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                child: Align(
                                                  alignment:
                                                  Alignment.centerLeft,
                                                  child: ImageIcon(
                                                    AssetImage(profile),
                                                    color: Colors.green,
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 2,
                                                child: Container(
                                                  margin: EdgeInsets.only(
                                                      left: 16, right: 5),
                                                  child: SelectableText(
                                                    bookings[index]
                                                        .providerPhoneNo![0].toString(),
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 16),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                          const EdgeInsets.all(
                                              10),
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment
                                                .center,
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder:
                                                              (context) {
                                                            return CustomerOrderReviewScreen(
                                                                booking:
                                                                bookings![index],
                                                                serviceName: bookings[
                                                                index]
                                                                    .serviceLists![
                                                                0]
                                                                    .name!,
                                                                providername:
                                                                bookings[index]
                                                                    .providerName![0]);
                                                          }));
                                                },
                                                child: Text(
                                                  "ORDER PREVIEW",
                                                  style: TextStyle(
                                                      fontFamily:
                                                      'Work Sans',
                                                      color:
                                                      primaryColor),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(7.0),
                                          child: Divider(
                                            height: 2,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        // Padding(
                                        //   padding: const EdgeInsets.all(7.0),
                                        //   child: Container(
                                        //     child: Row(
                                        //       children: [
                                        //         Expanded(
                                        //           child: ElevatedButton(
                                        //             style: ElevatedButton
                                        //                 .styleFrom(
                                        //               backgroundColor:
                                        //                   Color(0Xff5F60B9),
                                        //               disabledBackgroundColor:
                                        //                   Theme.of(context)
                                        //                       .primaryColor
                                        //                       .withOpacity(
                                        //                           .8), // Background Color
                                        //               disabledForegroundColor:
                                        //                   Colors
                                        //                       .white70, //Text Color
                                        //               shape:
                                        //                   RoundedRectangleBorder(
                                        //                       borderRadius:
                                        //                           BorderRadius
                                        //                               .circular(
                                        //                                   5.0)),
                                        //               // Background color
                                        //             ),
                                        //             onPressed: () {},
                                        //             child: const Padding(
                                        //               padding:
                                        //                   EdgeInsets.all(15.0),
                                        //               child: Text(
                                        //                 "ACCEPT",
                                        //                 style: TextStyle(
                                        //                     color: Colors.white,
                                        //                     fontSize: 14,
                                        //                     fontWeight:
                                        //                         FontWeight.w500,
                                        //                     fontFamily:
                                        //                         "Work Sans"),
                                        //               ),
                                        //             ),
                                        //           ),
                                        //         ),
                                        //         SizedBox(
                                        //           width: 20,
                                        //         ),
                                        //         Expanded(
                                        //           child: ElevatedButton(
                                        //             style: ElevatedButton
                                        //                 .styleFrom(
                                        //               backgroundColor:
                                        //                   Color(0XffF6F7F9),
                                        //               shape:
                                        //                   RoundedRectangleBorder(
                                        //                       borderRadius:
                                        //                           BorderRadius
                                        //                               .circular(
                                        //                                   5.0)),
                                        //               // Background color
                                        //             ),
                                        //             onPressed: () {
                                        //               showDeclineFunc(context,
                                        //                   () {
                                        //                 bookingStatus.status =
                                        //                     "Rejected";
                                        //                 BookingService.updateBookingStatus(
                                        //                         bookingStatus,
                                        //                         bookings[index]
                                        //                             .bookingId)
                                        //                     .then(
                                        //                   (response) {
                                        //                     if (response !=
                                        //                         null) {
                                        //                       FormHelper
                                        //                           .showSimpleAlertDialog(
                                        //                         context,
                                        //                         Config.appName,
                                        //                         "Booking Request is rejcted by you!",
                                        //                         "OK",
                                        //                         () {
                                        //                           ref.invalidate(
                                        //                               bookingDataProvider);
                                        //                           Navigator
                                        //                               .pushNamedAndRemoveUntil(
                                        //                             context,
                                        //                             '/booking',
                                        //                             (route) =>
                                        //                                 false,
                                        //                           );
                                        //                         },
                                        //                       );
                                        //                     } else {
                                        //                       FormHelper
                                        //                           .showSimpleAlertDialog(
                                        //                         context,
                                        //                         Config.appName,
                                        //                         "Something went wrong!",
                                        //                         "OK",
                                        //                         () {
                                        //                           ref.invalidate(
                                        //                               bookingDataProvider);
                                        //                           Navigator.of(
                                        //                                   context)
                                        //                               .pop();
                                        //                         },
                                        //                       );
                                        //                     }
                                        //                   },
                                        //                 );
                                        //               });
                                        //             },
                                        //             child: const Padding(
                                        //               padding:
                                        //                   EdgeInsets.all(15.0),
                                        //               child: Text(
                                        //                 "DECLINE",
                                        //                 style: TextStyle(
                                        //                     color: Color(
                                        //                         0xff1C1F34),
                                        //                     fontSize: 14,
                                        //                     fontWeight:
                                        //                         FontWeight.w500,
                                        //                     fontFamily:
                                        //                         "Work Sans"),
                                        //               ),
                                        //             ),
                                        //           ),
                                        //         )
                                        //       ],
                                        //     ),
                                        //   ),
                                        // )
                                      ],
                                    ),
                                  ));
                                } else {
                                  return ReusableCard(
                                      cardChild: Container(
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  bookings[index].serviceLists![0].name!,
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontFamily: 'Work Sans',
                                                      color: Color(0xFF1C1F34)),
                                                ),
                                              ),
                                              Expanded(
                                                child: Container(
                                                  width: 30,
                                                  height: 30,
                                                  margin: EdgeInsets.only(
                                                      left: 16, right: 5),
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                      color: Colors.white,
                                                      width: 2,
                                                    ),
                                                    color: Colors.redAccent
                                                        .withOpacity(0.5),
                                                    borderRadius:
                                                        BorderRadius.all(
                                                      Radius.circular(10),
                                                    ),
                                                  ),
                                                  child: Align(
                                                    alignment: Alignment.center,
                                                    child: Text(
                                                      bookings[index].status!,
                                                      style: TextStyle(
                                                          color: Colors.red,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 10),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                child: Container(
                                                  margin: EdgeInsets.only(
                                                      left: 16, right: 5),
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                      color: primaryColor,
                                                      width: 2,
                                                    ),
                                                    color: primaryColor,
                                                    borderRadius:
                                                        BorderRadius.all(
                                                      Radius.circular(10),
                                                    ),
                                                  ),
                                                  child: Align(
                                                    alignment: Alignment.center,
                                                    child: Text(
                                                      "ID #" +
                                                          bookings[index]
                                                              .bookingId!
                                                              .toString(),
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 16),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 30,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                child: Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: ImageIcon(
                                                    AssetImage(ic_location),
                                                    color: Color(0XFF130F26),
                                                  ),
                                                ),
                                                flex: 1,
                                              ),
                                              Expanded(
                                                flex: 2,
                                                child: Container(
                                                  margin: EdgeInsets.only(
                                                      left: 16, right: 5),
                                                  child: SelectableText(
                                                    bookings[index]
                                                        .bookingAddress!,
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 16),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                child: Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: ImageIcon(
                                                    AssetImage(calendar),
                                                    color: Color(0XFF130F26),
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 2,
                                                child: Container(
                                                  margin: EdgeInsets.only(
                                                      left: 16, right: 5),
                                                  child: Text(
                                                    bookings[index]
                                                        .bookingTime!,
                                                    // DateFormat('dd MMM, EEE, '
                                                    //         'yyyy GG hh:mm aaa')
                                                    //     .format(DateTime.parse(
                                                    //         bookings[index]
                                                    //             .bookingTime!)),
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 16),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                child: Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: ImageIcon(
                                                    AssetImage(profile),
                                                    color: Color(0XFF130F26),
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 2,
                                                child: Container(
                                                  margin: EdgeInsets.only(
                                                      left: 16, right: 5),
                                                  child: Text(
                                                    bookings[index]
                                                        .customerName![0],
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 16),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                child: Align(
                                                  alignment:
                                                  Alignment.centerLeft,
                                                  child: ImageIcon(
                                                    AssetImage(calling),
                                                    color: Color(0XFF130F26),
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 2,
                                                child: Container(
                                                  margin: EdgeInsets.only(
                                                      left: 16, right: 5),
                                                  child: SelectableText(
                                                    bookings[index]
                                                        .customerPhoneNo![0].toString(),
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 16),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(7.0),
                                          child: Divider(
                                            height: 2,
                                          ),
                                        ),

                                        SizedBox(
                                          height: 10,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                child: Align(
                                                  alignment:
                                                  Alignment.centerLeft,
                                                  child: ImageIcon(
                                                    AssetImage(profile),
                                                    color: Colors.green,
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 2,
                                                child: Container(
                                                  margin: EdgeInsets.only(
                                                      left: 16, right: 5),
                                                  child: SelectableText(
                                                    bookings[index]
                                                        .providerName![0],
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 16),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                child: Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: ImageIcon(
                                                    AssetImage(ic_cash),
                                                    color: Color(0XFF130F26),
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                flex: bookings[index]
                                                            .paymentMode ==
                                                        'Cash'
                                                    ? 1
                                                    : 2,
                                                child: Container(
                                                  margin: EdgeInsets.only(
                                                      left: 16, right: 5),
                                                  child: bookings[index]
                                                              .status ==
                                                          'Done'
                                                      ? Text(
                                                          "Paid",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.green,
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w800,
                                                              fontFamily:
                                                                  'Work Sans'),
                                                        )
                                                      : Text(
                                                          "Pending",
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .deepOrangeAccent,
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w800,
                                                              fontFamily:
                                                                  'Work Sans'),
                                                        ),
                                                ),
                                              ),
                                              bookings[index].paymentMode ==
                                                          'Cash' &&
                                                      bookings[index].status !=
                                                          'Done'
                                                  ? Expanded(
                                                      flex: 1,
                                                      child: ElevatedButton(
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                          backgroundColor:
                                                              Colors.green,
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10.0)),
                                                          // Background color
                                                        ),
                                                        onPressed: () async {
                                                          var response = await ref
                                                              .read(
                                                                  authOtpProvider)
                                                              .requestOtp("+" +
                                                                  bookings[
                                                                          index]
                                                                      .customerPhoneNo![0]
                                                                      .toString());

                                                          if (response !=
                                                              null) {
                                                            ScaffoldMessenger
                                                                    .of(context)
                                                                .showSnackBar(
                                                              SnackBar(
                                                                  content: Text(
                                                                      'OTP sent to customer!')),
                                                            );
                                                            Navigator
                                                                .pushNamedAndRemoveUntil(
                                                              context,
                                                              '/paymentVerification',
                                                              arguments:
                                                                  bookings[
                                                                          index]
                                                                      .bookingId,
                                                              (route) => true,
                                                            );
                                                          } else {
                                                            ScaffoldMessenger
                                                                    .of(context)
                                                                .showSnackBar(
                                                              SnackBar(
                                                                  content: Text(
                                                                      'Somethting went wrong!')),
                                                            );
                                                          }
                                                        },
                                                        child: const Text(
                                                          'Cash Recieved',
                                                          style: TextStyle(
                                                              fontSize: 12,
                                                              fontFamily:
                                                                  'Work Sans',
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                      ),
                                                    )
                                                  : Container(),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                          const EdgeInsets.all(
                                              10),
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment
                                                .center,
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder:
                                                              (context) {
                                                            return CustomerOrderReviewScreen(
                                                                booking:
                                                                bookings![index],
                                                                serviceName: bookings[
                                                                index]
                                                                    .serviceLists![
                                                                0]
                                                                    .name!,
                                                                providername:
                                                                bookings[index]
                                                                    .providerName![0]);
                                                          }));
                                                },
                                                child: Text(
                                                  "ORDER PREVIEW",
                                                  style: TextStyle(
                                                      fontFamily:
                                                      'Work Sans',
                                                      color:
                                                      primaryColor),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(7.0),
                                          child: Divider(
                                            height: 2,
                                            thickness: 1.8,
                                          ),
                                        ),
                                        // Container(
                                        //   child: Row(
                                        //     mainAxisAlignment:
                                        //         MainAxisAlignment.center,
                                        //     children: [
                                        //       InkWell(
                                        //         onTap: () async {
                                        //           await Navigator.push(
                                        //               context,
                                        //               MaterialPageRoute(
                                        //                 builder: (context) =>
                                        //                     LaundryGenerateBillScreen(
                                        //                         bookingResponseModel:
                                        //                             bookings[
                                        //                                 index]),
                                        //               ));
                                        //         },
                                        //         child: Container(
                                        //             child: Row(
                                        //           children: [
                                        //             Text(
                                        //               "Generate bill",
                                        //               style: TextStyle(
                                        //                   fontFamily:
                                        //                       'Work Sans',
                                        //                   fontSize: 18,
                                        //                   color: primaryColor,
                                        //                   fontWeight:
                                        //                       FontWeight.w500),
                                        //             ),
                                        //             SizedBox(
                                        //               width: 10,
                                        //             ),
                                        //             const ImageIcon(
                                        //               AssetImage(
                                        //                   ic_edit_service),
                                        //               color: primaryColor,
                                        //               size: 15,
                                        //             )
                                        //           ],
                                        //         )),
                                        //       )
                                        //     ],
                                        //   ),
                                        // ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        // Padding(
                                        //   padding: const EdgeInsets.all(7.0),
                                        //   child: Container(
                                        //     child: Row(
                                        //       children: [
                                        //         Expanded(
                                        //           child: ElevatedButton(
                                        //             style: ElevatedButton
                                        //                 .styleFrom(
                                        //               backgroundColor:
                                        //                   Color(0Xff5F60B9),
                                        //               shape:
                                        //                   RoundedRectangleBorder(
                                        //                       borderRadius:
                                        //                           BorderRadius
                                        //                               .circular(
                                        //                                   5.0)),
                                        //               // Background color
                                        //             ),
                                        //             onPressed: null,
                                        //             child: const Padding(
                                        //               padding:
                                        //                   EdgeInsets.all(15.0),
                                        //               child: Text(
                                        //                 "DONE",
                                        //                 style: TextStyle(
                                        //                     color: Colors.white,
                                        //                     fontSize: 14,
                                        //                     fontWeight:
                                        //                         FontWeight.w500,
                                        //                     fontFamily:
                                        //                         "Work Sans"),
                                        //               ),
                                        //             ),
                                        //           ),
                                        //         ),
                                        //       ],
                                        //     ),
                                        //   ),
                                        // )
                                      ],
                                    ),
                                  ));
                                }
                              }),
                        ),
                      ),
                    ],
                  )
                : Center(
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 100.0, right: 100),
                            child: Image(
                              image: AssetImage(no_data_found),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text("No Booking Found"),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Looks like your customer haven't book your service",
                          ),
                          Text(
                            "yet!",
                          )
                        ],
                      ),
                    ),
                  );
          },
          error: (err, s) => Text(err.toString()),
          loading: () => Center(
            child: CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}

// showDialogFunc(context, serviceType, customerAddress, bookingDateAndTime,
//     paymentStatus, confirmation) {
//   return showDialog(
//     context: context,
//     builder: (context) {
//       return Center(
//         child: Material(
//           type: MaterialType.transparency,
//           child: Container(
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(10),
//               color: Colors.white,
//             ),
//             // padding: EdgeInsets.all(15),
//             height: MediaQuery.of(context).size.height / 1.6,
//             width: MediaQuery.of(context).size.width * 0.7,
//             child: Column(
//               children: [
//                 Container(
//                   width: double.infinity,
//                   decoration: BoxDecoration(
//                     color: primaryColor,
//                   ),
//                   child: Padding(
//                     padding:
//                         const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         Text(
//                           "Booking Summary",
//                           style: TextStyle(
//                               color: Colors.white,
//                               fontSize: 16,
//                               fontWeight: FontWeight.bold),
//                         ),
//                         CloseButton(color: Colors.white),
//                       ],
//                     ),
//                   ),
//                 ),
//                 Expanded(
//                   child: Padding(
//                     padding: const EdgeInsets.all(15.0),
//                     child: Container(
//                       child: ListView(
//                         children: <Widget>[
//                           SizedBox(
//                             height: 10,
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text(
//                                 serviceType,
//                                 style: TextStyle(
//                                   fontSize: 16,
//                                   color: Color(0XFF1C1F34),
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                             ],
//                           ),
//                           SizedBox(
//                             height: 10,
//                           ),
//                           Divider(
//                             height: 2,
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Expanded(
//                                 child: Text(
//                                   "Address",
//                                   style: TextStyle(
//                                     fontSize: 16,
//                                     color: Color(0XFF1C1F34),
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                               ),
//                               Expanded(
//                                 child: Text(
//                                   customerAddress,
//                                   style: TextStyle(
//                                     fontSize: 11,
//                                     color: Colors.grey,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                           SizedBox(
//                             height: 10,
//                           ),
//                           Divider(
//                             height: 2,
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text(
//                                 "Date",
//                                 style: TextStyle(
//                                   fontSize: 16,
//                                   color: Color(0XFF1C1F34),
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                               Text(
//                                 bookingDateAndTime,
//                                 // DateFormat('dd MMM, EEE, '
//                                 //         'yyyy')
//                                 //     .format(DateTime.parse(bookingDateAndTime)),
//                                 style: TextStyle(
//                                   fontSize: 14,
//                                   color: Colors.grey,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                             ],
//                           ),
//                           SizedBox(
//                             height: 10,
//                           ),
//                           Divider(
//                             height: 2,
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text(
//                                 "Time",
//                                 style: TextStyle(
//                                   fontSize: 16,
//                                   color: Color(0XFF1C1F34),
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                               Text(
//                                 bookingDateAndTime,
//                                 // DateFormat('hh:mm aaa')
//                                 //     .format(DateTime.parse(bookingDateAndTime)),
//                                 style: TextStyle(
//                                   fontSize: 14,
//                                   color: Colors.grey,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                             ],
//                           ),
//                           SizedBox(
//                             height: 10,
//                           ),
//                           Divider(
//                             height: 2,
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text(
//                                 "Payment Status",
//                                 style: TextStyle(
//                                   fontSize: 16,
//                                   color: Color(0XFF1C1F34),
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                               Text(
//                                 paymentStatus,
//                                 style: TextStyle(
//                                   fontSize: 14,
//                                   color: Colors.grey,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                             ],
//                           ),
//                           SizedBox(
//                             height: 50,
//                           ),
//                           ElevatedButton(
//                               style: ElevatedButton.styleFrom(
//                                 backgroundColor: Color(0Xff5F60B9),
//                                 shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(10.0)),
//                                 // Background color
//                               ),
//                               onPressed: confirmation,
//                               child: const Padding(
//                                 padding: EdgeInsets.all(15.0),
//                                 child: Text(
//                                   "CONFIRM",
//                                   style: TextStyle(color: Colors.white),
//                                 ),
//                               )),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       );
//     },
//   );
// }

showDeclineFunc(context, confirmDecline) {
  return showDialog(
    context: context,
    builder: (context) {
      return Center(
        child: Material(
          type: MaterialType.transparency,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            // padding: EdgeInsets.all(15),
            height: 320,
            width: MediaQuery.of(context).size.width * 0.7,
            child: Column(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.redAccent.withOpacity(0.4),
                    ),
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                      child: ImageIcon(AssetImage(pricing_plan_reject)),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(
                            height: 10,
                          ),
                          Expanded(
                            child: Text(
                              "Are you sure to reject this request? ",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Expanded(
                            child: Row(
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
                                    Navigator.of(context).pop();
                                  },
                                  child: const Padding(
                                    padding: EdgeInsets.all(15.0),
                                    child: Text(
                                      "NO",
                                      style: TextStyle(color: Colors.white),
                                    ),
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
                                  onPressed: confirmDecline,
                                  child: const Padding(
                                    padding: EdgeInsets.all(15.0),
                                    child: Text(
                                      "YES",
                                      style: TextStyle(color: Colors.white),
                                    ),
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
              ],
            ),
          ),
        ),
      );
    },
  );
}
