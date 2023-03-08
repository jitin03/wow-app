import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:maven_class/provider/data_provider.dart';
import 'package:maven_class/utils/config.dart';
import 'package:maven_class/utils/images.dart';

class ProviderProfileFragment extends ConsumerStatefulWidget {
  @override
  ConsumerState<ProviderProfileFragment> createState() =>
      _ProviderProfileFragmentState();
}

class _ProviderProfileFragmentState
    extends ConsumerState<ProviderProfileFragment> {
  @override
  Widget build(BuildContext context) {
    final _providerFiledata = ref.watch(providerProfileDataProvider);
    return Container(
      width: double.infinity,
      child: _providerFiledata.when(
        data: (_providerFiledata) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 50),
                child: Container(
                    child: Column(
                  children: [
                    Image(image: AssetImage("assets/images/Logo.png")),
                    Text(
                      "Demo",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                          color: primaryColor),
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Text(
                      "+91-9780032269",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: Color(0XFF6C757D)),
                    ),
                  ],
                )),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: Color(0XFFF6F7F9),
                              border: Border.all(color: Color(0XFF6F7F9)),
                              borderRadius: BorderRadius.circular(10)),
                          child: TextFormField(
                            enabled: false,
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
                                hintText: "test"),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: Color(0XFFF6F7F9),
                              border: Border.all(color: Color(0XFF6F7F9)),
                              borderRadius: BorderRadius.circular(10)),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Color(0XFFF6F7F9),
                                border: Border.all(color: Color(0XFF6F7F9)),
                                borderRadius: BorderRadius.circular(10)),
                            child: TextFormField(
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
                                  hintText: "User Name"),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: Color(0XFFF6F7F9),
                              border: Border.all(color: Color(0XFF6F7F9)),
                              borderRadius: BorderRadius.circular(10)),
                          child: TextFormField(
                            obscureText: true,
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
                                hintText: "Password"),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: Color(0XFFF6F7F9),
                              border: Border.all(color: Color(0XFF6F7F9)),
                              borderRadius: BorderRadius.circular(10)),
                          child: TextFormField(
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
                                hintText: "Email Address"),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
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
