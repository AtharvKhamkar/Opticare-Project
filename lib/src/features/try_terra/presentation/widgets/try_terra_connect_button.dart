import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:terra_flutter_bridge/models/enums.dart';

import '../../../../data/models/cached_error_model.dart';
import '../../../../services/vizzhy_firebase_service.dart';

class TryTerraConnectButton extends StatefulWidget {
  final String image;
  final Connection connection;
  final String title;
  final List<Function> onTap;
  final String customerId;
  final bool connected;
  final GetxController? controller;
  final bool? isSvg;

  const TryTerraConnectButton(
      {super.key,
      required this.onTap,
      required this.image,
      required this.connection,
      required this.title,
      required this.customerId,
      required this.connected,
      this.controller,
      this.isSvg = false});

  @override
  State<TryTerraConnectButton> createState() => _TryTerraConnectButtonState();
}

class _TryTerraConnectButtonState extends State<TryTerraConnectButton> {
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 15),
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          if (widget.isSvg!)
            SvgPicture.asset(
              widget.image,
              fit: BoxFit.fitWidth,
              width: 40,
              placeholderBuilder: (BuildContext context) => const SizedBox(
                width: 40,
                height: 40,
                child: Icon(Icons.error,
                    color: Colors.red), // Display an error icon
              ),
            ),
          if (!widget.isSvg!)
            Image.asset(
              widget.image,
              fit: BoxFit.fitWidth,
              width: 40,
            ),
          const SizedBox(
            width: 10,
          ),
          Text(
            widget.title,
            style: const TextStyle(
                fontWeight: FontWeight.w600, color: Colors.white, fontSize: 18),
          ),
          const Spacer(),
          SizedBox(
            width: 50,
            child: _loading
                ? const CupertinoActivityIndicator(
                    color: Colors.white,
                    radius: 10,
                  )
                : CupertinoSwitch(
                    value: widget.connected,
                    activeColor: const Color(0xFF30D158),
                    onChanged: (val) async {
                      if (_loading) {
                        return;
                      }
                      try {
                        setState(() {
                          _loading = true;
                        });

                        if (val) {
                          if (widget.onTap.isEmpty) return;
                          await widget.onTap.first(
                              context, widget.connection, widget.customerId);
                        } else {
                          if (widget.onTap.length < 2) return;

                          debugPrint(
                              'change to false, controler : ${widget.controller}');

                          debugPrint("calling teracontroller deauth function");
                          await widget.onTap[1](
                              connection: widget.connection,
                              customerId: widget.customerId);

                          Get.until((route) =>route.settings.name== '/profile');
                        }
                        // widget.controller?.update();

                        setState(() {
                          _loading = false;
                        });
                      } catch (e, s) {
                        VizzhyFirebaseServices().logErrorToFirestore(
                            CachedErrorModel(
                                errorMessage: e.toString(),
                                errorStack: '$s',
                                timestamp: DateTime.now()));
                      }
                    }),
          ),

          // ElevatedButton(
          //     style: ElevatedButton.styleFrom(
          //         fixedSize: const Size(150, 40),
          //         backgroundColor:
          //             widget.connected ? Colors.lightGreen : Colors.blueAccent,
          //         padding:
          //             const EdgeInsets.symmetric(horizontal: 20, vertical: 10)),
          //     onPressed: () async {
          //       if (widget.connected) {
          //         return;
          //       }
          //       setState(() {
          //         _loading = true;
          //       });
          //       await widget.onTap(
          //           context, widget.connection, widget.customerId);
          //       setState(() {
          //         _loading = false;
          //       });
          //     },
          // child: _loading
          //     ? const SizedBox(
          //         height: 20,
          //         width: 20,
          //         child: Center(
          //           child: CircularProgressIndicator(
          //             color: Colors.white,
          //           ),
          //         ),
          //       )
          //     : Center(
          //         child: Text(
          //           widget.connected ? 'Connected' : 'Connect',
          //           style: const TextStyle(
          //               color: Colors.white,
          //               fontWeight: FontWeight.bold,
          //               fontSize: 16),
          //         ),
          //       ))
        ],
      ),
    );
  }
}
