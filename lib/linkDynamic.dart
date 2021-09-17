import 'dart:async';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

class MainScreen extends StatefulWidget {
  static const String ROUTE = "/LinkDynamic";
  @override
  State<StatefulWidget> createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen> {
  String? _linkMessage;
  bool _isCreatingLink = false;

  @override
  void initState() {
    super.initState();
    initDynamicLinks();
  }

  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Dynamic Links Example'),
        ),
        body: Builder(builder: (BuildContext context) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ButtonBar(
                  alignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ElevatedButton(
                      onPressed:
                          !_isCreatingLink ? () => _createDynamicLink() : null,
                      child: const Text('Get Short Link'),
                    ),
                  ],
                ),
                InkWell(
                  onTap: () async {
                    if (_linkMessage != null) {
                      await launch(_linkMessage!);
                    }
                  },
                  onLongPress: () {
                    Clipboard.setData(ClipboardData(text: _linkMessage));
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Copied Link!')),
                    );
                  },
                  child: Text(
                    _linkMessage ?? '',
                    style: const TextStyle(color: Colors.blue),
                  ),
                ),
                Text(_linkMessage == null ? '' : 'Erro')
              ],
            ),
          );
        }),
      ),
    );
  }

  Future<void> initDynamicLinks() async {
    FirebaseDynamicLinks.instance.onLink(
        onSuccess: (PendingDynamicLinkData? dynamicLink) async {
      final Uri? deepLink = dynamicLink?.link;

      if (deepLink != null) {
        // ignore: unawaited_futures
        Navigator.pushNamed(context, '/FrmLlenado');
      }
    }, onError: (OnLinkErrorException e) async {
      print('onLinkError');
      print(e.message);
    });

    /*final PendingDynamicLinkData? data =
        await FirebaseDynamicLinks.instance.getInitialLink();
    final Uri? deepLink = data?.link;

    if (deepLink != null) {
      // ignore: unawaited_futures
      Navigator.pushNamed(context, deepLink.path);
    }*/
  }

  Future<void> _createDynamicLink() async {
    setState(() {
      _isCreatingLink = true;
    });

    final DynamicLinkParameters parameters = DynamicLinkParameters(
      uriPrefix: 'https://encuestasprueba.page.link',
      link: Uri.parse('https://encuestasprueba.page.link/zXbp'),
      androidParameters: AndroidParameters(
        packageName: 'com.example.encuesta',
        minimumVersion: 0,
      ),
      dynamicLinkParametersOptions: DynamicLinkParametersOptions(
        shortDynamicLinkPathLength: ShortDynamicLinkPathLength.short,
      ),
      iosParameters: IosParameters(
        bundleId: 'com.example.encuesta',
        minimumVersion: '0',
      ),
    );

    //Uri url;
    final Uri dynamicUrl = await parameters.buildUrl();

    // final ShortDynamicLink shortLink = await parameters.buildShortLink();
    //url = shortLink.shortUrl;

    setState(() {
      _linkMessage = dynamicUrl.toString();
      _isCreatingLink = true;
      print(_linkMessage);
    });
  }
}
