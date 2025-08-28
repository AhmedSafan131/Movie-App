
 

class MoviesResponse {
  String? status;
  String? statusMessage;
  Data? data;
  Meta? meta;

  MoviesResponse({this.status, this.statusMessage, this.data, this.meta});

  MoviesResponse.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    statusMessage = json["status_message"];
    data = json["data"] == null ? null : Data.fromJson(json["data"]);
    meta = json["@meta"] == null ? null : Meta.fromJson(json["@meta"]);
  }

  static List<MoviesResponse> fromList(List<Map<String, dynamic>> list) {
    return list.map(MoviesResponse.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["status"] = status;
    _data["status_message"] = statusMessage;
    if(data != null) {
      _data["data"] = data?.toJson();
    }
    if(meta != null) {
      _data["@meta"] = meta?.toJson();
    }
    return _data;
  }
}

class Meta {
  int? serverTime;
  String? serverTimezone;
  int? apiVersion;
  String? executionTime;

  Meta({this.serverTime, this.serverTimezone, this.apiVersion, this.executionTime});

 Meta.fromJson(Map<String, dynamic> json) {
    serverTime = json["server_time"];
    serverTimezone = json["server_timezone"];
    apiVersion = json["api_version"];
    executionTime = json["execution_time"];
  }

  static List<Meta> fromList(List<Map<String, dynamic>> list) {
    return list.map(Meta.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["server_time"] = serverTime;
    _data["server_timezone"] = serverTimezone;
    _data["api_version"] = apiVersion;
    _data["execution_time"] = executionTime;
    return _data;
  }
}

class Data {
  int? movieCount;
  int? limit;
  int? pageNumber;
  List<Movies>? movies;

  Data({this.movieCount, this.limit, this.pageNumber, this.movies});

  Data.fromJson(Map<String, dynamic> json) {
    movieCount = json["movie_count"];
    limit = json["limit"];
    pageNumber = json["page_number"];
    movies = json["movies"] == null ? null : (json["movies"] as List).map((e) => Movies.fromJson(e)).toList();
  }

  static List<Data> fromList(List<Map<String, dynamic>> list) {
    return list.map(Data.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["movie_count"] = movieCount;
    _data["limit"] = limit;
    _data["page_number"] = pageNumber;
    if(movies != null) {
      _data["movies"] = movies?.map((e) => e.toJson()).toList();
    }
    return _data;
  }
}

class Movies {
  int? id;
  String? url;
  String? imdbCode;
  String? title;
  String? titleEnglish;
  String? titleLong;
  String? slug;
  int? year;
  double? rating; // <-- Fix: use double, not Double
  int? runtime;
  List<String>? genres;
  String? summary;
  String? descriptionFull;
  String? synopsis;
  String? ytTrailerCode;
  String? language;
  String? mpaRating;
  String? backgroundImage;
  String? backgroundImageOriginal;
  String? smallCoverImage;
  String? mediumCoverImage;
  String? largeCoverImage;
  String? state;
  List<Torrents>? torrents;
  String? dateUploaded;
  int? dateUploadedUnix;

  Movies({
    this.id,
    this.url,
    this.imdbCode,
    this.title,
    this.titleEnglish,
    this.titleLong,
    this.slug,
    this.year,
    this.rating,
    this.runtime,
    this.genres,
    this.summary,
    this.descriptionFull,
    this.synopsis,
    this.ytTrailerCode,
    this.language,
    this.mpaRating,
    this.backgroundImage,
    this.backgroundImageOriginal,
    this.smallCoverImage,
    this.mediumCoverImage,
    this.largeCoverImage,
    this.state,
    this.torrents,
    this.dateUploaded,
    this.dateUploadedUnix,
  });

