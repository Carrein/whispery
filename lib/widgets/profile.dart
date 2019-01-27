import 'package:whispery/widgets/post.dart';

class Profile {
  final String uid;
  final String username;
  final String bio;
  final String flair;
  final List<Post> posts;

  Profile({
    this.uid,
    this.username,
    this.bio,
    this.flair,
    this.posts
  });

}