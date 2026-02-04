import "package:flutter/material.dart";
import "package:webview_flutter/webview_flutter.dart";

class WebViewScreen extends StatefulWidget {
  final String title;
  final String url;

  const WebViewScreen({super.key, required this.title, required this.url});

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();

}

class _WebViewScreenState extends State<WebViewScreen> {
  late final WebViewController _webviewController;

  @override
  void initState() {
    super.initState();
    _webviewController = _initWebViewController();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: WebViewWidget(controller: _webviewController),
    );
  }

  WebViewController _initWebViewController() {
    return WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
  }
}