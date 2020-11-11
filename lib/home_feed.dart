import 'package:flutter/material.dart';
import 'post_widget.dart';
import 'models.dart';
import 'ui_utils.dart';
import 'avatar_widget.dart';

class HomeFeedPage extends StatefulWidget {
  final ScrollController scrollController;

  HomeFeedPage({this.scrollController});

  @override
  _HomeFeedPageState createState() => _HomeFeedPageState();
}

class _HomeFeedPageState extends State<HomeFeedPage> {
  final _posts = <Post>[
    Post(
      user: grootlover,
      imageUrls: [
        'assets/images/apple.jpg',
        'assets/images/pasta.jpeg',
      ],
      likes: [
        Like(user: rocket),
        Like(user: starlord),
        Like(user: gamora),
        Like(user: nickwu241),
      ],
      comments: [
        Comment(
          text: 'An apple',
          user: rocket,
          commentedAt: DateTime(2019, 5, 23, 14, 35, 0),
          likes: [Like(user: nickwu241)],
        ),
      ],
      location: 'Earth',
      postedAt: DateTime(2019, 5, 23, 12, 35, 0),
    ),
    Post(
      user: nickwu241,
      imageUrls: ['assets/images/apple.jpg'],
      likes: [],
      comments: [],
      location: 'Knowhere',
      postedAt: DateTime(2019, 5, 21, 6, 0, 0),
    ),
    Post(
      user: nebula,
      imageUrls: ['assets/images/pasta.jpeg'],
      likes: [Like(user: nickwu241)],
      comments: [],
      location: 'Nine Realms',
      postedAt: DateTime(2019, 5, 2, 0, 0, 0),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (ctx, i) {
        return PostWidget(_posts[i]);
      },
      itemCount: _posts.length,
      controller: widget.scrollController,
    );
  }
}
