/// Data models for handling the response from the NY Times Search Article
class SearchArticleResponseModel {
  String? status;
  String? copyright;
  SearchArticleResponse? response;

  SearchArticleResponseModel({this.status, this.copyright, this.response});

  SearchArticleResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    copyright = json['copyright'];
    response = json['response'] != null ? SearchArticleResponse.fromJson(json['response']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['copyright'] = copyright;
    if (response != null) {
      data['response'] = response!.toJson();
    }
    return data;
  }
}

class SearchArticleResponse {
  List<Docs>? docs;
  Meta? meta;

  SearchArticleResponse({this.docs, this.meta});

  SearchArticleResponse.fromJson(Map<String, dynamic> json) {
    if (json['docs'] != null) {
      docs = <Docs>[];
      json['docs'].forEach((v) {
        docs!.add(Docs.fromJson(v));
      });
    }
    meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (docs != null) {
      data['docs'] = docs!.map((v) => v.toJson()).toList();
    }
    if (meta != null) {
      data['meta'] = meta!.toJson();
    }
    return data;
  }
}

class Docs {
  String? abstract;
  String? webUrl;
  String? snippet;
  String? leadParagraph;
  String? printSection;
  String? printPage;
  String? source;
  List<Multimedia>? multimedia;
  Headline? headline;
  List<Keywords>? keywords;
  String? pubDate;
  String? documentType;
  String? newsDesk;
  String? sectionName;
  String? subsectionName;
  Byline? byline;
  String? typeOfMaterial;
  String? sId;
  int? wordCount;
  String? uri;

  Docs(
      {this.abstract,
      this.webUrl,
      this.snippet,
      this.leadParagraph,
      this.printSection,
      this.printPage,
      this.source,
      this.multimedia,
      this.headline,
      this.keywords,
      this.pubDate,
      this.documentType,
      this.newsDesk,
      this.sectionName,
      this.subsectionName,
      this.byline,
      this.typeOfMaterial,
      this.sId,
      this.wordCount,
      this.uri});

  Docs.fromJson(Map<String, dynamic> json) {
    abstract = json['abstract'];
    webUrl = json['web_url'];
    snippet = json['snippet'];
    leadParagraph = json['lead_paragraph'];
    printSection = json['print_section'];
    printPage = json['print_page'];
    source = json['source'];
    if (json['multimedia'] != null) {
      multimedia = <Multimedia>[];
      json['multimedia'].forEach((v) {
        multimedia!.add(Multimedia.fromJson(v));
      });
    }
    headline = json['headline'] != null ? Headline.fromJson(json['headline']) : null;
    if (json['keywords'] != null) {
      keywords = <Keywords>[];
      json['keywords'].forEach((v) {
        keywords!.add(Keywords.fromJson(v));
      });
    }
    pubDate = json['pub_date'];
    documentType = json['document_type'];
    newsDesk = json['news_desk'];
    sectionName = json['section_name'];
    subsectionName = json['subsection_name'];
    byline = json['byline'] != null ? Byline.fromJson(json['byline']) : null;
    typeOfMaterial = json['type_of_material'];
    sId = json['_id'];
    wordCount = json['word_count'];
    uri = json['uri'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['abstract'] = abstract;
    data['web_url'] = webUrl;
    data['snippet'] = snippet;
    data['lead_paragraph'] = leadParagraph;
    data['print_section'] = printSection;
    data['print_page'] = printPage;
    data['source'] = source;
    if (multimedia != null) {
      data['multimedia'] = multimedia!.map((v) => v.toJson()).toList();
    }
    if (headline != null) {
      data['headline'] = headline!.toJson();
    }
    if (keywords != null) {
      data['keywords'] = keywords!.map((v) => v.toJson()).toList();
    }
    data['pub_date'] = pubDate;
    data['document_type'] = documentType;
    data['news_desk'] = newsDesk;
    data['section_name'] = sectionName;
    data['subsection_name'] = subsectionName;
    if (byline != null) {
      data['byline'] = byline!.toJson();
    }
    data['type_of_material'] = typeOfMaterial;
    data['_id'] = sId;
    data['word_count'] = wordCount;
    data['uri'] = uri;
    return data;
  }
}

class Multimedia {
  int? rank;
  String? subtype;

  // Null? caption;
  // Null? credit;
  String? type;
  String? url;
  int? height;
  int? width;
  Legacy? legacy;
  String? subType;
  String? cropName;

  Multimedia(
      {this.rank,
      this.subtype,
      // this.caption,
      // this.credit,
      this.type,
      this.url,
      this.height,
      this.width,
      this.legacy,
      this.subType,
      this.cropName});

