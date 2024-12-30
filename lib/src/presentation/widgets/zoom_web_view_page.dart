import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vizzhy/src/presentation/widgets/custom_app_bar.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'package:vizzhy/src/core/constants/constants.dart';

/// specially configure for zoom meet
class ZoomWebViewPage extends StatefulWidget {
  /// pass zoom meet web url
  final String meetingUrl;

  /// title of the zom meeting which will be shown on appbar
  final String meetTitle;

  /// contructor
  const ZoomWebViewPage(
      {super.key, required this.meetingUrl, required this.meetTitle});

  @override
  State<ZoomWebViewPage> createState() => _ZoomWebViewPageState();
}

class _ZoomWebViewPageState extends State<ZoomWebViewPage> {
  late WebViewController _controller;

  @override
  void initState() {
    super.initState();
    // dumpResponseToJson({"zoom url recieved ": widget.meetingUrl});
    // _urls.add(widget.meetingUrl);
    // Initialize the WebViewController with the passed URL
    _controller = WebViewController(
        onPermissionRequest: (WebViewPermissionRequest req) => req.grant())
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onUrlChange: (UrlChange onUrlChange) {
            debugPrint("Url changed to : ${onUrlChange.url}");
            // _urls.add(widget.meetingUrl);
            // dumpResponseToJson({"zoom url changed ": onUrlChange.url});

            if (onUrlChange.url?.startsWith('https://zoom.us/wc/leave') ??
                false) {
              Get.back();
            }
          },
          onProgress: (int progress) {
            // Optionally handle progress events here
          },
          onPageStarted: (String url) {
            debugPrint('Page started loading: $url');
          },
          onPageFinished: (String url) {
            debugPrint('Page finished loading: $url');
          },
          onWebResourceError: (WebResourceError error) {
            debugPrint('Web resource error: ${error.description}');
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.meetingUrl));

    // openZoomMeeting(widget.meetingUrl);
  }

  // void openZoomMeeting(String zoomLink) async {
  //   // Check if Zoom app can be launched
  //   if (await canLaunchUrl(Uri.parse(zoomLink))) {
  //     await launchUrl(Uri.parse(zoomLink), mode: LaunchMode.inAppWebView);
  //   } else {
  //     // If Zoom app is not installed, open Play Store
  //     const zoomPlayStoreUrl =
  //         'https://play.google.com/store/apps/details?id=us.zoom.videomeetings';
  //     if (await canLaunchUrl(Uri.parse(zoomLink))) {
  //       await launchUrl(Uri.parse(zoomLink));
  //     } else {
  //       // If Play Store cannot be opened (rare case)
  //       debugPrint('Could not launch $zoomPlayStoreUrl');
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(gradient: AppGradient.mainBackground),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: CustomAppBar(title: widget.meetTitle),
        // bottomNavigationBar: SizedBox(
        //   height: 40,
        //   width: double.infinity,
        // ),
        body: WebViewWidget(controller: _controller),
      ),
    );
  }
}

// class ZoomUrlListPage extends StatefulWidget {
//   final List<String> meetingUrls;
//   const ZoomUrlListPage({super.key, required this.meetingUrls});

//   @override
//   State<ZoomUrlListPage> createState() => _ZoomUrlListPageState();
// }

// class _ZoomUrlListPageState extends State<ZoomUrlListPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: ListView.builder(
//         itemCount: widget.meetingUrls.length,
//         itemBuilder: (context, index) {
//           return ListTile(
//               title: SelectableText(
//                 widget.meetingUrls[index],
//                 style: const TextStyle(fontSize: 16),
//               ),
//               onTap: () {});
//         },
//       ),
//     );
//   }
// }
