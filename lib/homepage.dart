import 'package:flutter/material.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  // Sample list of profiles
  final List<Map<String, dynamic>> profiles = [
    {
      'name': 'Emily',
      'age': 25,
      'distance': '2 miles away',
      'image': 'https://randomuser.me/api/portraits/women/44.jpg',
    },
    {
      'name': 'John',
      'age': 28,
      'distance': '5 miles away',
      'image': 'https://randomuser.me/api/portraits/men/55.jpg',
    },
    {
      'name': 'Sophia',
      'age': 22,
      'distance': '3 miles away',
      'image': 'https://randomuser.me/api/portraits/women/57.jpg',
    },
    {
      'name': 'Michael',
      'age': 30,
      'distance': '7 miles away',
      'image': 'https://randomuser.me/api/portraits/men/88.jpg',
    },
    {
      'name': 'Jessica',
      'age': 27,
      'distance': '4 miles away',
      'image': 'https://randomuser.me/api/portraits/women/68.jpg',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Discover Profiles'),
        backgroundColor: Colors.pinkAccent,
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: profiles.length,
        itemBuilder: (context, index) {
          final profile = profiles[index];
          return GestureDetector(
            onTap: () {
              // Navigate to profile details when a profile is tapped
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProfileDetailPage(profile: profile),
                ),
              );
            },
            child: Card(
              elevation: 4,
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(12)),
                    child: Image.network(
                      profile['image'],
                      height: 200,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${profile['name']}, ${profile['age']}',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              profile['distance'],
                              style: const TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                        const Icon(
                          Icons.favorite_border,
                          color: Colors.pinkAccent,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Action for exploring or viewing matches
          // e.g., navigate to match screen or add new profile functionality
        },
        backgroundColor: Colors.pinkAccent,
        child: const Icon(Icons.favorite),
      ),
    );
  }
}

class ProfileDetailPage extends StatelessWidget {
  final Map<String, dynamic> profile;

  const ProfileDetailPage({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${profile['name']}\'s Profile'),
        backgroundColor: Colors.pinkAccent,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Profile picture
          ClipRRect(
            borderRadius:
                const BorderRadius.vertical(bottom: Radius.circular(20)),
            child: Image.network(
              profile['image'],
              height: 300,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 20),
          // Profile info
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${profile['name']}, ${profile['age']}',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  profile['distance'],
                  style: const TextStyle(fontSize: 18, color: Colors.grey),
                ),
                const SizedBox(height: 16),
                Text(
                  'About ${profile['name']}',
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus imperdiet, nulla et dictum interdum, nisi lorem egestas odio, vitae scelerisque enim ligula venenatis dolor.',
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 20), // Added for spacing
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Chat Screen"),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/chat');
                      },
                      child: const Text(
                        'Chat',
                        style:
                            TextStyle(color: Color.fromARGB(255, 106, 7, 15)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