  Movies.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    url = json["url"];
    imdbCode = json["imdb_code"];
    title = json["title"];
    titleEnglish = json["title_english"];
    titleLong = json["title_long"];
    slug = json["slug"];
    year = json["year"];
    // Fix: always parse as double
    rating = (json["rating"] as num?)?.toDouble();
    runtime = json["runtime"];
    genres = json["genres"] == null ? null : List<String>.from(json["genres"]);
    summary = json["summary"];
    descriptionFull = json["description_full"];
    synopsis = json["synopsis"];
    ytTrailerCode = json["yt_trailer_code"];
    language = json["language"];
    mpaRating = json["mpa_rating"];
    backgroundImage = json["background_image"];
    backgroundImageOriginal = json["background_image_original"];
    smallCoverImage = json["small_cover_image"];
    mediumCoverImage = json["medium_cover_image"];
    largeCoverImage = json["large_cover_image"];
    state = json["state"];
    torrents = json["torrents"] == null
        ? null
        : (json["torrents"] as List)
            .map((e) => Torrents.fromJson(e))
            .toList();
    dateUploaded = json["date_uploaded"];
    dateUploadedUnix = json["date_uploaded_unix"];
  }

  static List<Movies> fromList(List<Map<String, dynamic>> list) {
    return list.map(Movies.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["url"] = url;
    _data["imdb_code"] = imdbCode;
    _data["title"] = title;
    _data["title_english"] = titleEnglish;
    _data["title_long"] = titleLong;
    _data["slug"] = slug;
    _data["year"] = year;
    _data["rating"] = rating;
    _data["runtime"] = runtime;
    if(genres != null) {
      _data["genres"] = genres;
    }
    _data["summary"] = summary;
    _data["description_full"] = descriptionFull;
    _data["synopsis"] = synopsis;
    _data["yt_trailer_code"] = ytTrailerCode;
    _data["language"] = language;
    _data["mpa_rating"] = mpaRating;
    _data["background_image"] = backgroundImage;
    _data["background_image_original"] = backgroundImageOriginal;
    _data["small_cover_image"] = smallCoverImage;
    _data["medium_cover_image"] = mediumCoverImage;
    _data["large_cover_image"] = largeCoverImage;
    _data["state"] = state;
    if(torrents != null) {
      _data["torrents"] = torrents?.map((e) => e.toJson()).toList();
    }
    _data["date_uploaded"] = dateUploaded;
    _data["date_uploaded_unix"] = dateUploadedUnix;
    return _data;
  }
}

class Torrents {
  String? url;
  String? hash;
  String? quality;
  String? type;
  String? isRepack;
  String? videoCodec;
  String? bitDepth;
  String? audioChannels;
  int? seeds;
  int? peers;
  String? size;
  int? sizeBytes;
  String? dateUploaded;
  int? dateUploadedUnix;

  Torrents({this.url, this.hash, this.quality, this.type, this.isRepack, this.videoCodec, this.bitDepth, this.audioChannels, this.seeds, this.peers, this.size, this.sizeBytes, this.dateUploaded, this.dateUploadedUnix});

  Torrents.fromJson(Map<String, dynamic> json) {
    url = json["url"];
    hash = json["hash"];
    quality = json["quality"];
    type = json["type"];
    isRepack = json["is_repack"];
    videoCodec = json["video_codec"];
    bitDepth = json["bit_depth"];
    audioChannels = json["audio_channels"];
    seeds = json["seeds"];
    peers = json["peers"];
    size = json["size"];
    sizeBytes = json["size_bytes"];
    dateUploaded = json["date_uploaded"];
    dateUploadedUnix = json["date_uploaded_unix"];
  }

  static List<Torrents> fromList(List<Map<String, dynamic>> list) {
    return list.map(Torrents.fromJson).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["url"] = url;
    _data["hash"] = hash;
    _data["quality"] = quality;
    _data["type"] = type;
    _data["is_repack"] = isRepack;
    _data["video_codec"] = videoCodec;
    _data["bit_depth"] = bitDepth;
    _data["audio_channels"] = audioChannels;
    _data["seeds"] = seeds;
    _data["peers"] = peers;
    _data["size"] = size;
    _data["size_bytes"] = sizeBytes;
    _data["date_uploaded"] = dateUploaded;
    _data["date_uploaded_unix"] = dateUploadedUnix;
    return _data;
  }
}