import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/session_bridge.dart';
import '../providers/auth_provider.dart';

/// Registers [SessionBridge] so [ApiClient] 401 handling updates [AuthProvider].
class SessionBinder extends StatefulWidget {
  const SessionBinder({super.key, required this.child});

  final Widget child;

  @override
  State<SessionBinder> createState() => _SessionBinderState();
}

class _SessionBinderState extends State<SessionBinder> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      SessionBridge.register(() {
        if (mounted) {
          unawaited(context.read<AuthProvider>().sessionExpired());
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
