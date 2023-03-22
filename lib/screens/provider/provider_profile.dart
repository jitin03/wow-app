import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:maven_class/model/provide_profile_email.dart';
import 'package:maven_class/provider/data_provider.dart';
import 'package:maven_class/screens/components/profile_widget.dart';
import 'package:maven_class/utils/config.dart';
import 'package:maven_class/utils/images.dart';

class ProviderProfileScreen extends ConsumerStatefulWidget {
  const ProviderProfileScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ProviderProfileScreen> createState() =>
      _CustomerProfileScreenState();
}

class _CustomerProfileScreenState extends ConsumerState<ProviderProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final profileData = ref.watch(providerProfileDataProvider);

    return Container(
      child: profileData.when(
        data: (_data) {
          return ListView(
            physics: BouncingScrollPhysics(),
            children: [
              const SizedBox(height: 24),
              ProfileWidget(onClicked: () async {}),
              const SizedBox(height: 24),
              buildName(_data),
              const SizedBox(height: 24),
              buildPersonalInfo(_data),
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

  Widget buildName(ProviderDetail data) => Column(
        children: [
          Text(
            data.name.toString(),
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          const SizedBox(height: 4),
          Text(
            data.phonenumber.toString(),
            style: TextStyle(color: Colors.grey),
          )
        ],
      );

  Widget buildPersonalInfo(ProviderDetail data) => Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Card(
            elevation: 2,
            child: Container(
              decoration: BoxDecoration(color: Color(0xFFF0F0FA)),
              padding: EdgeInsets.all(20),
              width: double.infinity,
              child: Text(
                "PERFSONAL INFORMATION",
                style: TextStyle(
                    fontFamily: 'Work Sans',
                    color: primaryColor,
                    fontWeight: FontWeight.w800),
              ),
            ),
          ),
          Container(
            color: Colors.white,
            padding: EdgeInsets.only(left: 5),
            child: ListTile(
              title: Container(
                margin: EdgeInsets.only(left: 0, right: 40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text("Full Name: "),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(data!.name.toString(),
                        style: TextStyle(
                          fontFamily: 'Work Sans',
                        ))
                  ],
                ),
              ),
              leading: ImageIcon(AssetImage(profile)),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 5),
            child: ListTile(
              title: Container(
                margin: EdgeInsets.only(left: 0, right: 40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Align(
                        alignment: Alignment.topLeft,
                        child: Text("Phone No: ")),
                    SizedBox(
                      width: 10,
                    ),
                    Text(data!.phonenumber.toString(),
                        style: TextStyle(
                          fontFamily: 'Work Sans',
                        ))
                  ],
                ),
              ),
              leading: ImageIcon(AssetImage(calling)),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 5),
            child: ListTile(
              title: Container(
                margin: EdgeInsets.only(left: 0, right: 40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("Services List: "),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            data!.serviceLists![0].name.toString(),
                            style: TextStyle(
                              fontFamily: 'Work Sans',
                            ),
                          ),
                          // Text(
                          //   data!.serviceLists![1].name.toString(),
                          //   style: TextStyle(
                          //     fontFamily: 'Work Sans',
                          //   ),
                          // )
                        ],
                      ),
                    ),

                  ],
                ),
              ),
              leading: ImageIcon(AssetImage(ic_message)),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 5),
            child: ListTile(
              title: Container(
                margin: EdgeInsets.only(left: 0, right: 40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("Address: "),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: FittedBox(
                        child: Text(
                          data!.address![0].address1.toString(),
                          style: TextStyle(
                            fontFamily: 'Work Sans',
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              leading: ImageIcon(AssetImage(ic_location)),
            ),
          ),
          Divider(
            height: 2,
          ),
          SizedBox(
            height: 24,
          ),
          Center(
            child: InkWell(
              onTap: () async {
                ref.watch(shareServiceDataProvider);
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/sigin',
                  (route) => false,
                );
              },
              child: Text(
                "Logout",
                style: TextStyle(
                    fontFamily: 'Work Sans',
                    color: primaryColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w500),
              ),
            ),
          )
        ],
      );
}
