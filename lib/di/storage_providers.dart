import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:netguru_task/modules/values/storage/values_storage.dart';
import 'package:netguru_task/storage/secure_storage.dart';
import 'package:provider/provider.dart';

class StorageProviders extends StatelessWidget {
  const StorageProviders({Key key, @required this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final secureStorage = SecureStorage(
      const FlutterSecureStorage(),
    );

    return MultiProvider(
      providers: [
        Provider<ValuesStorage>(
          create: (_) => ValuesStorage(
            secureStorage,
          ),
        ),
      ],
      child: child,
    );
  }
}
