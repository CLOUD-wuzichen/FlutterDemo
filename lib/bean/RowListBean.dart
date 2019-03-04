import 'package:json_annotation/json_annotation.dart';
part 'RowListBean.g.dart';

@JsonSerializable()
class RowResult {
  @JsonKey(name: 'response')
  RowResponse response;

  RowResult(this.response);

  factory RowResult.fromJson(Map<String,dynamic> json) => _$RowResultFromJson(json);
  Map<String, dynamic> toJson() => _$RowResultToJson(this);
}

@JsonSerializable()
class RowResponse {
  @JsonKey(name: 'has_more')
  bool hasMore;
  @JsonKey(name: 'last_key')
  var lastKey;
  List<Feed> feeds;

  RowResponse(this.hasMore, this.lastKey, this.feeds);

  factory RowResponse.fromJson(Map<String,dynamic> json) => _$RowResponseFromJson(json);
  Map<String, dynamic> toJson() => _$RowResponseToJson(this);

}

@JsonSerializable()
class Feed {
  String image;
  int type;
  @JsonKey(name: 'index_type')
  int indexType;
  Post post;

  Feed(this.image, this.type, this.indexType, this.post);

  factory Feed.fromJson(Map<String,dynamic> json) => _$FeedFromJson(json);
  Map<String, dynamic> toJson() => _$FeedToJson(this);
}

@JsonSerializable()
class Post {
  @JsonKey(name: 'column')
  MyColumn column;
  int id;
  String title;
  String description;
  @JsonKey(name: 'publish_time')
  int publishTime;
  String image;
  @JsonKey(name: 'start_time')
  int startTime;
  @JsonKey(name: 'comment_count')
  int commentCount;

  ///评论数
  @JsonKey(name: 'comment_status')
  bool commentStatus;

  ///收藏数
  @JsonKey(name: 'praise_count')
  int praiseCount;
  @JsonKey(name: 'super_tag')
  String superTag;
  @JsonKey(name: 'page_style')
  int pageStyle;
  @JsonKey(name: 'post_id')
  int postId;
  String appview;
  @JsonKey(name: 'file_length')
  String filmLength;
  String datatype;


  Post(this.column, this.id, this.title, this.description, this.publishTime,
      this.image, this.startTime, this.commentCount, this.commentStatus,
      this.praiseCount, this.superTag, this.pageStyle, this.postId,
      this.appview, this.filmLength, this.datatype);

  factory Post.fromJson(Map<String,dynamic> json) => _$PostFromJson(json);
  Map<String, dynamic> toJson() => _$PostToJson(this);
}


@JsonSerializable()
class MyColumn {
  String name;
  String icon;

  MyColumn(this.name, this.icon);
  factory MyColumn.fromJson(Map<String,dynamic> json) => _$MyColumnFromJson(json);
  Map<String, dynamic> toJson() => _$MyColumnToJson(this);
}
