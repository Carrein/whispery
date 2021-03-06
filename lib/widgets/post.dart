import 'package:flutter/material.dart';
import 'package:whispery/widgets/components.dart';

class Post {
  final String id;
  final String content;
  final String username;
  final String flair;
  final double latitude;
  final double longitude;
  final int likes;
  final int time;
  

  Post(
      {this.id,
      this.content,
      this.latitude,
      this.longitude,
      this.time,
      this.username,
      this.flair,
      this.likes});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
        id: json['id'],
        content: json['content'],
        latitude: json['latitude'],
        longitude: json['longitude'],
        time: json['time'],
        username: json['username'],
        flair: json['flair']);
  }
}

class PostList {
  final List<Post> posts;

  PostList({this.posts});

  factory PostList.fromJson(List<dynamic> parsedJson) {
    List<Post> posts = new List<Post>();
    posts = parsedJson.map((i) => Post.fromJson(i)).toList();

    return new PostList(posts: posts);
  }
}
