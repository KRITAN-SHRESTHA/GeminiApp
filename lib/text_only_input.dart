import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class TextOnlyInput extends StatefulWidget {
  const TextOnlyInput({super.key});

  @override
  State<TextOnlyInput> createState() => _TextOnlyInputState();
}

class _TextOnlyInputState extends State<TextOnlyInput> {
  String input = '';
  String output = '';
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Please enter text '),
      ),
      body: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: TextFormField(
                    decoration: InputDecoration(
                      filled: true,
                      contentPadding: const EdgeInsets.all(10),
                      labelText: 'Please enter the text here...',
                      hintStyle: const TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    onChanged: (value) {
                      input = value;
                    },
                  ),
                ),
              ),
              Expanded(
                child: IconButton(
                  onPressed: generateText,
                  icon: const Icon(Icons.send),
                  color: (loading) ? Colors.blue : Colors.blue,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: Builder(
              builder: (context) {
                if (loading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SingleChildScrollView(
                    child: Text(output),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void generateText() async {
    setState(() {
      loading = true;
    });
    // const apiKey = String.fromEnvironment('API_KEY', defaultValue: '');
    const apiKey = 'AIzaSyBxwdZiDk2Yz7LQ3FbBEiKXFlLfgEWEqps';
    // user gemini-pro model
    final model = GenerativeModel(model: 'gemini-pro', apiKey: apiKey);
    final content = [Content.text(input)];
    final response = await model.generateContent(content);
    setState(() {
      output = response.text ?? 'No response';

      loading = false;
    });
  }
}
