import 'dart:convert';
import 'dart:ui';

import 'package:digital_card_app/controller/Controller.dart';
import 'package:digital_card_app/models/LinksModel.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

import 'components/ParseWidgetIcon.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // LinkModel links = LinkModel();
  // Future<List<LinkModel>> links;

  var linkes = new List<LinkModel>();

  _getLinkes() {
    Controller controller = Controller();
    controller.getLink2().then((value) {
      setState(() {
        linkes = value;
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getLinkes();
    // Controller controller = Controller();
    // links = controller.getLink2();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          Positioned(
            child: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      stops: [0.0, 2.0],
                      colors: [Color(0xFF16BFFD), Color(0xFFCA3167)])),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: SafeArea(
                child: Column(
                  children: [
                    Padding(
                        padding: EdgeInsets.only(right: 150, left: 150),
                        child: Column(
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.1,
                            ),
                            Container(
                              height: 120,
                              width: 120,
                              decoration: BoxDecoration(
                                image: DecorationImage(image: AssetImage('images/MZD3.png'), fit: BoxFit.contain, scale: 1),
                                borderRadius: BorderRadius.circular(200),
                              ),
                            ),
                          ],
                        ))
                  ],
                ),
              ),
            ),
          ),
          Positioned(
              child:
                  // FutureBuilder<List<LinkModel>>(
                  //   future: links,
                  //   builder: (context, snapshot) {
                  //     return Container(
                  //       margin: EdgeInsets.only(bottom: 24),
                  //       child: list(context, snapshot),
                  //     );
                  //   },
                  // ),
                  Padding(
            padding: EdgeInsets.only(right: 20, left: 20, bottom: 50),
            child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: 130,
                  child: ListCards(),
                )),
          ))
        ],
      ),
    );
  }

  Widget list(context, snapshot) {
    switch (snapshot.connectionState) {
      case ConnectionState.none:
      case ConnectionState.waiting:
        return Center(child: CircularProgressIndicator());
        break;
      case ConnectionState.active:
      case ConnectionState.done:
        print(snapshot);
        if (snapshot.data != null && !snapshot.data.isEmpty) {
          return ListView.separated(
              itemBuilder: (context, index) {
                List<LinkModel> links = snapshot.data;
                LinkModel linklist = links[index];
                return Card(
                  child: Padding(
                    padding: EdgeInsets.all(0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        ListTile(
                            title: Text(linklist.nome, style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
                            subtitle: Column(
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Text(linklist.content, style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
                                  ],
                                )
                              ],
                            )),
                      ],
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) => Container(height: 0, color: Colors.grey),
              itemCount: snapshot.data.length);
        } else {
          //necessario para o refres funcionar quando não retornar item de uma pesquisa
          return ListView(
              padding: EdgeInsets.fromLTRB(16, 200, 16, 50),
              children: <Widget>[Center(child: Text("Strings.nenhumaAlocacao", style: TextStyle(color: Colors.red)))]);
        }
        break;
    }
  }

  ListCards() {
    return ListView.builder(
      itemCount: linkes.length,
      itemBuilder: (context, index) {
        return Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: GestureDetector(
              onTap: () {
                _ModalBottomSheet(
                  context,
                  linkes[index].nome,
                  linkes[index].content,
                );
                // launchURL(linkes[index].nome, linkes[index].content);
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(10),
                ),
                height: 120.0,
                width: 120.0,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Center(
                        child: parseWidget(linkes[index].nome),
                      ),
                    ),
                    Text(
                      linkes[index].nome,
                      style: TextStyle(color: Colors.black, fontWeight: FontWeight.w300, fontSize: 20),
                    ),
                  ],
                ),
                alignment: Alignment.center,
              ),
            ));
      },
      scrollDirection: Axis.horizontal,
    );
  }

  launchURL(name, url) async {
    if (name == 'Contato') {
      var tel = 'tel:' + url;
      await launch(tel);
    } else if (name == 'Email') {
      final Uri _emailLaunchUri =
          Uri(scheme: 'mailto', path: url, queryParameters: {'subject': 'Example de email para o envio...'});
      await launch(_emailLaunchUri.toString());
    } else {
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }
  }

  void _ModalBottomSheet(context, name, content) {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        // isDismissible: true,
        // isScrollControlled: true,
        builder: (BuildContext bc) {
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
              color: Colors.white,
            ),
            padding: EdgeInsets.only(top: 0, left: 20, right: 20, bottom: 30),
            child: Column(
              children: [
                // ModalCloseBar(bottomPadding: 14),
                Padding(
                  padding: EdgeInsets.only(top: 30, bottom: 30),
                  child: Text(
                    name,
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                ),
                QrImage(
                  data: content,
                  version: QrVersions.auto,
                  size: 160.0,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20, bottom: 20),
                  child: Text(
                    'Ou acesse',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300, color: Colors.black),
                  ),
                ),
                FlatButton(
                  padding: EdgeInsets.symmetric(horizontal: 50),
                  onPressed: () {
                    shareOption(context, content);
                  },
                  child: Center(
                    child: Text(
                      content,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.w300, fontSize: 18),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                        ),
                      child: Center(
                        child: IconButton(
                          icon: Icon(Icons.share, size: 30, color: Colors.white),
                          onPressed: (){
                            shareOption(context, content);
                          },
                        ),
                      )
                    )
                  )
                )
              ],
            ),
          );
        });
  }
}

void shareOption(BuildContext context, content) {
  Share.share('Meu link de copartilhamento do meu DigitalCard $content, by MZDev');
}
