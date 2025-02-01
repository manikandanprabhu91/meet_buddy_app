import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:socket_io_client/socket_io_client.dart' as IO;

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  IO.Socket? socket;
  List<dynamic> messages = [];
  TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _connectToWebSocket();
    _fetchMessages();
  }

  // Connect to WebSocket (Socket.IO)
  void _connectToWebSocket() {
    socket = IO.io('http://localhost:3000', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });
    socket!.connect();

    // Listen for messages from server
    socket!.on('chatMessages', (data) {
      setState(() {
        messages = data;
      });
    });

    socket!.on('chatMessage', (message) {
      setState(() {
        messages.add(message);
      });
    });
  }

  // Fetch chat messages from REST API
  Future<void> _fetchMessages() async {
    final response = await http.get(
        Uri.parse('http://192.168.0.32:3000/api/messages'),
        headers: {'Content-Type': 'application/json'});
    print('Response status: ${response.statusCode}');
    if (response.statusCode == 200) {
      setState(() {
        messages = jsonDecode(response.body);
      });
    } else {
      throw Exception('Failed to load messages');
    }
  }

  // Send message using WebSocket
  Future<void> _sendMessage(String messageText) async {
    print('welcome');
    String apiUrl = 'http://192.168.0.32:3000/api/messages';
    if (messageText.isNotEmpty) {
      print('welcome111');
      final message = {'text': messageText, 'sender': 'User'};
      print(message);
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(message),
      );
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseBody = jsonDecode(response.body);
        print(responseBody);
      }
      socket!.emit('sendMessage', message);
      _controller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(messages[index]['sender']),
                  subtitle: Text(messages[index]['text']),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(labelText: 'Send a message'),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () => _sendMessage(_controller.text),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    socket?.disconnect();
    super.dispose();
  }
}
