import 'package:flutter/material.dart';
import 'app.dart';
import 'services/storage_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Storage.init();
  runApp(const DevCorpApp());
}
