import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Threads Clone',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black,
          elevation: 0,
        ),
      ),
      home: const ThreadsHomePage(),
    );
  }
}

class ThreadsHomePage extends StatefulWidget {
  const ThreadsHomePage({Key? key}) : super(key: key);

  @override
  _ThreadsHomePageState createState() => _ThreadsHomePageState();
}

class _ThreadsHomePageState extends State<ThreadsHomePage> {
  int _selectedIndex = 0;
  int _selectedTab = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onTabSelected(int index) {
    setState(() {
      _selectedTab = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _pages = [
      _selectedTab == 0 ? const HomeScreen() : const FollowingScreen(),
      const Center(child: Text('Search Page', style: TextStyle(color: Colors.white))),
      const Center(child: Text('Post Page', style: TextStyle(color: Colors.white))),
      const Center(child: Text('Activity Page', style: TextStyle(color: Colors.white))),
      const Center(child: Text('Profile Page', style: TextStyle(color: Colors.white))),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
            const Text(
              '@',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildTabButton("For You", 0),
                const SizedBox(width: 20),
                _buildTabButton("Following", 1),
              ],
            ),
          ],
        ),
        centerTitle: true,
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert),
            color: Colors.grey[900],
            onSelected: (value) {
              if (value == 'Logout') {
                debugPrint('Logging out...');
              } else {
                debugPrint('Selected: $value');
              }
            },
            itemBuilder: (BuildContext context) => [
              const PopupMenuItem(value: 'Appearance', child: Text('Appearance')),
              const PopupMenuItem(value: 'Insights', child: Text('Insights')),
              const PopupMenuItem(value: 'Feelings', child: Text('Feelings')),
              const PopupMenuItem(value: 'Feeds', child: Text('Feeds')),
              const PopupMenuItem(value: 'Saved', child: Text('Saved')),
              const PopupMenuItem(value: 'Likes', child: Text('Likes')),
              const PopupMenuItem(value: 'Report a Problem', child: Text('Report a Problem')),
              const PopupMenuItem(
                value: 'Logout',
                child: Text('Logout', style: TextStyle(color: Colors.red)),
              ),
            ],
          ),
        ],
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home, size: 30), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search, size: 30), label: 'Search'),
          BottomNavigationBarItem(icon: Icon(Icons.add_circle_outline, size: 35), label: 'Post'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite_border, size: 30), label: 'Activity'),
          BottomNavigationBarItem(icon: Icon(Icons.person, size: 30), label: 'Profile'),
        ],
      ),
    );
  }

  Widget _buildTabButton(String text, int index) {
    return GestureDetector(
      onTap: () => _onTabSelected(index),
      child: Column(
        children: [
          Text(
            text,
            style: TextStyle(
              color: _selectedTab == index ? Colors.white : Colors.grey,
              fontWeight: _selectedTab == index ? FontWeight.bold : FontWeight.normal,
              fontSize: 16,
            ),
          ),
          if (_selectedTab == index)
            Container(
              margin: const EdgeInsets.only(top: 4),
              height: 3,
              width: 50,
              color: Colors.white,
            ),
        ],
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.only(top: 8),
      itemCount: mockPosts.length,
      itemBuilder: (context, index) {
        return PostWidget(post: mockPosts[index]);
      },
    );
  }
}

class FollowingScreen extends StatelessWidget {
  const FollowingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Post> followedPosts = [];

    if (followedPosts.isEmpty) {
      return const Center(
        child: Text(
          "Follow more profiles to get your feed going.",
          style: TextStyle(color: Colors.grey, fontSize: 16),
        ),
      );
    } else {
      return ListView.builder(
        padding: const EdgeInsets.only(top: 8),
        itemCount: followedPosts.length,
        itemBuilder: (context, index) {
          return PostWidget(post: followedPosts[index]);
        },
      );
    }
  }
}

class Post {
  final String username;
  final String timeAgo;
  final String content;
  final String? imageUrl;
  final int replies;
  int likes;

  Post({
    required this.username,
    required this.timeAgo,
    required this.content,
    this.imageUrl,
    required this.replies,
    required this.likes,
  });
}

// Keep mockPosts mutable because we will update likes in PostWidget state
final List<Post> mockPosts = [
  Post(
    username: "Rat",
    timeAgo: "24h",
    content: "The rat in question:",
    imageUrl: "assets/images/rat-dance.gif",
    replies: 7,
    likes: 53,
  ),
  Post(
    username: "Kumalala",
    timeAgo: "6m",
    content: "Savesta",
    imageUrl: "assets/images/kumalala.gif",
    replies: 7,
    likes: 58,
  ),
  Post(
    username: "Edwin",
    timeAgo: "1y",
    content: "My name is Edwin, I made the mimic",
    imageUrl: null,
    replies: 100,
    likes: 1070,
  ),
  Post(
    username: "Car",
    timeAgo: "7m",
    content: "Silly",
    imageUrl: null,
    replies: 50,
    likes: 500,
  ),
];

class PostWidget extends StatefulWidget {
  final Post post;
  const PostWidget({Key? key, required this.post}) : super(key: key);

  @override
  State<PostWidget> createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  late bool isLiked;
  late int likeCount;

  @override
  void initState() {
    super.initState();
    isLiked = false;
    likeCount = widget.post.likes;
  }

  void toggleLike() {
    setState(() {
      if (isLiked) {
        isLiked = false;
        likeCount--;
      } else {
        isLiked = true;
        likeCount++;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 24,
                backgroundColor: Colors.grey.shade800,
                child: const Icon(Icons.person, color: Colors.white, size: 28),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.post.username,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    widget.post.timeAgo,
                    style: TextStyle(
                      color: Colors.grey.shade500,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(widget.post.content, style: const TextStyle(color: Colors.white, fontSize: 15)),
          if (widget.post.imageUrl != null) ...[
            const SizedBox(height: 12),
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                widget.post.imageUrl!,
                fit: BoxFit.cover,
              ),
            ),
          ],
          const SizedBox(height: 12),
          Row(
            children: [
              GestureDetector(
                onTap: toggleLike,
                child: Icon(
                  isLiked ? Icons.favorite : Icons.favorite_border,
                  color: isLiked ? Colors.red : Colors.grey.shade500,
                  size: 18,
                ),
              ),
              const SizedBox(width: 4),
              Text("$likeCount", style: TextStyle(color: Colors.grey.shade400, fontSize: 14)),
              const SizedBox(width: 16),
              Icon(Icons.chat_bubble_outline, color: Colors.grey.shade500, size: 18),
              const SizedBox(width: 4),
              Text("${widget.post.replies}", style: TextStyle(color: Colors.grey.shade400, fontSize: 14)),
              const SizedBox(width: 16),
              Icon(Icons.repeat, color: Colors.grey.shade500, size: 18),
              const SizedBox(width: 16),
              Icon(Icons.share, color: Colors.grey.shade500, size: 18),
            ],
          ),
          const Divider(color: Colors.grey, height: 24),
        ],
      ),
    );
  }
}
