import 'package:get/get.dart';

class SearchArticleResponseModel {
  SearchArticleResponseModel({
    String? status,
    String? copyright,
    ResponseModel? response,
  }) {
    _status = status;
    _copyright = copyright;
    _response = response;
  }

  SearchArticleResponseModel.fromJson(dynamic json) {
    _status = json['status'];
    _copyright = json['copyright'];
    _response = json['response'] != null ? ResponseModel.fromJson(json['response']) : null;
  }

  String? _status;
  String? _copyright;
  ResponseModel? _response;

  SearchArticleResponseModel copyWith({
    String? status,
    String? copyright,
    ResponseModel? response,
  }) =>
      SearchArticleResponseModel(
        status: status ?? _status,
        copyright: copyright ?? _copyright,
        response: response ?? _response,
      );

  String? get status => _status;

  String? get copyright => _copyright;

  ResponseModel? get response => _response;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['copyright'] = _copyright;
    if (_response != null) {
      map['response'] = _response?.toJson();
    }
    return map;
  }
}

class ResponseModel {
  ResponseModel({
    RxList<Docs>? docs,
    Meta? meta,
  }) {
    _docs = docs;
    _meta = meta;
  }

  ResponseModel.fromJson(dynamic json) {
    if (json['docs'] != null) {
      _docs = <Docs>[].obs;
      json['docs'].forEach((v) {
        _docs?.add(Docs.fromJson(v));
      });
    }
    _meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
  }

  RxList<Docs>? _docs;
  Meta? _meta;

  ResponseModel copyWith({
    RxList<Docs>? docs,
    Meta? meta,
  }) =>
      ResponseModel(
        docs: docs ?? _docs,
        meta: meta ?? _meta,
      );

  RxList<Docs>? get docs => _docs;

  Meta? get meta => _meta;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_docs != null) {
      map['docs'] = _docs?.map((v) => v.toJson()).toList();
    }
    if (_meta != null) {
      map['meta'] = _meta?.toJson();
    }
    return map;
  }
}

/// hits : 929368
/// offset : 0
/// time : 158

class Meta {
  Meta({
    num? hits,
    num? offset,
    num? time,
  }) {
    _hits = hits;
    _offset = offset;
    _time = time;
  }

  Meta.fromJson(dynamic json) {
    _hits = json['hits'];
    _offset = json['offset'];
    _time = json['time'];
  }

  num? _hits;
  num? _offset;
  num? _time;

  Meta copyWith({
    num? hits,
    num? offset,
    num? time,
  }) =>
      Meta(
        hits: hits ?? _hits,
        offset: offset ?? _offset,
        time: time ?? _time,
      );

  num? get hits => _hits;

  num? get offset => _offset;

  num? get time => _time;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['hits'] = _hits;
    map['offset'] = _offset;
    map['time'] = _time;
    return map;
  }
}

class Docs {
  Docs({
    String? abstract,
    String? webUrl,
    String? snippet,
    String? leadParagraph,
    String? printSection,
    String? printPage,
    String? source,
    List<Multimedia>? multimedia,
    Headline? headline,
    List<Keywords>? keywords,
    String? pubDate,
    String? documentType,
    String? newsDesk,
    String? sectionName,
    Byline? byline,
    String? typeOfMaterial,
    String? id,
    num? wordCount,
    String? uri,
  }) {
    _abstract = abstract;
    _webUrl = webUrl;
    _snippet = snippet;
    _leadParagraph = leadParagraph;
    _printSection = printSection;
    _printPage = printPage;
    _source = source;
    _multimedia = multimedia;
    _headline = headline;
    _keywords = keywords;
    _pubDate = pubDate;
    _documentType = documentType;
    _newsDesk = newsDesk;
    _sectionName = sectionName;
    _byline = byline;
    _typeOfMaterial = typeOfMaterial;
    _id = id;
    _wordCount = wordCount;
    _uri = uri;
  }

