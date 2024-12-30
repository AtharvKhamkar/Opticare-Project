import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

///Widget to handle webview
Future<String?> openWebview(BuildContext context, String url,
    {String? redirectUrl, bool showNavButtons = true}) async {
  var link = url;
  if (!url.contains('https://') && !url.contains('http://')) {
    link = 'https://$url';
  }
  return await showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.white,
    builder: (context) => Container(
      padding: EdgeInsets.only(
          top: View.of(context).viewPadding.top /
              View.of(context).devicePixelRatio),
      color: Colors.grey[200],
      child: WebviewScreen(
        url: link,
        redirectUrl: redirectUrl,
        showNavButtons: showNavButtons,
      ),
    ),
  );
}

///Customized WebViewScreen
class WebviewScreen extends StatefulWidget {
  ///Constructor
  const WebviewScreen({
    super.key,
    required this.url,
    required this.redirectUrl,
    required this.showNavButtons,
  });

  ///url
  final String url;

  ///redirection url
  final String? redirectUrl;

  ///navigation buttons
  final bool showNavButtons;

  @override
  State<WebviewScreen> createState() => _WebviewScreenState();
}

class _WebviewScreenState extends State<WebviewScreen>
    with TickerProviderStateMixin {
  late final WebViewController webController;
  StreamController<double> progressStream = StreamController<double>();
  StreamController<List> webviewUIStream = StreamController<List>.broadcast();
  final Set<Factory<OneSequenceGestureRecognizer>> gestureRecognizers = {
    const Factory(EagerGestureRecognizer.new)
  };

  final key = UniqueKey();

  @override
  void dispose() {
    progressStream.close();
    webviewUIStream.close();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    final cookieManager = WebViewCookieManager();
    cookieManager.clearCookies();
    webController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(NavigationDelegate(
        onNavigationRequest: (request) {
          if (widget.redirectUrl != null &&
              request.url.startsWith(widget.redirectUrl!)) {
            Navigator.of(context).pop(request.url);
            return NavigationDecision.prevent;
          } else {
            return NavigationDecision.navigate;
          }
        },
        onProgress: (progress) {
          progressStream.add(progress == 100 ? 0.0 : progress / 100);
        },
        onPageStarted: (url) async {
          webviewUIStream.add([
            Uri.parse(url),
            await webController.canGoBack(),
            await webController.canGoForward(),
          ]);
        },
      ))
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          StreamBuilder<List>(
            stream: webviewUIStream.stream,
            initialData: const [null, false, false],
            builder: (context, snapshot) {
              return Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(
                      Icons.close_rounded,
                    ),
                  ),
                  const Spacer(),
                  // if (snapshot.data![0] != null) ...[
                  //   Row(
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     children: [
                  //       if ((snapshot.data![0] as Uri).scheme == 'https') ...[
                  //         const Icon(
                  //           Icons.lock,
                  //           size: 16,
                  //         ),
                  //         const SizedBox(
                  //           width: 4,
                  //         )
                  //       ],
                  //       Text(
                  //         (snapshot.data![0] as Uri).host,
                  //         maxLines: 1,
                  //         textAlign: TextAlign.center,
                  //         overflow: TextOverflow.ellipsis,
                  //         style: const TextStyle(
                  //           fontSize: 12,
                  //           fontWeight: FontWeight.w500,
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ],
                  // const Spacer(),
                  // IconButton(
                  //   onPressed: () {
                  //     webController.reload();
                  //   },
                  //   icon: const Icon(
                  //     Icons.refresh_rounded,
                  //   ),
                  // ),
                ],
              );
            },
          ),
          StreamBuilder<double>(
            stream: progressStream.stream,
            initialData: 0.0,
            builder: (context, progress) => TweenAnimationBuilder<double>(
              duration: const Duration(milliseconds: 250),
              tween: Tween<double>(begin: 0.0, end: progress.data),
              builder: (context, value, _) => AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                height: progress.data == 0.0 ? 0 : 4,
                child: LinearProgressIndicator(
                  color: progress.data == 0.0 ? Colors.grey[200] : Colors.blue,
                  backgroundColor: Colors.white,
                  value: value,
                ),
              ),
            ),
          ),
          Expanded(
            child: WebViewWidget(
              key: key,
              controller: webController,
              gestureRecognizers: gestureRecognizers,
            ),
          ),
          if (widget.showNavButtons)
            StreamBuilder<List>(
              stream: webviewUIStream.stream,
              initialData: const [null, false, false],
              builder: (context, snapshot) {
                return Row(
                  children: [
                    IconButton(
                      onPressed: () async {
                        if (await webController.canGoBack()) {
                          webController.goBack();
                        }
                      },
                      icon: Icon(
                        Icons.arrow_back,
                        color: snapshot.data![1] ? null : Colors.grey,
                      ),
                    ),
                    IconButton(
                      onPressed: () async {
                        if (await webController.canGoForward()) {
                          webController.goForward();
                        }
                      },
                      icon: RotatedBox(
                        quarterTurns: 2,
                        child: Icon(
                          Icons.arrow_back,
                          color: snapshot.data![2] ? null : Colors.grey,
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
        ],
      ),
    );
  }
}
