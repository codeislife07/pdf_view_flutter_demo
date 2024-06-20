import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:pdf_view_flutter_demo/pdf/assets_screen.dart';
import 'package:pdf_view_flutter_demo/pdf/file_screen.dart';
import 'package:pdf_view_flutter_demo/pdf/network_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Pdf View'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const AssetsPdfScreen()));
              },
              child: const Text("Assets pdf"),
            ),
            ElevatedButton(
              onPressed: () async {
                FilePickerResult? result = await FilePicker.platform.pickFiles(
                  type: FileType.custom,
                  allowedExtensions: ['pdf'],
                );
                if (result == null) {
                  return;
                }
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) =>
                            FilePdfScreen(result?.files.single.path ?? "")));
              },
              child: const Text("File pdf"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const NetworkScreen()));
              },
              child: const Text("Network pdf"),
            ),
          ],
        ),
      ),
    );
  }
}
