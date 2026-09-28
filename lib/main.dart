import 'package:flutter/material.dart';

void main() {
  runApp(const AtharApp());
}

class AtharApp extends StatelessWidget {
  const AtharApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'أثر',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF0F0F0F),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF0F0F0F),
          elevation: 0,
        ),
      ),
      home: const MainNavigationScreen(),
    );
  }
}

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const HomeScreen(),
    const Center(child: Text('استكشف الأثر', style: TextStyle(color: Colors.white70))),
    const Center(child: Text('إضافة أثر جديد (+)', style: TextStyle(color: Colors.white70))),
    const Center(child: Text('الإشعارات والتفاعلات', style: TextStyle(color: Colors.white70))),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color(0xFF161616),
        selectedItemColor: Colors.amberAccent,
        unselectedItemColor: Colors.white54,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: 'الرئيسية'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'بحث'),
          BottomNavigationBarItem(icon: Icon(Icons.add_box_outlined, size: 28), label: 'نشر'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite_border), label: 'الإشعارات'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'حسابي'),
        ],
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'أَثَــر',
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(icon: const Icon(Icons.chat_bubble_outline), onPressed: () {}),
        ],
      ),
      body: ListView(
        children: [
          // شريط القصص (Stories)
          SizedBox(
            height: 105,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 8,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(3),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            colors: [Colors.amber, Colors.deepOrangeAccent],
                          ),
                        ),
                        child: CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.grey.shade900,
                          child: const Icon(Icons.person, color: Colors.white54),
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        index == 0 ? 'أثرك' : 'مستخدم $index',
                        style: const TextStyle(fontSize: 12, color: Colors.white70),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          const Divider(color: Colors.white10),
          // قائمة المنشورات
          ...List.generate(4, (index) => const PostCard()),
        ],
      ),
    );
  }
}

class PostCard extends StatefulWidget {
  const PostCard({super.key});

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  bool isLiked = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossCrossAlignment.start,
        children: [
          ListTile(
            leading: const CircleAvatar(
              backgroundColor: Colors.grey,
              child: Icon(Icons.person, color: Colors.white),
            ),
            title: const Text('صاحب الأثر', style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle: const Text('قبل ساعتين', style: TextStyle(fontSize: 11, color: Colors.white38)),
            trailing: IconButton(icon: const Icon(Icons.more_vert), onPressed: () {}),
          ),
          Container(
            height: 350,
            width: double.infinity,
            color: const Color(0xFF1E1E1E),
            child: const Center(
              child: Icon(Icons.image_outlined, size: 70, color: Colors.white24),
            ),
          ),
          Row(
            children: [
              IconButton(
                icon: Icon(
                  isLiked ? Icons.favorite : Icons.favorite_border,
                  color: isLiked ? Colors.redAccent : Colors.white,
                ),
                onPressed: () => setState(() => isLiked = !isLiked),
              ),
              IconButton(icon: const Icon(Icons.chat_bubble_outline), onPressed: () {}),
              IconButton(icon: const Icon(Icons.send_outlined), onPressed: () {}),
              const Spacer(),
              IconButton(icon: const Icon(Icons.bookmark_border), onPressed: () {}),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossCrossAlignment.start,
              children: [
                Text(
                  isLiked ? '121 إعجاباً' : '120 إعجاباً',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                RichText(
                  text: const TextSpan(
                    style: TextStyle(color: Colors.white),
                    children: [
                      TextSpan(text: 'صاحب الأثر ', style: TextStyle(fontWeight: FontWeight.bold)),
                      TextSpan(text: 'الصورة ليست مجرد لقطة عابرة، بل هي الأثر الذي نتركه للذاكرة.'),
                    ],
                  ),
                ),
                const SizedBox(height: 6),
                const Text('عرض جميع التعليقات (18)', style: TextStyle(color: Colors.white38, fontSize: 13)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('الملف الشخصي'),
        actions: [IconButton(icon: const Icon(Icons.menu), onPressed: () {})],
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.amberAccent,
                  child: Icon(Icons.person, size: 45, color: Colors.black),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: const [
                      _StatColumn(label: 'الآثار', count: '24'),
                      _StatColumn(label: 'متابعون', count: '1.4K'),
                      _StatColumn(label: 'يتابع', count: '320'),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Text('صانع محتوى وباحث عن الأثر الجميل 📸✨', style: TextStyle(color: Colors.white70)),
          ),
          const SizedBox(height: 16),
          const Divider(color: Colors.white10),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 12,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 2,
              mainAxisSpacing: 2,
            ),
            itemBuilder: (context, index) {
              return Container(
                color: const Color(0xFF1E1E1E),
                child: const Center(
                  child: Icon(Icons.image, color: Colors.white12),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _StatColumn extends StatelessWidget {
  final String label;
  final String count;
  const _StatColumn({required this.label, required this.count});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(count, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 2),
        Text(label, style: const TextStyle(fontSize: 12, color: Colors.white54)),
      ],
    );
  }
}
