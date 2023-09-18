class BookModel {
  String? id;
  String? title;
  String? url;
  String? description;
  String? author;
  String? company;
  String? type;
  String? language;
  String? fileType;
  String? viTri;
  List<String>? tag;

  BookModel(
      {
        this.id,
        this.title,
        this.url,
        this.description,
        this.author,
        this.company,
        this.type,
        this.language,
        this.fileType,
        this.viTri,
        this.tag});

  BookModel copyWith({
    String? id,
    String? title,
    String? url,
    String? description,
    String? author,
    String? company,
    String? type,
    String? language,
    String? fileType,
    String? viTri,
    List<String>? tag,
  }){
    return BookModel(
      id: id ?? this.id,
      title: title ?? this.title,
      url: url ?? this.url,
      description: description ?? this.description,
      author: author ?? this.author,
      company: company ?? this.company,
      type: type ?? this.type,
      language: language ?? this.language,
      fileType: fileType ?? this.fileType,
      viTri: viTri ?? this.viTri,
      tag: tag ?? this.tag
    );
}

  BookModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    url = json['url'];
    description = json['description'];
    author = json['author'];
    company = json['company'];
    type = json['type'];
    language = json['language'];
    fileType = json['fileType'];
    viTri = json['viTri'];
    tag = json['tag'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['url'] = url;
    data['description'] = description;
    data['author'] = author;
    data['company'] = company;
    data['type'] = type;
    data['language'] = language;
    data['fileType'] = fileType;
    data['viTri'] = viTri;
    data['tag'] = tag;
    return data;
  }
}