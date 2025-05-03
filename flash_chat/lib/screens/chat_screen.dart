import 'package:flutter/material.dart';
import 'package:flash_chat/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final _firestore = FirebaseFirestore.instance;
User? loggedInUser;

class ChatScreen extends StatefulWidget {
  static String id = 'chat_screen';
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _auth = FirebaseAuth.instance;
  final messageTextController = TextEditingController();
  final ScrollController _scrollController = ScrollController(); // ADD THIS

  String messageText = "";

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
      }
    } catch (e) {
      print(e);
    }
  }

  void messagesStream() async {
    await for (var snapshot in _firestore.collection('messages').snapshots()) {
      for (var message in snapshot.docs) {
        print(message.data());
      }
    }
  }

  void scrollToBottom() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              _auth.signOut();
              Navigator.pop(context);
            },
          ),
        ],
        title: Text('⚡️Chat'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            MessagesStream(scrollController: _scrollController),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: messageTextController,
                      onChanged: (value) {
                        messageText = value;
                      },
                      style: TextStyle(color: Colors.black),
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      if (messageText.trim().isNotEmpty) {
                        _firestore.collection('messages').add({
                          'text': messageText,
                          'sender': loggedInUser!.email,
                          'timestamp': FieldValue.serverTimestamp(),
                        });
                        messageTextController.clear();
                        scrollToBottom();
                      }
                    },
                    child: Text('Send', style: kSendButtonTextStyle),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MessagesStream extends StatelessWidget {
  final ScrollController scrollController;
  const MessagesStream({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: StreamBuilder<QuerySnapshot>(
        stream:
            _firestore.collection('messages').orderBy('timestamp').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final messages = snapshot.data!.docs;
            List<MessageBubble> messageBubbles = [];

            for (var message in messages) {
              final messageText = message['text'];
              final messageSender = message['sender'];

              final currentUser = loggedInUser?.email;

              final messageBubble = MessageBubble(
                sender: messageSender,
                text: messageText,
                isMe: currentUser == messageSender,
              );
              messageBubbles.add(messageBubble);
            }

            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (scrollController.hasClients) {
                scrollController.jumpTo(
                  scrollController.position.maxScrollExtent,
                );
              }
            });

            return ListView(
              controller: scrollController,
              reverse: false,
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
              children: messageBubbles,
            );
          } else {
            return Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.lightBlueAccent,
              ),
            );
          }
        },
      ),
    );
  }
}

class MessageBubble extends StatelessWidget {
  const MessageBubble({
    required this.sender,
    required this.text,
    required this.isMe,
  });

  final String sender;
  final String text;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: <Widget>[
          Text(sender, style: TextStyle(color: Colors.black54, fontSize: 12.0)),
          Material(
            borderRadius:
                isMe
                    ? BorderRadius.only(
                      topLeft: Radius.circular(25.0),
                      bottomLeft: Radius.circular(25.0),
                      bottomRight: Radius.circular(25.0),
                    )
                    : BorderRadius.only(
                      topRight: Radius.circular(25.0),
                      bottomLeft: Radius.circular(25.0),
                      bottomRight: Radius.circular(25.0),
                    ),
            elevation: 5.0,
            color: isMe ? Colors.lightBlueAccent : Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10.0,
                vertical: 20.0,
              ),
              child: Text(
                text,
                style:
                    isMe
                        ? TextStyle(fontSize: 15.0, color: Colors.white)
                        : TextStyle(fontSize: 15.0, color: Colors.black54),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
