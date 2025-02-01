import 'package:flutter/material.dart';
import 'package:meet_buddy_app/messagecontent.dart';

class ChatMessage extends StatefulWidget {
  @override
  _ChatMessageState createState() => _ChatMessageState();
}

class _ChatMessageState extends State<ChatMessage> {
  List<MessageContent> messages = [
    MessageContent(content: "Hello!", isSentByMe: false, time: "10:30 AM"),
    MessageContent(
        content: "Hi! How are you?", isSentByMe: true, time: "10:31 AM"),
    MessageContent(
        content: "I'm good, thanks!", isSentByMe: false, time: "10:32 AM"),
  ];

  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        backgroundColor: Colors.purple, // AppBar color set to purple
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage:
                  AssetImage('assets/profile.jpg'), // Replace with your image
            ),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'John Doe',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.yellow, // Bright yellow for username
                  ),
                ),
                Text(
                  'Online',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors
                        .lightGreenAccent, // Light green for online status
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.call,
                color: Colors.orange), // Orange color for call icon
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.videocam,
                color: Colors.lightBlue), // Light blue color for video icon
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: true,
              padding: EdgeInsets.all(10),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                return ChatBubble(
                  message: messages[index],
                );
              },
            ),
          ),
          Divider(height: 1),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8),
            color: Colors.white,
            child: Row(
              children: [
                IconButton(
                  icon: Icon(Icons.attach_file),
                  onPressed: () {},
                ),
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'Type a message',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    setState(() {
                      messages.insert(
                        0,
                        MessageContent(
                          content: _controller.text,
                          isSentByMe: true,
                          time: "10:35 AM",
                        ),
                      );
                      _controller.clear();
                    });
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ChatBubble extends StatelessWidget {
  final MessageContent message;

  ChatBubble({required this.message});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment:
          message.isSentByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 5),
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        decoration: BoxDecoration(
          // Change color based on who sent the message
          color: message.isSentByMe
              ? Colors.deepPurple
              : Colors
                  .grey[200], // Sent by user is deep purple, received is grey
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
            bottomLeft: message.isSentByMe ? Radius.circular(15) : Radius.zero,
            bottomRight: message.isSentByMe ? Radius.zero : Radius.circular(15),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              message.content,
              style: TextStyle(
                color: message.isSentByMe
                    ? Colors.white
                    : Colors
                        .black, // White text for sent messages, black for received
              ),
            ),
            SizedBox(height: 5),
            Text(
              message.time,
              style: TextStyle(
                fontSize: 10,
                color: message.isSentByMe
                    ? Colors.white70
                    : Colors.black45, // Adjust color for time as well
              ),
            ),
          ],
        ),
      ),
    );
  }
}
