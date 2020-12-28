import 'dart:convert';
import 'package:digital_card_app/models/LinksModel.dart';

class Controller {
  Future<LinkModel> getLink() async {
    LinkModel dadosJson = LinkModel.fromJson(jsonn);
    return dadosJson;
  }
  Future<List<LinkModel>> getLink2() async {
    List<LinkModel> dadosJson = jsonDecode(jsonEncode(json)).map<LinkModel>((map) {
      return LinkModel.fromJson(map);
    }).toList();
    return dadosJson;
  }

  var jsonn = {'id': '1', 'nome': 'instagram', 'content': 'https://www.instagram.com.br'};
  var json = [
    {'id': '1', 'nome': 'Instagram', 'content': 'https://www.instagram.com/marco_rozo/'},
    {'id': '2', 'nome': 'Facebook', 'content': 'https://www.facebook.com/marco.antoniorozo/'},
    {'id': '3', 'nome': 'GitHub', 'content': 'https://github.com/'},
    {'id': '4', 'nome': 'WhatsApp', 'content': 'http://wa.me/+5549991950620?text=Ol%C3%A1,%20Tenho%20interesse%20no%20%20anunciado'},
    {'id': '5', 'nome': 'Contato', 'content': '(49) 991950620'},
    {'id': '6', 'nome': 'Email', 'content': 'marcorozo99@gmail.com'},
    {'id': '7', 'nome': 'Google', 'content': 'https://www.google.com.br'},
    {'id': '8', 'nome': 'Portifólio', 'content': 'https://www.google.com'},
    {'id': '9', 'nome': 'Linkedin', 'content': 'https://www.linkedin.com'},
    {'id': '10', 'nome': 'Teste', 'content': 'https://www.linkedin.com'},

  ];
}
