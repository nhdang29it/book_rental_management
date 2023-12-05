class TaiLieuModel {
  final Meta? meta;
  final File? file;
  final String? id;
  final String? title;
  final String? description;
  final String? viTri;
  final String? language;


  TaiLieuModel({this.meta, this.file, this.id, this.title, this.description, this.viTri, this.language});

  TaiLieuModel copyWith({String? id, String? language, String? fileType, String? viTri, Meta? meta, File? file, String? description, String? title}) => TaiLieuModel(
      id: id ?? this.id,
      language: language ?? this.language,
      title: title ?? this.title,
      description: description ?? this.description,
      viTri: viTri ?? this.viTri,
      meta: meta ?? this.meta,
      file: file ?? this.file
  );

  factory TaiLieuModel.fromJson(Map<String, dynamic> json) {
    return TaiLieuModel(
        meta : json['meta'] != null ? Meta.fromJson(json['meta']) : null,
        file : json['file'] != null ? File.fromJson(json['file']) : null,
      id: json['id']
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (meta != null) {
      data['meta'] = meta!.toJson();
    }
    if (file != null) {
      data['file'] = file!.toJson();
    }
    return data;
  }
}

class Meta {
  final String? author;
  final String? date;
  final String? format;
  final String? creatorTool;
  final String? created;

  Meta({this.author, this.date, this.format, this.creatorTool, this.created});

  factory Meta.fromJson(Map<String, dynamic> json) {
    return Meta(
        author : json['author'],
        date : json['date'],
        format : json['format'],
    creatorTool : json['creator_tool'],
    created : json['created'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['author'] = author;
    data['date'] = date;
    data['format'] = format;
    data['creator_tool'] = creatorTool;
    data['created'] = created;
    return data;
  }
}

class File {
  final String? extension;
  final String? contentType;
  final String? created;
  final String? lastModified;
  final String? lastAccessed;
  final String? indexingDate;
  final int? filesize;
  final String? filename;
  final String? url;

  File(
      {this.extension,
        this.contentType,
        this.created,
        this.lastModified,
        this.lastAccessed,
        this.indexingDate,
        this.filesize,
        this.filename,
        this.url});

  factory File.fromJson(Map<String, dynamic> json) {
    return File(
        extension : json['extension'],
        contentType : json['content_type'],
        created : json['created'],
    lastModified : json['last_modified'],
    lastAccessed : json['last_accessed'],
    indexingDate : json['indexing_date'],
    filesize : json['filesize'],
    filename : json['filename'],
    url : json['url']
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['extension'] = extension;
    data['content_type'] = contentType;
    data['created'] = created;
    data['last_modified'] = lastModified;
    data['last_accessed'] = lastAccessed;
    data['indexing_date'] = indexingDate;
    data['filesize'] = filesize;
    data['filename'] = filename;
    data['url'] = url;
    return data;
  }
}