  Docs.fromJson(dynamic json) {
    _abstract = json['abstract'];
    _webUrl = json['web_url'];
    _snippet = json['snippet'];
    _leadParagraph = json['lead_paragraph'];
    _printSection = json['print_section'];
    _printPage = json['print_page'];
    _source = json['source'];
    if (json['multimedia'] != null) {
      _multimedia = [];
      json['multimedia'].forEach((v) {
        _multimedia?.add(Multimedia.fromJson(v));
      });
    }
    _headline = json['headline'] != null ? Headline.fromJson(json['headline']) : null;
    if (json['keywords'] != null) {
      _keywords = [];
      json['keywords'].forEach((v) {
        _keywords?.add(Keywords.fromJson(v));
      });
    }
    _pubDate = json['pub_date'];
    _documentType = json['document_type'];
    _newsDesk = json['news_desk'];
    _sectionName = json['section_name'];
    _byline = json['byline'] != null ? Byline.fromJson(json['byline']) : null;
    _typeOfMaterial = json['type_of_material'];
    _id = json['_id'];
    _wordCount = json['word_count'];
    _uri = json['uri'];
  }

  String? _abstract;
  String? _webUrl;
  String? _snippet;
  String? _leadParagraph;
  String? _printSection;
  String? _printPage;
  String? _source;
  List<Multimedia>? _multimedia;
  Headline? _headline;
  List<Keywords>? _keywords;
  String? _pubDate;
  String? _documentType;
  String? _newsDesk;
  String? _sectionName;
  Byline? _byline;
  String? _typeOfMaterial;
  String? _id;
  num? _wordCount;
  String? _uri;

  Docs copyWith({
    String? abstract,
    String? webUrl,
    String? snippet,
    String? leadParagraph,
    String? printSection,
    String? printPage,
    String? source,
    List<Multimedia>? multimedia,
    Headline? headline,
    List<Keywords>? keywords,
    String? pubDate,
    String? documentType,
    String? newsDesk,
    String? sectionName,
    Byline? byline,
    String? typeOfMaterial,
    String? id,
    num? wordCount,
    String? uri,
  }) =>
      Docs(
        abstract: abstract ?? _abstract,
        webUrl: webUrl ?? _webUrl,
        snippet: snippet ?? _snippet,
        leadParagraph: leadParagraph ?? _leadParagraph,
        printSection: printSection ?? _printSection,
        printPage: printPage ?? _printPage,
        source: source ?? _source,
        multimedia: multimedia ?? _multimedia,
        headline: headline ?? _headline,
        keywords: keywords ?? _keywords,
        pubDate: pubDate ?? _pubDate,
        documentType: documentType ?? _documentType,
        newsDesk: newsDesk ?? _newsDesk,
        sectionName: sectionName ?? _sectionName,
        byline: byline ?? _byline,
        typeOfMaterial: typeOfMaterial ?? _typeOfMaterial,
        id: id ?? _id,
        wordCount: wordCount ?? _wordCount,
        uri: uri ?? _uri,
      );

  String? get abstract => _abstract;

  String? get webUrl => _webUrl;

  String? get snippet => _snippet;

  String? get leadParagraph => _leadParagraph;

  String? get printSection => _printSection;

  String? get printPage => _printPage;

  String? get source => _source;

  List<Multimedia>? get multimedia => _multimedia;

  Headline? get headline => _headline;

  List<Keywords>? get keywords => _keywords;

  String? get pubDate => _pubDate;

  String? get documentType => _documentType;

  String? get newsDesk => _newsDesk;

  String? get sectionName => _sectionName;

  Byline? get byline => _byline;

  String? get typeOfMaterial => _typeOfMaterial;

  String? get id => _id;

  num? get wordCount => _wordCount;

