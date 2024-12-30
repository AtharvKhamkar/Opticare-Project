import 'dart:io';

// import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:terra_flutter_bridge/models/enums.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vizzhy/flavors.dart';
import 'package:vizzhy/src/core/constants/constants.dart';
import 'package:vizzhy/src/features/try_terra/presentation/controllers/try_terra_controller.dart';
import 'package:vizzhy/src/features/try_terra/presentation/pages/logs.dart';
import 'package:vizzhy/src/features/try_terra/presentation/widgets/try_terra_connect_button.dart';
import 'package:vizzhy/src/presentation/widgets/custom_app_bar.dart';

class TryTerraConnectPage extends StatefulWidget {
  final String customerId;

  const TryTerraConnectPage({super.key, required this.customerId});

  @override
  State<TryTerraConnectPage> createState() => _TryTerraConnectPageState();
}

class _TryTerraConnectPageState extends State<TryTerraConnectPage> {
  TryTerraController controller = Get.find<TryTerraController>();

  @override
  void initState() {
    super.initState();

    Future.delayed(
        Durations.medium4, controller.checkAppleAndSamsungAndGetData);
  }

  Future<void> _launchUrl(String url) async {
    if (!await launchUrl(Uri.parse(url),
        mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MainBackgroundWrapper(
      page: GetBuilder<TryTerraController>(builder: (controller) {
        List<Widget> list = [];
        if (Platform.isIOS) {
          list.add(
            TryTerraConnectButton(
              connected: controller.isAppleHealthConnected.value,
              image: 'assets/images/tryterra/apple_health.png',
              connection: Connection.appleHealth,
              title: 'Apple Health',
              customerId: widget.customerId,
              onTap: [
                controller.initializeConnecton,
                controller.deAuthUserConnectionFromTryTerra
              ],
              controller: controller,
            ),
          );
        }

        if (Platform.isAndroid) {
          list.add(TryTerraConnectButton(
            connected: controller.isSamsungHealthConnected.value,
            image: 'assets/images/tryterra/samsung_health.png',
            connection: Connection.samsung,
            title: 'Samsung Health',
            customerId: widget.customerId,
            onTap: [
              controller.initializeConnecton,
              controller.deAuthUserConnectionFromTryTerra
            ],
            controller: controller,
          ));
        }

        list.add(Container(
          height: 70,
          width: double.infinity,
          margin: const EdgeInsets.symmetric(horizontal: 15),
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(
                width: 10,
              ),
              const SizedBox(
                width: 150,
                child: Text(
                  'Other Devices',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                      fontSize: 18),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Spacer(),
              ElevatedButton(
                  onPressed: () async {
                    controller.getWidgetUrl(widget.customerId,
                        connectionsList: []).then((resp) {
                      if (resp == null) return;

                      String webUrl = resp['url'] ?? '';
                      if (webUrl.trim().isEmpty) return;
                      _launchUrl(webUrl);

                      return;
                    });
                  },
                  child: const Text('Connect')),
            ],
          ),
        ));
        list.add(
          SizedBox(
            width: 200,
            child: Text(
              kIsWeb
                  ? ''
                  : ' ${Platform.isIOS ? 'Apple Health' : ''} ${Platform.isAndroid ? 'Samsung health' : ''} might not work properly, if connected from web browser',
              style: const TextStyle(color: Colors.white),
              textAlign: TextAlign.center,
            ),
          ),
        );

        return Scaffold(
          // floatingActionButton: FloatingActionButton(onPressed: () async {
          //   controller.makeConnection(widget.customerId);
          // }),
          backgroundColor: Colors.transparent,
          appBar: const CustomAppBar(title: 'My Device'),
          body: SafeArea(
              child: controller.isLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 25),
                          child: Text(
                            'Ensure you have applications installed and setup!',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 32,
                        ),
                        AnimatedContainer(
                            duration: const Duration(milliseconds: 500),
                            margin: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 16),
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            decoration: const BoxDecoration(
                              color: Color.fromRGBO(95, 87, 113, 0.5),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                            ),
                            child: ListView.separated(
                                shrinkWrap: true,
                                itemBuilder: (context, index) => list[index],
                                separatorBuilder: (context, index) =>
                                    const Divider(
                                      color: Color(0xFF404044),
                                    ),
                                itemCount: list.length)),
                        // const Expanded(child: iOSScanView())

                        const SizedBox(
                          height: 10,
                        ),

                        FutureBuilder(
                          future: controller.getListOfUsersFromtryTerra(),
                          builder: (context, snapshot) {
                            return Text(
                              'Total Connections on ${F.name} : ${snapshot.data?.length}',
                              style: TextStyles.defaultText,
                            );
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),

                        ElevatedButton(
                            onPressed: () async {
                              try {
                                // await Sentry.captureMessage("This is a test message from Flutter");

                                // throw Exception('UnCaught ERrror');
                                // FirebaseCrashlytics.instance.crash();
                                Get.to(const TryTerraAppLogs());
                              } catch (e) {
                                // await Sentry.captureException(
                                //   e,
                                //   stackTrace: s,
                                // );
                              }
                            },
                            child: const Text('Error Logs')),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    )),
        );
      }),
    );
  }
}
