
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:spacepod/model/chat_message_model.dart';
import 'package:spacepod/utils/constants.dart';

class ChatRepo {
  static chatTextGenerationRepo(List<ChatMessageModel> previousMessages) async {
    try {
      Dio dio = Dio();

    final response =  await dio.post("https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash-thinking-exp-01-21:generateContent?key=$apikey",
    data: {
    "contents":previousMessages.map((e)=>e.toMap()).toList() ,
      "systemInstruction": {
    "role": "user",
    "parts": [
      {
        "text": "make the model more inclined towards space and universe and the respond should always betwenn 80-100 words"
      }
    ]
  },
        "generationConfig": {
    "temperature": 0.7,
    "topK": 64,
    "topP": 0.7,
    "maxOutputTokens": 2500,
    "responseMimeType": "text/plain"
  },
    }
   
    );
     if(response.statusCode!>=200 && response.statusCode!<300)
     {
       return response.data['candidates'].first['content']['parts'].first['text'];
     }

    } catch (e) {
      log(e.toString());
    }
  }
}