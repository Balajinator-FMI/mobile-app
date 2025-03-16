import 'dart:convert';
import 'dart:io';

import 'package:app/api/backend/user_repository.dart';
import 'package:app/static/dependency_injection.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'chat_message_model.dart';

class ChatViewModel extends ChangeNotifier {
  final List<ChatMessage> messages = [];
  final TextEditingController controller = TextEditingController();
  final ScrollController scrollController = ScrollController();
  final ImagePicker _picker = ImagePicker();
  final _userRepository = DependencyInjection.getIt<UserRepository>();

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
  }

  Future<void> pickImage() async {
    final image = await _picker.pickImage(source: ImageSource.gallery);
    if (image == null) return;

    // Convert image to Base64
    final File imageFile = File(image.path);
    final List<int> imageBytes = await imageFile.readAsBytes();
    final String base64Image = base64Encode(imageBytes);

    messages.add(ChatMessage(
      text: '',
      isUser: true,
      imageUrl: image.path,
    ));
    notifyListeners();
    scrollToBottom(200);

    try {
      final result = await _userRepository.diagnoseUser(base64Image);

      messages.add(ChatMessage(
        text:
            'There is ${result['probability']}% chance that you have ${result['disease']} - ${getDiseaseDescription(result['disease'] as String)}',
        isUser: false,
      ));
      notifyListeners();
      scrollToBottom(1100);

      messages.add(ChatMessage(
        text: 'Symptoms: ${getDiseaseSymptoms(result['disease'] as String)}',
        isUser: false,
      ));
      notifyListeners();
      scrollToBottom(1100);

      messages.add(ChatMessage(
        text: 'Please consult a dermatologist for further diagnosis and treatment.',
        isUser: false,
      ));
      notifyListeners();
      scrollToBottom(1100);
    } catch (e) {
      print(e);
      messages.add(ChatMessage(
        text: 'Failed to diagnose your image. Please try again.',
        isUser: false,
      ));
      notifyListeners();
      scrollToBottom(1100);
    }
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

  String getDiseaseDescription(String disease) {
    switch (disease) {
      case 'Actinic Keratosis':
        return 'a precancerous skin condition caused by prolonged UV exposure. It may develop into squamous cell carcinoma if untreated.';
      case 'Basal Cell Carcinoma':
        return 'the most common type of skin cancer, caused by excessive sun exposure. It rarely spreads to other parts of the body.';
      case 'Dermatofibroma':
        return 'a benign skin growth, often appearing as a small, firm bump under the skin, commonly found on the legs.';
      case 'Melanoma':
        return 'the most aggressive type of skin cancer, developing from melanocytes (pigment-producing cells). It can quickly spread if not treated early.';
      case 'Nevus':
        return 'a common skin growth made of pigmented cells, usually harmless but occasionally developing into melanoma.';
      case 'Pigmented Benign Keratosis':
        return 'a harmless skin lesion that often appears in older adults, sometimes resembling melanoma.';
      case 'Seborrheic Keratosis':
        return 'a noncancerous, wart-like skin growth that becomes more common with age.';
      case 'Squamous Cell Carcinoma':
        return 'a common type of skin cancer that can spread if untreated, often caused by long-term sun exposure.';
      case 'Vascular Lesion':
        return 'abnormal blood vessel formations, including birthmarks or conditions like hemangiomas.';
      default:
        return 'no description available.';
    }
  }

  String getDiseaseSymptoms(String disease) {
    switch (disease) {
      case 'Actinic Keratosis':
        return 'Rough, scaly patches on sun-exposed areas (face, ears, hands), often red or brown, with a dry or crusty texture.';
      case 'Basal Cell Carcinoma':
        return 'A pearly or waxy bump, sometimes with visible blood vessels, or a flat, scaly patch that slowly grows.';
      case 'Dermatofibroma':
        return 'A hard, reddish-brown nodule that may be sensitive to touch, sometimes causing a "dimple" effect when pinched.';
      case 'Melanoma':
        return 'A new or changing mole with irregular borders, asymmetry, uneven color (black, brown, red, or white), and rapid growth.';
      case 'Nevus':
        return 'A small, round or oval spot, brown or black in color, which can be flat or raised. Sudden changes in size or shape may indicate malignancy.';
      case 'Pigmented Benign Keratosis':
        return 'Dark brown, slightly raised, and well-defined lesions with a rough texture, commonly found on the face, chest, and back.';
      case 'Seborrheic Keratosis':
        return 'Brown, black, or tan waxy or "stuck-on" looking growths with a rough or scaly surface, appearing mostly on the face, back, or chest.';
      case 'Squamous Cell Carcinoma':
        return 'A firm, red nodule or a flat sore with a scaly crust, often found on the face, ears, hands, or other sun-exposed areas.';
      case 'Vascular Lesion':
        return 'Red, blue, or purple discolorations on the skin, which may be flat or raised, and sometimes cause swelling or sensitivity.';
      default:
        return 'No symptoms available.';
    }
  }
}
