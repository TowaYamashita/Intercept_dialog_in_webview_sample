# intercept_dialog_in_webview_sample

# required
- Flutter 3.10.4
- Dart 3.0.3 (stable)
- Android Studio Dolphin 2021.3.1 Patch 1
- ngrok 3.3.1

# usage

1. webサーバを立ち上げる
```
cd server
docker compose up -d
```

2. ngrok で1で立ち上げたサーバをインターネットからアクセスできるようにする
```
ngrok http 80
```

3. .envファイルを作成し、INITIAL_URLに、2で立ち上げた際に発行されるHTTPSプロトコルでアクセスできるURLを書く
```
cp .env.example .env
```

4. 環境変数に関するファイルを生成する
```
flutter pub get
flutter pub run build_runner build --delete-conflicting-outputs
```

5. アプリを立ち上げる
```
flutter run --debug
```