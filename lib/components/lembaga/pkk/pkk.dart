import 'package:desa_gempol/utils/config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Pkk extends StatefulWidget {
  const Pkk({super.key});

  @override
  State<Pkk> createState() => _PkkState();
}

class _PkkState extends State<Pkk> {
  WebViewController? controller;
  bool isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      controller = WebViewController()
        ..setJavaScriptMode(JavaScriptMode.unrestricted)
        ..setNavigationDelegate(
          NavigationDelegate(
            onPageStarted: (_) {
              setState(() {
                isLoading = true;
              });
            },
            onPageFinished: (_) {
              setState(() {
                isLoading = false;
              });
            },
          ),
        )
        ..loadRequest(Uri.parse('https://apidesa.workest.web.id/pkk'));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Config.primaryColor,
      appBar: AppBar(
        title: Text(
          'PKK',
          style: GoogleFonts.roboto(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Config.cardColor,
      ),
      body: Stack(
        children: [
          Container(
            color: Colors.white,
          ),
          if (controller != null)
            WebViewWidget(
              controller: controller!,
            ),
          if (isLoading)
            Container(
              color: Colors.white,
              child: const Center(
                child: SpinKitThreeBounce(
                  color: Colors.blue,
                  size: 50,
                ),
              ),
            )
        ],
      ),
    );
  }
}