  String? get uri => _uri;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['abstract'] = _abstract;
    map['web_url'] = _webUrl;
    map['snippet'] = _snippet;
    map['lead_paragraph'] = _leadParagraph;
    map['print_section'] = _printSection;
    map['print_page'] = _printPage;
    map['source'] = _source;
    if (_multimedia != null) {
      map['multimedia'] = _multimedia?.map((v) => v.toJson()).toList();
    }
    if (_headline != null) {
      map['headline'] = _headline?.toJson();
    }
    if (_keywords != null) {
      map['keywords'] = _keywords?.map((v) => v.toJson()).toList();
    }
    map['pub_date'] = _pubDate;
    map['document_type'] = _documentType;
    map['news_desk'] = _newsDesk;
    map['section_name'] = _sectionName;
    if (_byline != null) {
      map['byline'] = _byline?.toJson();
    }
    map['type_of_material'] = _typeOfMaterial;
    map['_id'] = _id;
    map['word_count'] = _wordCount;
    map['uri'] = _uri;
    return map;
  }
}

/// original : "By Jesse Wegman"
/// person : [{"firstname":"Jesse","middlename":null,"lastname":"Wegman","qualifier":null,"title":null,"role":"reported","organization":"","rank":1}]
/// organization : null

class Byline {
  Byline({
    String? original,
    List<Person>? person,
    dynamic organization,
  }) {
    _original = original;
    _person = person;
    _organization = organization;
  }

  Byline.fromJson(dynamic json) {
    _original = json['original'];
    if (json['person'] != null) {
      _person = [];
      json['person'].forEach((v) {
        _person?.add(Person.fromJson(v));
      });
    }
    _organization = json['organization'];
  }

  String? _original;
  List<Person>? _person;
  dynamic _organization;

  Byline copyWith({
    String? original,
    List<Person>? person,
    dynamic organization,
  }) =>
      Byline(
        original: original ?? _original,
        person: person ?? _person,
        organization: organization ?? _organization,
      );

  String? get original => _original;

  List<Person>? get person => _person;

  dynamic get organization => _organization;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['original'] = _original;
    if (_person != null) {
      map['person'] = _person?.map((v) => v.toJson()).toList();
    }
    map['organization'] = _organization;
    return map;
  }
}

/// firstname : "Jesse"
/// middlename : null
/// lastname : "Wegman"
/// qualifier : null
/// title : null
/// role : "reported"
/// organization : ""
/// rank : 1

class Person {
  Person({
    String? firstname,
    dynamic middlename,
    String? lastname,
    dynamic qualifier,
    dynamic title,
    String? role,
    String? organization,
    num? rank,
  }) {
    _firstname = firstname;
    _middlename = middlename;
    _lastname = lastname;
    _qualifier = qualifier;
    _title = title;
    _role = role;
    _organization = organization;
    _rank = rank;
  }

  Person.fromJson(dynamic json) {
    _firstname = json['firstname'];
    _middlename = json['middlename'];
    _lastname = json['lastname'];
    _qualifier = json['qualifier'];
    _title = json['title'];
    _role = json['role'];
    _organization = json['organization'];
    _rank = json['rank'];
  }

  String? _firstname;
  dynamic _middlename;
  String? _lastname;
  dynamic _qualifier;
  dynamic _title;
  String? _role;
  String? _organization;
  num? _rank;

  Person copyWith({
    String? firstname,
    dynamic middlename,
    String? lastname,
    dynamic qualifier,
    dynamic title,
    String? role,
    String? organization,
    num? rank,
  }) =>
      Person(
        firstname: firstname ?? _firstname,
        middlename: middlename ?? _middlename,
        lastname: lastname ?? _lastname,
        qualifier: qualifier ?? _qualifier,
        title: title ?? _title,
        role: role ?? _role,
        organization: organization ?? _organization,
        rank: rank ?? _rank,
      );

  String? get firstname => _firstname;

  dynamic get middlename => _middlename;

  String? get lastname => _lastname;

  dynamic get qualifier => _qualifier;

  dynamic get title => _title;

  String? get role => _role;

  String? get organization => _organization;

