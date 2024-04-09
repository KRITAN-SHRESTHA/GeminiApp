import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class TextImageInput extends StatefulWidget {
  const TextImageInput({super.key});

  @override
  TextImageInputState createState() => TextImageInputState();
}

class TextImageInputState extends State<TextImageInput> {
  String input = '';
  String output = '';
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Text and image input'),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Type your message here..',
                        fillColor: Colors.grey[20],
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      onChanged: (value) {
                        input = value;
                      },
                    ),
                  ),
                  loading
                      ? const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: CircularProgressIndicator(),
                        )
                      : IconButton(
                          onPressed: generateText,
                          icon: const Icon(Icons.send),
                        ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Image.asset(
                          'assets/images/image-input-1.png',
                          fit: BoxFit.contain,
                          height: 120,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Image.asset(
                          'assets/images/image-input-2.png',
                          fit: BoxFit.contain,
                          height: 120,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Image.asset(
                          'assets/images/image-input-3.png',
                          fit: BoxFit.contain,
                          height: 120,
                        ),
                      ),
                    ],
                  )
                ],
              ),
              // const SizedBox(
              //   height: 20,
              // ),
              // ElevatedButton(
              //   onPressed: generateText,
              //   child: const Text('Generate text'),
              // ),
              // const SizedBox(
              //   height: 20,
              // ),
              // (loading)
              //     ? const Center(
              //         child: CircularProgressIndicator(),
              //       )
              //     : Text(output),
              const SizedBox(
                height: 20,
              ),
              Text(output)
            ],
          ),
        ),
      ),
    );
  }

  generateText() async {
    setState(() {
      loading = true;
    });
    const apiKey = 'AIzaSyBxwdZiDk2Yz7LQ3FbBEiKXFlLfgEWEqps';

    // for text and image input, use gemini-pro-vision model
    final model = GenerativeModel(model: 'gemini-pro-vision', apiKey: apiKey);
    final (firstImage, secondImage, thirdImage) = await (
      getImageBytes('assets/images/image-input-1.png'),
      getImageBytes('assets/images/image-input-2.png'),
      getImageBytes('assets/images/image-input-3.png'),
    ).wait;

    if (firstImage == null || secondImage == null || thirdImage == null) {
      setState(() {
        output = 'Error loading images';
        loading = false;
      });
      return;
    }

    final response = await model.generateContent([
      Content.multi([
        TextPart(input),
        DataPart('image/png', firstImage),
        DataPart('image/png', secondImage),
        DataPart('image/png', thirdImage),
      ])
    ]);

    setState(() {
      output = response.text ?? 'No response';
      loading = false;
    });
  }

  Future<Uint8List?> getImageBytes(String assetPath) async {
    try {
      ByteData byteData = await rootBundle.load(assetPath);
      return byteData.buffer.asUint8List();
    } catch (e) {
      debugPrint('Error loading image: $e');
    }
    return null;
  }
}
