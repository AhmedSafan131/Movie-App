class MoviesResponse {
  String? status;
  String? statusMessage;
  Data? data;
  Meta? meta;

  MoviesResponse({
    this.status,
    this.statusMessage,
    this.data,
    this.meta,
  });

  MoviesResponse.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    statusMessage = json["status_message"];
    data = json["data"] == null ? null : Data.fromJson(json["data"]);
    meta = json["@meta"] == null ? null : Meta.fromJson(json["@meta"]);
  }

  Map<String, dynamic> toJson() {
    return {
      "status": status,
      "status_message": statusMessage,
      "data": data?.toJson(),
      "@meta": meta?.toJson(),
    };
  }

  static List<MoviesResponse> fromList(List<Map<String, dynamic>> list) {
    return list.map((e) => MoviesResponse.fromJson(e)).toList();
  }
}

class Meta {
  int? serverTime;
  String? serverTimezone;
  int? apiVersion;
  String? executionTime;

  Meta({
    this.serverTime,
    this.serverTimezone,
    this.apiVersion,
    this.executionTime,
  });

  Meta.fromJson(Map<String, dynamic> json) {
    serverTime = json["server_time"];
    serverTimezone = json["server_timezone"];
    apiVersion = json["api_version"];
    executionTime = json["execution_time"];
  }

  Map<String, dynamic> toJson() {
    return {
      "server_time": serverTime,
      "server_timezone": serverTimezone,
      "api_version": apiVersion,
      "execution_time": executionTime,
    };
  }

  static List<Meta> fromList(List<Map<String, dynamic>> list) {
    return list.map((e) => Meta.fromJson(e)).toList();
  }
}

class Data {
  int? movieCount;
  int? limit;
  int? pageNumber;
  List<Movies>? movies;

  Data({
    this.movieCount,
    this.limit,
    this.pageNumber,
    this.movies,
  });

  Data.fromJson(Map<String, dynamic> json) {
    movieCount = json["movie_count"];
    limit = json["limit"];
    pageNumber = json["page_number"];
    movies = (json["movies"] as List?)?.map((e) => Movies.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    return {
      "movie_count": movieCount,
      "limit": limit,
      "page_number": pageNumber,
      "movies": movies?.map((e) => e.toJson()).toList(),
    };
  }

  static List<Data> fromList(List<Map<String, dynamic>> list) {
    return list.map((e) => Data.fromJson(e)).toList();
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
  double? rating;
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
  // Added new properties for enhanced functionality
  List<Cast>? cast;
  int? likeCount;
  int? downloadCount;

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
    this.cast,
    this.likeCount,
    this.downloadCount,
  });

  Movies.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    url = json["url"];
    imdbCode = json["imdb_code"];
    title = json["title"];
    titleEnglish = json["title_english"];
    titleLong = json["title_long"];
    slug = json["slug"];
    year = json["year"];
    rating = (json["rating"] as num?)?.toDouble();
    runtime = json["runtime"];
    genres = (json["genres"] as List?)?.map((e) => e.toString()).toList() ?? [];
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
    torrents = (json["torrents"] as List?)?.map((e) => Torrents.fromJson(e)).toList();
    dateUploaded = json["date_uploaded"];
    dateUploadedUnix = json["date_uploaded_unix"];

    // Parse cast data if available
    cast = (json["cast"] as List?)?.map((e) => Cast.fromJson(e)).toList();

    // Parse like count and download count if available
    likeCount = json["like_count"];
    downloadCount = json["download_count"];
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "url": url,
      "imdb_code": imdbCode,
      "title": title,
      "title_english": titleEnglish,
      "title_long": titleLong,
      "slug": slug,
      "year": year,
      "rating": rating,
      "runtime": runtime,
      "genres": genres,
      "summary": summary,
      "description_full": descriptionFull,
      "synopsis": synopsis,
      "yt_trailer_code": ytTrailerCode,
      "language": language,
      "mpa_rating": mpaRating,
      "background_image": backgroundImage,
      "background_image_original": backgroundImageOriginal,
      "small_cover_image": smallCoverImage,
      "medium_cover_image": mediumCoverImage,
      "large_cover_image": largeCoverImage,
      "state": state,
      "torrents": torrents?.map((e) => e.toJson()).toList(),
      "date_uploaded": dateUploaded,
      "date_uploaded_unix": dateUploadedUnix,
      "cast": cast?.map((e) => e.toJson()).toList(),
      "like_count": likeCount,
      "download_count": downloadCount,
    };
  }

  static List<Movies> fromList(List<Map<String, dynamic>> list) {
    return list.map((e) => Movies.fromJson(e)).toList();
  }
}

class Cast {
  String? name;
  String? characterName;
  String? urlSmallImage;
  String? imdbCode;

  Cast({
    this.name,
    this.characterName,
    this.urlSmallImage,
    this.imdbCode,
  });

  Cast.fromJson(Map<String, dynamic> json) {
    name = json["name"];
    characterName = json["character_name"];
    urlSmallImage = json["url_small_image"];
    imdbCode = json["imdb_code"];
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "character_name": characterName,
      "url_small_image": urlSmallImage,
      "imdb_code": imdbCode,
    };
  }

  static List<Cast> fromList(List<Map<String, dynamic>> list) {
    return list.map((e) => Cast.fromJson(e)).toList();
  }
}

class Torrents {
  String? url;
  String? hash;
  String? quality;
  String? type;
  String? isRepack;
  int? seeds;
  int? peers;
  String? size;
  int? sizeBytes;
  String? dateUploaded;
  int? dateUploadedUnix;

  Torrents({
    this.url,
    this.hash,
    this.quality,
    this.type,
    this.isRepack,
    this.seeds,
    this.peers,
    this.size,
    this.sizeBytes,
    this.dateUploaded,
    this.dateUploadedUnix,
  });

  Torrents.fromJson(Map<String, dynamic> json) {
    url = json["url"];
    hash = json["hash"];
    quality = json["quality"];
    type = json["type"];
    isRepack = json["is_repack"];
    seeds = json["seeds"];
    peers = json["peers"];
    size = json["size"];
    sizeBytes = json["size_bytes"];
    dateUploaded = json["date_uploaded"];
    dateUploadedUnix = json["date_uploaded_unix"];
  }

  Map<String, dynamic> toJson() {
    return {
      "url": url,
      "hash": hash,
      "quality": quality,
      "type": type,
      "is_repack": isRepack,
      "seeds": seeds,
      "peers": peers,
      "size": size,
      "size_bytes": sizeBytes,
      "date_uploaded": dateUploaded,
      "date_uploaded_unix": dateUploadedUnix,
    };
  }

  static List<Torrents> fromList(List<Map<String, dynamic>> list) {
    return list.map((e) => Torrents.fromJson(e)).toList();
  }
}