  num? get rank => _rank;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['firstname'] = _firstname;
    map['middlename'] = _middlename;
    map['lastname'] = _lastname;
    map['qualifier'] = _qualifier;
    map['title'] = _title;
    map['role'] = _role;
    map['organization'] = _organization;
    map['rank'] = _rank;
    return map;
  }
}

/// name : "subject"
/// value : "Presidential Election of 2024"
/// rank : 1
/// major : "N"

class Keywords {
  Keywords({
    String? name,
    String? value,
    num? rank,
    String? major,
  }) {
    _name = name;
    _value = value;
    _rank = rank;
    _major = major;
  }

  Keywords.fromJson(dynamic json) {
    _name = json['name'];
    _value = json['value'];
    _rank = json['rank'];
    _major = json['major'];
  }

  String? _name;
  String? _value;
  num? _rank;
  String? _major;

  Keywords copyWith({
    String? name,
    String? value,
    num? rank,
    String? major,
  }) =>
      Keywords(
        name: name ?? _name,
        value: value ?? _value,
        rank: rank ?? _rank,
        major: major ?? _major,
      );

  String? get name => _name;

  String? get value => _value;

  num? get rank => _rank;

  String? get major => _major;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = _name;
    map['value'] = _value;
    map['rank'] = _rank;
    map['major'] = _major;
    return map;
  }
}

/// main : "Republicans Are No Longer Calling This Election Program a ‘Godsend’"
/// kicker : "Jesse Wegman"
/// content_kicker : null
/// print_headline : "Do Republican States Really Care About Election Integrity?"
/// name : null
/// seo : null
/// sub : null

class Headline {
  Headline({
    String? main,
    String? kicker,
    dynamic contentKicker,
    String? printHeadline,
    dynamic name,
    dynamic seo,
    dynamic sub,
  }) {
    _main = main;
    _kicker = kicker;
    _contentKicker = contentKicker;
    _printHeadline = printHeadline;
    _name = name;
    _seo = seo;
    _sub = sub;
  }

  Headline.fromJson(dynamic json) {
    _main = json['main'];
    _kicker = json['kicker'];
    _contentKicker = json['content_kicker'];
    _printHeadline = json['print_headline'];
    _name = json['name'];
    _seo = json['seo'];
    _sub = json['sub'];
  }

  String? _main;
  String? _kicker;
  dynamic _contentKicker;
  String? _printHeadline;
  dynamic _name;
  dynamic _seo;
  dynamic _sub;

  Headline copyWith({
    String? main,
    String? kicker,
    dynamic contentKicker,
    String? printHeadline,
    dynamic name,
    dynamic seo,
    dynamic sub,
  }) =>
      Headline(
        main: main ?? _main,
        kicker: kicker ?? _kicker,
        contentKicker: contentKicker ?? _contentKicker,
        printHeadline: printHeadline ?? _printHeadline,
        name: name ?? _name,
        seo: seo ?? _seo,
        sub: sub ?? _sub,
      );

  String? get main => _main;

  String? get kicker => _kicker;

  dynamic get contentKicker => _contentKicker;

  String? get printHeadline => _printHeadline;

  dynamic get name => _name;

  dynamic get seo => _seo;

  dynamic get sub => _sub;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['main'] = _main;
    map['kicker'] = _kicker;
    map['content_kicker'] = _contentKicker;
    map['print_headline'] = _printHeadline;
    map['name'] = _name;
    map['seo'] = _seo;
    map['sub'] = _sub;
    return map;
  }
}

/// rank : 0
/// subtype : "xlarge"
/// caption : null
/// credit : null
/// type : "image"
/// url : "images/2023/06/07/multimedia/05wegman1-qkth/05wegman1-qkth-articleLarge.jpg"
/// height : 400
/// width : 600
/// legacy : {"xlarge":"images/2023/06/07/multimedia/05wegman1-qkth/05wegman1-qkth-articleLarge.jpg","xlargewidth":600,"xlargeheight":400}
/// subType : "xlarge"
/// crop_name : "articleLarge"

