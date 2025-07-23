import 'package:cellula_task/features/weather/domain/Entity/weather.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

abstract class BaseAiDataSource {
  Future<String> sendDataToAI({
    required CurrentWeather weather,
    required String name,
  });
}

class AiDataSource implements BaseAiDataSource {
  final GenerativeModel _model;

  AiDataSource()
    : _model = GenerativeModel(
        model: "gemini-2.0-flash",
        apiKey: "AIzaSyAbF7I-cHkU_EBXZlv23P29pFHwm0yEhfQ",
      );

  @override
  Future<String> sendDataToAI({
    required CurrentWeather weather,
    required String name,
  }) async {
    final prompt =
        '''
Hi, my name is $name. Here's the current weather in ${weather.city}, ${weather.country}:

- Condition: ${weather.condition}
- Temperature: ${weather.temperature}°C
- Cloud coverage: ${weather.cloud}%
- Wind speed: ${weather.windSpeed} km/h
- Humidity: ${weather.humidity}%

Can you tell me in 3–4 simple sentences if it's a good idea to go outside now?
''';

    final content = [Content.text(prompt)];
    final response = await _model.generateContent(content);
    return response.text ?? 'Error: No response';
  }
}


// import 'package:flutter/material.dart';
// import 'package:google_generative_ai/google_generative_ai.dart';
// import 'package:your_app_name/secrets.dart'; // تأكد من تحديث المسار

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatefulWidget {
//   @override
//   _MyAppState createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   final String _modelName = 'gemini-pro'; // أو gemini-pro-vision إذا كنت تستخدم صورًا
//   late final GenerativeModel _model;
//   final TextEditingController _textController = TextEditingController();
//   String _responseText = "أدخل نصًا للحصول على رد من Gemini.";
//   bool _isLoading = false;

//   @override
//   void initState() {
//     super.initState();
//     _model = GenerativeModel(model: _modelName, apiKey: geminiApiKey);
//   }

//   Future<void> _generateContent(String prompt) async {
//     setState(() {
//       _isLoading = true;
//       _responseText = "جاري التفكير...";
//     });

//     try {
//       final content = [Content.text(prompt)];
//       final response = await _model.generateContent(content);
//       setState(() {
//         _responseText = response.text ?? "لم يتم استلام رد.";
//       });
//     } catch (e) {
//       setState(() {
//         _responseText = "حدث خطأ: $e";
//       });
//     } finally {
//       setState(() {
//         _isLoading = false;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text('Gemini API في Flutter'),
//         ),
//         body: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             children: [
//               TextField(
//                 controller: _textController,
//                 decoration: InputDecoration(
//                   hintText: 'اكتب سؤالك هنا...',
//                   border: OutlineInputBorder(),
//                 ),
//                 maxLines: 3,
//               ),
//               SizedBox(height: 10),
//               ElevatedButton(
//                 onPressed: _isLoading
//                     ? null
//                     : () {
//                         if (_textController.text.isNotEmpty) {
//                           _generateContent(_textController.text);
//                         }
//                       },
//                 child: Text(_isLoading ? 'جاري الإرسال...' : 'إرسال'),
//               ),
//               SizedBox(height: 20),
//               Expanded(
//                 child: SingleChildScrollView(
//                   child: Text(
//                     _responseText,
//                     style: TextStyle(fontSize: 16),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }