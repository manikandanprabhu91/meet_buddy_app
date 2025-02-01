import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'userprovider.dart';

class ChatDashboard extends StatefulWidget {
  @override
  _ChatDashboardState createState() => _ChatDashboardState();
}

class _ChatDashboardState extends State<ChatDashboard> {
  @override
  void initState() {
    super.initState();
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    userProvider.fetchUsers(); // Call the fetchUsers method here
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat Dashboard'),
      ),
      body: userProvider.users.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: userProvider.users.length,
              itemBuilder: (context, index) {
                final user = userProvider.users[index];
                return ListTile(
                  title: Text(user.name),
                  trailing: Icon(
                    user.isOnline ? Icons.circle : Icons.circle_outlined,
                    color: user.isOnline ? Colors.green : Colors.red,
                  ),
                );
              },
            ),
    );
  }
}
