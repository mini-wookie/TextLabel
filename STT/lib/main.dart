import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import '/format_markdown.dart';
import '/markdown_text_input.dart';

void main() => runApp(MyApp());

// ignore: public_member_api_docs
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String description = 'HiT STT TASK 진행용 임시 프로그램';
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();

    controller.addListener(() {
      print(controller.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Theme(
        data: ThemeData(
          primaryColor: const Color(0xFFC00C3F),
          colorScheme: ColorScheme.light().copyWith(secondary: const Color(0xFF27232C)),
          cardColor: const Color(0xFFFFFFFF),
          textTheme: const TextTheme(bodyText2: TextStyle(fontSize: 20)),
            textSelectionTheme: TextSelectionThemeData(
              selectionColor: const Color(0x4FC00C3F),
              selectionHandleColor: const Color(0x4FC00C3F),
            ),
        ),
        child: Scaffold(
          appBar:
          AppBar(
            title: const Text('학습데이터 라벨링 작업용', style: TextStyle(fontWeight: FontWeight.bold),),
            backgroundColor: Color(0xFFC00C3F),
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: ListView(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: MarkdownTextInput(
                          (String value) => setState(() => description = value),
                      description,
                      label: 'Description',
                      maxLines: 15,
                      actions: MarkdownType.values,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}