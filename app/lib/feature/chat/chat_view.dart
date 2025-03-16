import 'dart:io';

import 'package:app/static/app_style.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'chat_view_model.dart';

class ChatView extends StatelessWidget {
  const ChatView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ChatViewModel(),
      child: Consumer<ChatViewModel>(
        builder: (context, model, child) {
          return Scaffold(
            backgroundColor: Colors.black,
            appBar: AppBar(
              title: const Text(
                'Chat',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
              centerTitle: true,
              toolbarHeight: 50,
              backgroundColor: AppStyle.secondaryColor1,
            ),
            body: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    controller: model.scrollController,
                    itemCount: model.messages.length,
                    itemBuilder: (context, index) {
                      final message = model.messages[index];
                      return Align(
                        alignment: message.isUser ? Alignment.centerRight : Alignment.centerLeft,
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                          padding: const EdgeInsets.all(10),
                          child: message.imageUrl != null
                            ? Image.file(
                                File(message.imageUrl!),
                                width: 200,
                                height: 200,
                                fit: BoxFit.cover,
                              )
                            : Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: message.isUser
                                      ? [Colors.blue, Colors.blueAccent]
                                      : [AppStyle.secondaryColor2, AppStyle.secondaryColor2],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                message.text,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                              ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  height: 80,
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: AppStyle.secondaryColor1,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.camera_alt),
                        color: Colors.grey[100],
                        style: ButtonStyle(
                          backgroundColor: WidgetStateProperty.all(AppStyle.secondaryColor2),
                        ),
                        onPressed: model.pickImage,
                      ),
                      const SizedBox(width: 16),
                      SizedBox(
                        height: 45,
                        width: 250,
                        child: TextField(
                          controller: model.controller,
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            hintText: 'Type a message...',
                            hintStyle: const TextStyle(
                              color: Colors.grey,
                            ),
                            contentPadding: const EdgeInsets.only(left: 15, top: 10),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: const BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(color: Colors.grey[700]!)
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: const BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(color: Colors.grey[700]!),
                            ),
                          ),
                          onChanged: (_) => model.checkButtonStatus(),
                        ),
                      ),
                      const SizedBox(width: 8),
                      IconButton(
                        icon: const Icon(Icons.send),
                        color: model.isMessageEmtpy
                          ? const Color(0xFF5A5A5A)
                          : AppStyle.contrastColor1,
                        onPressed: model.sendMessage,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}