class Multimedia {
  Multimedia({
    num? rank,
    String? subtype,
    dynamic caption,
    dynamic credit,
    String? type,
    String? url,
    num? height,
    num? width,
    Legacy? legacy,
    String? subType,
    String? cropName,
  }) {
    _rank = rank;
    _subtype = subtype;
    _caption = caption;
    _credit = credit;
    _type = type;
    _url = url;
    _height = height;
    _width = width;
    _legacy = legacy;
    _subType = subType;
    _cropName = cropName;
  }

  Multimedia.fromJson(dynamic json) {
    _rank = json['rank'];
    _subtype = json['subtype'];
    _caption = json['caption'];
    _credit = json['credit'];
    _type = json['type'];
    _url = json['url'];
    _height = json['height'];
    _width = json['width'];
    _legacy = json['legacy'] != null ? Legacy.fromJson(json['legacy']) : null;
    _subType = json['subType'];
    _cropName = json['crop_name'];
  }

  num? _rank;
  String? _subtype;
  dynamic _caption;
  dynamic _credit;
  String? _type;
  String? _url;
  num? _height;
  num? _width;
  Legacy? _legacy;
  String? _subType;
  String? _cropName;

  Multimedia copyWith({
    num? rank,
    String? subtype,
    dynamic caption,
    dynamic credit,
    String? type,
    String? url,
    num? height,
    num? width,
    Legacy? legacy,
    String? subType,
    String? cropName,
  }) =>
      Multimedia(
        rank: rank ?? _rank,
        subtype: subtype ?? _subtype,
        caption: caption ?? _caption,
        credit: credit ?? _credit,
        type: type ?? _type,
        url: url ?? _url,
        height: height ?? _height,
        width: width ?? _width,
        legacy: legacy ?? _legacy,
        subType: subType ?? _subType,
        cropName: cropName ?? _cropName,
      );

  num? get rank => _rank;

  String? get subtype => _subtype;

  dynamic get caption => _caption;

  dynamic get credit => _credit;

  String? get type => _type;

  String? get url => _url;

  num? get height => _height;

  num? get width => _width;

  Legacy? get legacy => _legacy;

  String? get subType => _subType;

  String? get cropName => _cropName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['rank'] = _rank;
    map['subtype'] = _subtype;
    map['caption'] = _caption;
    map['credit'] = _credit;
    map['type'] = _type;
    map['url'] = _url;
    map['height'] = _height;
    map['width'] = _width;
    if (_legacy != null) {
      map['legacy'] = _legacy?.toJson();
    }
    map['subType'] = _subType;
    map['crop_name'] = _cropName;
    return map;
  }
}

/// xlarge : "images/2023/06/07/multimedia/05wegman1-qkth/05wegman1-qkth-articleLarge.jpg"
/// xlargewidth : 600
/// xlargeheight : 400

class Legacy {
  Legacy({
    String? xlarge,
    num? xlargewidth,
    num? xlargeheight,
  }) {
    _xlarge = xlarge;
    _xlargewidth = xlargewidth;
    _xlargeheight = xlargeheight;
  }

  Legacy.fromJson(dynamic json) {
    _xlarge = json['xlarge'];
    _xlargewidth = json['xlargewidth'];
    _xlargeheight = json['xlargeheight'];
  }

  String? _xlarge;
  num? _xlargewidth;
  num? _xlargeheight;

  Legacy copyWith({
    String? xlarge,
    num? xlargewidth,
    num? xlargeheight,
  }) =>
      Legacy(
        xlarge: xlarge ?? _xlarge,
        xlargewidth: xlargewidth ?? _xlargewidth,
        xlargeheight: xlargeheight ?? _xlargeheight,
      );

  String? get xlarge => _xlarge;

  num? get xlargewidth => _xlargewidth;

  num? get xlargeheight => _xlargeheight;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['xlarge'] = _xlarge;
    map['xlargewidth'] = _xlargewidth;
    map['xlargeheight'] = _xlargeheight;
    return map;
  }
}
