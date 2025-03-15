import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'chat_message_model.dart';

class ChatViewModel extends ChangeNotifier {
  final List<ChatMessage> messages = [];
  final TextEditingController controller = TextEditingController();
  final ScrollController scrollController = ScrollController();
  final ImagePicker _picker = ImagePicker();

  void checkButtonStatus() {
    notifyListeners();
  }

  void sendMessage() {
    if (controller.text.isEmpty) return;
    messages.add(ChatMessage(
      text: controller.text,
      isUser: true,
    ));
    controller.clear();
    notifyListeners();
    scrollToBottom(200);

    // MOCK
    Future.delayed(const Duration(seconds: 1), () {
      messages.add(ChatMessage(
        text: 'Hello! How can I help you?',
        isUser: false,
      ));
      notifyListeners();
    });
    scrollToBottom(1100);
  }

  Future<void> pickImage() async {
    final image = await _picker.pickImage(source: ImageSource.gallery);
    if (image == null) return;

    messages.add(ChatMessage(
      text: '',
      isUser: true,
      imageUrl: image.path,
    ));
    notifyListeners();
    scrollToBottom(200);

    // MOCK
    Future.delayed(const Duration(seconds: 1), () {
      messages.add(ChatMessage(
        text: 'I received your image!',
        isUser: false,
      ));
      notifyListeners();
    });
    scrollToBottom(1100);
  }

  void scrollToBottom(int duration) {
    Future.delayed(Duration(milliseconds: duration), () {
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  bool get isMessageEmtpy => controller.text.isEmpty;
}