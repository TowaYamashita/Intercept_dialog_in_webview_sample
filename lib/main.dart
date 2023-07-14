import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:intercept_dialog_in_webview_sample/env/env.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: InAppWebView(
        initialUrlRequest: URLRequest(
          url: Uri.tryParse(Env.initialUrl),
        ),

        /// window.alert()をインターセプト
        onJsAlert: (_, req) async {
          final result = await showOkAlertDialog(
            context: context,
            title: 'アラート',
            message: req.message,
          );
          return JsAlertResponse(
            handledByClient: true,
            action: result == OkCancelResult.ok
                ? JsAlertResponseAction.CONFIRM
                : null,
          );
        },

        /// window.confirm()をインターセプト
        onJsConfirm: (_, req) async {
          final result = await showOkCancelAlertDialog(
            context: context,
            title: '確認',
            message: req.message,
          );
          return JsConfirmResponse(
            handledByClient: true,
            action: result == OkCancelResult.ok
                ? JsConfirmResponseAction.CONFIRM
                : JsConfirmResponseAction.CANCEL,
          );
        },

        /// window.prompt()をインターセプト
        onJsPrompt: (_, req) async {
          final result = await showTextInputDialog(
            context: context,
            textFields: [
              DialogTextField(
                initialText: req.defaultValue,
              ),
            ],
            title: 'プロンプト',
            message: req.message,
          );
          return JsPromptResponse(
            handledByClient: true,
            value: result?.first,
            action: result?.first != null
                ? JsPromptResponseAction.CONFIRM
                : JsPromptResponseAction.CANCEL,
          );
        },
      ),
    );
  }
}
