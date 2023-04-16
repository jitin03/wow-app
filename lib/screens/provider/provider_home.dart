import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:maven_class/provider/data_provider.dart';
import 'package:maven_class/screens/components/chart_component.dart';
import 'package:maven_class/screens/provider/provider_services.dart';
import 'package:maven_class/utils/config.dart';
import 'package:maven_class/utils/images.dart';

class ProviderHome extends ConsumerWidget {
  const ProviderHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final allBookings = ref.watch(allbookingProvider);

    return SingleChildScrollView(
        physics: ScrollPhysics(),
        child: allBookings.when(
          data: (data) {
            return Column(
              children: [
                Container(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: double.infinity,
                        margin: EdgeInsets.only(left: 16, right: 16),
                        child: Text(
                          "Hello WowService!",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        width: double.infinity,
                        margin: EdgeInsets.only(left: 16),
                        child: Text(
                          "Welcome back!",
                          style: TextStyle(fontWeight: FontWeight.normal),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                ),

                SizedBox(
                  height: 10,
                ),
                Container(
                  margin: EdgeInsets.only(left: 16, right: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: (){
                            ref.invalidate(allbookingProvider);
                            Navigator.pushNamedAndRemoveUntil(
                              context,
                              '/all-bookings',
                                  (route) => false,
                            );
                          },
                          child: Container(
                            // width: double.infinity,
                            padding: const EdgeInsets.symmetric(
                                vertical: 20.0, horizontal: 0),

                            decoration: BoxDecoration(
                                color: primaryColor,
                                border: Border.all(
                                  color: Color(0XFFEBEBEB),
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                )),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10.0, horizontal: 10),
                                  child: Container(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          allBookings.value!.length.toString(),
                                          style: TextStyle(
                                              fontFamily: 'Work Sans',
                                              color: Colors.white,
                                              fontSize: 22,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        Text(
                                          "Today's Services",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontFamily: 'Work Sans',
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: Container(
                                    padding: EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Color(0XFFF0F0FA)),
                                    child: Image.asset(ic_document,
                                        height: 22,
                                        width: 22,
                                        color: primaryColor),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // ChartComponent(),
              ],
            );
          },
          error: (err, s) => Text(err.toString()),
          loading: () => Center(
            child: CircularProgressIndicator(),
          ),
        ),);
  }
}
