class LinkModel {
  dynamic id;
  dynamic nome;
  dynamic content;
  dynamic icon;

  LinkModel({this.id, this.nome, this.content, this.icon});

  factory LinkModel.fromJson(Map<String, dynamic> json) {
    return LinkModel(id: json["id"], nome: json["nome"], content: json["content"], icon: json["icon"],);
  }

  Map<String, dynamic> toJson() => {'id': id, 'nome': nome, 'content': content, 'icon': icon };
}
