import 'package:flutter/material.dart';
import 'package:vizzhy/src/services/vizzhy_firebase_service.dart';
import 'package:webview_flutter/webview_flutter.dart';

class VizhhyTerraConnectWebView extends StatefulWidget {
  final String url;
  final String validTill;

  const VizhhyTerraConnectWebView(
      {super.key, required this.url, required this.validTill});

  @override
  State<VizhhyTerraConnectWebView> createState() =>
      _VizhhyTerraConnectWebViewState();
}

class _VizhhyTerraConnectWebViewState extends State<VizhhyTerraConnectWebView> {
  late WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onHttpError: (HttpResponseError error) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            VizzhyFirebaseServices().logDataToFirestore(
                {"on navigation request , the url": request.url});
            debugPrint("this is our main url  :${widget.url}");
            final requestUrl = Uri.parse(request.url);
            final removedQueryUrl =
                requestUrl.replace(query: '').toString().replaceAll('?', '');
            debugPrint('removedQueryUrl : $removedQueryUrl');
            if (request.url.startsWith('${widget.url}/success')) {
              // success connection
              Uri uri = Uri.parse(request.url);

              // Extract the user_id and resource parameters
              String? userId = uri.queryParameters['reference_id'];
              String? resource = uri.queryParameters['resource'];

              if (userId != null && resource != null) {
                // Both parameters are non-null, indicating success
                Navigator.pop(context, [
                  {
                    'user_id': userId,
                    'resource': resource,
                    'isDisconnected': false,
                    'isConnected': true
                  },
                ]); // Close the WebView
                debugPrint("Success User ID: $userId, Resource: $resource");
                _showSuccessDialog();
              } else {
                // One or both parameters are null, indicating failure
                Navigator.pop(context); // Close the WebView
                debugPrint("Failure Operation failed, please try again.");
                _showFailureDialog();
              }

              return NavigationDecision.prevent;
            } else if (removedQueryUrl == widget.url) {
              // Disconnect
              Uri uri = Uri.parse(request.url);

              // Extract the user_id and resource parameters
              String? userId = uri.queryParameters['user_id'];
              String? resource = uri.queryParameters['resource'];

              if (userId != null && resource != null) {
                // Both parameters are non-null, indicating success
                Navigator.pop(context, [
                  {
                    'user_id': userId,
                    'resource': resource,
                    'isDisconnected': true,
                    'isConnected': false
                  },
                ]); // Close the WebView
                debugPrint("Success User ID: $userId, Resource: $resource");
                _showSuccessDialog(msg: 'Disconnected success');
              } else {
                // One or both parameters are null, indicating failure
                Navigator.pop(context, []); // Close the WebView
                debugPrint("Failure Operation failed, please try again.");
                _showFailureDialog(msg: 'Disconnection failed');
              }

              return NavigationDecision.prevent;
            } else if (request.url.startsWith('https://www.google.com/')) {
              // failed to connect
              Navigator.pop(context, [
                {
                  'user_id': '',
                  'resource': '',
                  'isDisconnected': false,
                  'isConnected': false
                },
              ]); // Close the WebView
              debugPrint("Failure Operation failed, please try again.");
              _showFailureDialog();
            } else {
              _controller.goBack();
              // we visited another website from our given site
              debugPrint("this is webview request  :${request.url}");
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black26,
        title: const Text('Connect Device'),
        actions: [Text('valid till : ${widget.validTill}  ')],
      ),
      body: WebViewWidget(controller: _controller),
    );
  }

  void _showSuccessDialog({String? msg}) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Success"),
        content: Text(msg ?? "Connection successful!"),
        actions: [
          TextButton(
            child: const Text("OK"),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  void _showFailureDialog({String? msg}) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Failure"),
        content: Text(msg ?? "Connection failed!"),
        actions: [
          TextButton(
            child: const Text("OK"),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }
}
