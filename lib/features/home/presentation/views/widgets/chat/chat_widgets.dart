import 'dart:convert';

import 'package:art_gallery/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ChatUI extends StatefulWidget {
  @override
  State<ChatUI> createState() => _ChatUIState();
}

class _ChatUIState extends State<ChatUI> {
  List<ChatMessage> messages = [];
  @override
  void initState() {
    super.initState();
    // Initialize the chat with a welcome message
    SharedPreferences.getInstance().then((prefs) {
      List<String> savedMessages = prefs.getStringList("messages") ?? [];
      setState(() {
        messages = savedMessages.map((message) {
          return ChatMessage(
            message: message.substring(1),
            isMe: message[0] == '1',
          );
        }).toList();
      });
      if (messages.isEmpty) {
        setState(() {
          messages.add(ChatMessage(
            message: 'Welcome to the Art Museum Chatbot!',
            isMe: false,
          ));
        });
      }
    });
  }

  @override
  void dispose() {
    // Save the messages to SharedPreferences when the widget is disposed
    SharedPreferences.getInstance().then((prefs) {
      List<String> savedMessages = messages.map((message) {
        return (message.isMe ? '1' : '0') + message.message;
      }).toList();
      prefs.setStringList("messages", savedMessages);
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.75,
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
      ),
      child: Column(
        children: [
          Text(
            'Chat',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                return messages[index];
              },
            ),
          ),
          buildChatInputField(),
        ],
      ),
    );
  }

  Widget buildChatInputField() {
    TextEditingController inputController = TextEditingController();
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8.0),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: Row(
          children: [
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                // Clear the chat messages
                setState(() {
                  messages.clear();
                  messages.add(ChatMessage(
                    message: 'Welcome to the Art Museum Chatbot!',
                    isMe: false,
                  ));
                });
                // Clear the saved messages in SharedPreferences
                SharedPreferences.getInstance().then((prefs) {
                  prefs.remove("messages");
                });
              },
            ),
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Type a message',
                  border: InputBorder.none,
                ),
                controller: inputController,
                onSubmitted: (value) async {
                  // Add the message to the list
                  setState(() {
                    messages.add(ChatMessage(
                      message: value,
                      isMe: true,
                    ));
                  });
                  // Clear the text field
                  inputController.clear();
                  FocusScope.of(context).unfocus();
                  // Get the response message
                  var responseMessage = await getResponseMessage(value);
                  // Add the response message to the list
                  setState(() {
                    messages.add(responseMessage);
                  });
                },
              ),
            ),
            IconButton(
              icon: Icon(Icons.send),
              onPressed: () async {
                // Add the message to the list
                var prompt = inputController.text;
                setState(() {
                  messages.add(ChatMessage(
                    message: prompt,
                    isMe: true,
                  ));
                });
                // Clear the text field
                inputController.clear();
                FocusScope.of(context).unfocus();
                // Get the response message
                getResponseMessage(prompt).then((responseMessage) {
                  // Add the response message to the list
                  setState(() {
                    messages.add(responseMessage);
                  });
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<ChatMessage> getResponseMessage(String prompt) async {
    // Call your API or logic to get the response message
    var response = await http.post(
      Uri.parse('http://art-musuem-chatbot.runasp.net/Chatbot'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'text/plain',
      },
      body: jsonEncode({
        'userPrompt': prompt,
      }),
    );

    if (response.statusCode == 200) {
      // Parse the response and return a ChatMessage
      var responseData = response.body; // Parse as needed
      return ChatMessage(message: responseData, isMe: false);
    } else {
      throw Exception('Failed to load response');
    }
  }
}

class ChatMessage extends StatelessWidget {
  final String message;
  final bool isMe;

  ChatMessage({required this.message, required this.isMe});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment:
            isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!isMe)
            CircleAvatar(
              child: Icon(Icons.computer),
              radius: 16,
            ),
          SizedBox(width: 8),
          Container(
              padding: EdgeInsets.all(12),
              constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.7),
              decoration: BoxDecoration(
                color: isMe ? AppColors.lightPrimaryColor : Colors.grey[300],
                borderRadius: BorderRadius.circular(16),
              ),
              child: MarkdownBody(
                data: message,
                selectable: true,
                styleSheet: MarkdownStyleSheet(
                  p: TextStyle(
                    color: isMe ? Colors.white : Colors.black,
                    fontSize: 15,
                  ),
                ),
              )),
          if (isMe) SizedBox(width: 8),
          if (isMe)
            CircleAvatar(
              child: Icon(Icons.person),
              radius: 16,
            ),
        ],
      ),
    );
  }
}
