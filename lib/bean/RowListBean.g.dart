// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'RowListBean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RowResult _$RowResultFromJson(Map<String, dynamic> json) {
  return RowResult(json['response'] == null
      ? null
      : RowResponse.fromJson(json['response'] as Map<String, dynamic>));
}

Map<String, dynamic> _$RowResultToJson(RowResult instance) =>
    <String, dynamic>{'response': instance.response};

RowResponse _$RowResponseFromJson(Map<String, dynamic> json) {
  return RowResponse(
      json['has_more'] as bool,
      json['last_key'],
      (json['feeds'] as List)
          ?.map((e) =>
              e == null ? null : Feed.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$RowResponseToJson(RowResponse instance) =>
    <String, dynamic>{
      'has_more': instance.hasMore,
      'last_key': instance.lastKey,
      'feeds': instance.feeds
    };

Feed _$FeedFromJson(Map<String, dynamic> json) {
  return Feed(
      json['image'] as String,
      json['type'] as int,
      json['index_type'] as int,
      json['post'] == null
          ? null
          : Post.fromJson(json['post'] as Map<String, dynamic>));
}

Map<String, dynamic> _$FeedToJson(Feed instance) => <String, dynamic>{
      'image': instance.image,
      'type': instance.type,
      'index_type': instance.indexType,
      'post': instance.post
    };

Post _$PostFromJson(Map<String, dynamic> json) {
  return Post(
      json['column'] == null
          ? null
          : MyColumn.fromJson(json['column'] as Map<String, dynamic>),
      json['id'] as int,
      json['title'] as String,
      json['description'] as String,
      json['publish_time'] as int,
      json['image'] as String,
      json['start_time'] as int,
      json['comment_count'] as int,
      json['comment_status'] as bool,
      json['praise_count'] as int,
      json['super_tag'] as String,
      json['page_style'] as int,
      json['post_id'] as int,
      json['appview'] as String,
      json['file_length'] as String,
      json['datatype'] as String);
}

Map<String, dynamic> _$PostToJson(Post instance) => <String, dynamic>{
      'column': instance.column,
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'publish_time': instance.publishTime,
      'image': instance.image,
      'start_time': instance.startTime,
      'comment_count': instance.commentCount,
      'comment_status': instance.commentStatus,
      'praise_count': instance.praiseCount,
      'super_tag': instance.superTag,
      'page_style': instance.pageStyle,
      'post_id': instance.postId,
      'appview': instance.appview,
      'file_length': instance.filmLength,
      'datatype': instance.datatype
    };

MyColumn _$MyColumnFromJson(Map<String, dynamic> json) {
  return MyColumn(json['name'] as String, json['icon'] as String);
}

Map<String, dynamic> _$MyColumnToJson(MyColumn instance) =>
    <String, dynamic>{'name': instance.name, 'icon': instance.icon};
