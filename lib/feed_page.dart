// import 'package:flutter/material.dart';
// import 'package:flutter_pagewise/flutter_pagewise.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:whispery/globals/constants.dart';
// import 'package:whispery/widgets/post.dart';
// import 'package:whispery/widgets/components.dart';
// import 'package:whispery/handler/location_handler.dart';
// import 'package:whispery/handler/feed_handler.dart';
// import 'dart:convert';

// class FeedPage extends StatefulWidget {
//   @override
//   createState() => _FeedPage();
// }

// class _FeedPage extends State<FeedPage>
//     with AutomaticKeepAliveClientMixin<FeedPage> {
//   static final _feedScaffoldKey = GlobalKey<ScaffoldState>();

//   //Keep scroll position on navigation change.
//   bool get wantKeepAlive => true;

//   //Username for appbar header.
//   String _username;

//   // List posts to be shown on feed.
//   List<Post> postList = [];

//   Components components = new Components();

//   PagewiseLoadController _pageLoadController;

//   @override
//   void initState() {
//     super.initState();
//     setUsername();
//     _pageLoadController = PagewiseLoadController(
//         pageSize: entries,
//         pageFuture: (index) {
//           return fetchFeed(index);
//         });
//   }

//   Future<List<Post>> fetchFeed(index) async {
//     // Clear list of any posts from previous index.
//     postList.clear();
//     await LocationHandler.getLocationUpdate().then((response) async {
//       if (response.latitude.isNaN) {
//         components.buildSnackbar(
//             _feedScaffoldKey.currentState, "Invalid location.");
//       } else {
//         await FeedHandler.getFeed(response, index).then((response) {
//           if (response.isNotEmpty) {
//             postList = PostList.fromJson(json.decode(response)).posts;
//           }
//         });
//       }
//     });
//     return postList;
//   }

//   void setUsername() {
//     SharedPreferences.getInstance().then((prefs) {
//       setState() {
//         _username =
//             prefs.get('username') != null ? prefs.get('username') : 'Guest';
//       }
//     });
//   }

//   reset() async {
//     await _pageLoadController.reset();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       key: _feedScaffoldKey,
//       appBar: AppBar(
//         title: Text(_username),
//       ),
//       body: PagewiseListView(
//         pageLoadController: _pageLoadController,
//         padding: EdgeInsets.all(10.0),
//         itemBuilder: (context, entry, index) {
//           return components.postTile(entry, context);
//         },
//       ),
//       bottomNavigationBar: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: <Widget>[
//           components.slider((response) {
//             setState(() {
//               if (distance != response) {
//                 distance = response;
//               }
//             });
//           }, (response) {
//             reset();
//           })
//         ],
//       ),
//     );
//   }
// }