  Multimedia.fromJson(Map<String, dynamic> json) {
    rank = json['rank'];
    subtype = json['subtype'];
    // caption = json['caption'];
    // credit = json['credit'];
    type = json['type'];
    url = json['url'];
    height = json['height'];
    width = json['width'];
    legacy = json['legacy'] != null ? Legacy.fromJson(json['legacy']) : null;
    subType = json['subType'];
    cropName = json['crop_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['rank'] = rank;
    data['subtype'] = subtype;
    // data['caption'] = this.caption;
    // data['credit'] = this.credit;
    data['type'] = type;
    data['url'] = url;
    data['height'] = height;
    data['width'] = width;
    if (legacy != null) {
      data['legacy'] = legacy!.toJson();
    }
    data['subType'] = subType;
    data['crop_name'] = cropName;
    return data;
  }
}

class Legacy {
  String? xlarge;
  int? xlargewidth;
  int? xlargeheight;
  String? thumbnail;
  int? thumbnailwidth;
  int? thumbnailheight;
  int? widewidth;
  int? wideheight;
  String? wide;

  Legacy(
      {this.xlarge,
      this.xlargewidth,
      this.xlargeheight,
      this.thumbnail,
      this.thumbnailwidth,
      this.thumbnailheight,
      this.widewidth,
      this.wideheight,
      this.wide});

  Legacy.fromJson(Map<String, dynamic> json) {
    xlarge = json['xlarge'];
    xlargewidth = json['xlargewidth'];
    xlargeheight = json['xlargeheight'];
    thumbnail = json['thumbnail'];
    thumbnailwidth = json['thumbnailwidth'];
    thumbnailheight = json['thumbnailheight'];
    widewidth = json['widewidth'];
    wideheight = json['wideheight'];
    wide = json['wide'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['xlarge'] = xlarge;
    data['xlargewidth'] = xlargewidth;
    data['xlargeheight'] = xlargeheight;
    data['thumbnail'] = thumbnail;
    data['thumbnailwidth'] = thumbnailwidth;
    data['thumbnailheight'] = thumbnailheight;
    data['widewidth'] = widewidth;
    data['wideheight'] = wideheight;
    data['wide'] = wide;
    return data;
  }
}

class Headline {
  String? main;
  String? kicker;

  // Null? contentKicker;
  String? printHeadline;

  // Null? name;
  // Null? seo;
  // Null? sub;

  Headline({
    this.main,
    this.kicker,
    // this.contentKicker,
    this.printHeadline,
    // this.name,
    // this.seo,
    // this.sub,
  });

  Headline.fromJson(Map<String, dynamic> json) {
    main = json['main'];
    kicker = json['kicker'];
    // contentKicker = json['content_kicker'];
    printHeadline = json['print_headline'];
    // name = json['name'];
    // seo = json['seo'];
    // sub = json['sub'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['main'] = main;
    data['kicker'] = kicker;
    // data['content_kicker'] = this.contentKicker;
    data['print_headline'] = printHeadline;
    // data['name'] = this.name;
    // data['seo'] = this.seo;
    // data['sub'] = this.sub;
    return data;
  }
}

class Keywords {
  String? name;
  String? value;
  int? rank;
  String? major;

  Keywords({this.name, this.value, this.rank, this.major});

  Keywords.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    value = json['value'];
    rank = json['rank'];
    major = json['major'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['value'] = value;
    data['rank'] = rank;
    data['major'] = major;
    return data;
  }
}

class Byline {
  String? original;
  List<Person>? person;
  String? organization;

  Byline({this.original, this.person, this.organization});

  Byline.fromJson(Map<String, dynamic> json) {
    original = json['original'];
    if (json['person'] != null) {
      person = <Person>[];
      json['person'].forEach((v) {
        person!.add(Person.fromJson(v));
      });
    }
    organization = json['organization'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['original'] = original;
    if (person != null) {
      data['person'] = person!.map((v) => v.toJson()).toList();
    }
    data['organization'] = organization;
    return data;
  }
}

class Person {
  String? firstname;
  String? middlename;
  String? lastname;

  // Null? qualifier;
  // Null? title;
  String? role;
  String? organization;
  int? rank;

  Person({
    this.firstname,
    this.middlename,
    this.lastname,
    // this.qualifier,
    // this.title,
    this.role,
    this.organization,
    this.rank,
  });

  Person.fromJson(Map<String, dynamic> json) {
    firstname = json['firstname'];
    middlename = json['middlename'];
    lastname = json['lastname'];
    // qualifier = json['qualifier'];
    // title = json['title'];
    role = json['role'];
    organization = json['organization'];
    rank = json['rank'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['firstname'] = firstname;
    data['middlename'] = middlename;
    data['lastname'] = lastname;
    // data['qualifier'] = this.qualifier;
    // data['title'] = this.title;
    data['role'] = role;
    data['organization'] = organization;
    data['rank'] = rank;
    return data;
  }
}

class Meta {
  int? hits;
  int? offset;
  int? time;

  Meta({this.hits, this.offset, this.time});

  Meta.fromJson(Map<String, dynamic> json) {
    hits = json['hits'];
    offset = json['offset'];
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['hits'] = hits;
    data['offset'] = offset;
    data['time'] = time;
    return data;
  }
}
