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

    final _providerFiledata = ref.watch(providerHomStats);

    return SingleChildScrollView(
        physics: ScrollPhysics(),
        child: _providerFiledata.when(
      data: (_providerFiledata) {
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
                      "Hello, ${_providerFiledata.profileData.name}",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
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
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(20),
              margin: EdgeInsets.only(left: 16, right: 16),
              decoration: BoxDecoration(
                color: Color(
                  0XffF6F7F9,
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                            "Service Name: ${_providerFiledata!.profileData.serviceLists![0].name}",style: TextStyle(fontFamily: 'Work Sans',fontSize: 14,fontWeight: FontWeight.w800)),
                        SizedBox(
                          width: 10,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return ProviderServices(
                                  providerDetail:
                                      _providerFiledata.profileData);
                            }));
                          },
                          child: const ImageIcon(
                            AssetImage(ic_edit_service),
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      child: Text("Pricing details:",style: TextStyle(fontFamily: 'Work Sans',fontSize: 14,fontWeight: FontWeight.w800)),
                    ),
                    Container(
                      child: ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                          itemCount: _providerFiledata.profileData.serviceLists![0].subCategory!.length,
                          itemBuilder: (context, index) {

                            return Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(_providerFiledata.profileData.serviceLists![0].subCategory![index].name!,style: TextStyle(fontFamily: 'Work Sans',fontSize: 14,fontWeight: FontWeight.w800),),
                                  Text('\u{20B9} ${_providerFiledata.profileData.serviceLists![0].subCategory![index].price!}',style: TextStyle(fontFamily: 'Work Sans',fontSize: 14,fontWeight: FontWeight.w800))
                                ],
                              )
                            );
                          },),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              margin: EdgeInsets.only(left: 16, right: 16),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        ref.invalidate(bookingDataProvider);
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          '/booking',
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      _providerFiledata!.bookingData!.length
                                          .toString(),
                                      style: TextStyle(
                                          fontFamily: 'Work Sans',
                                          color: Colors.white,
                                          fontSize: 22,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    Text(
                                      "Total Booking",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'Work Sans',
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,),
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
                                child: Image.asset(total_booking,
                                    height: 22, width: 22, color: primaryColor),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "98",
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
                                  height: 22, width: 22, color: primaryColor),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            ChartComponent(),
          ],
        );
      },
      error: (err, s) => Text(err.toString()),
      loading: () => Center(
        child: CircularProgressIndicator(),
      ),
    ));
  }
}
