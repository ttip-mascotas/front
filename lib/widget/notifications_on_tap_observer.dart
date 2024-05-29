import 'package:flutter/material.dart';
import 'package:mascotas/navigation/navigation.dart';
import 'package:mascotas/notifications/notifier.dart';

class NotificationsOnTapObserver extends StatefulWidget {
  final Widget child;
  final Notifier notifier;

  const NotificationsOnTapObserver({
    required this.child,
    super.key,
    required this.notifier,
  });

  @override
  State<NotificationsOnTapObserver> createState() =>
      _NotificationsOnTapObserverState();
}

class _NotificationsOnTapObserverState extends State<NotificationsOnTapObserver>
    with WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    switch (state) {
      case AppLifecycleState.resumed:
        widget.notifier.notificationResponse().then((notificationResponse) {
          if (notificationResponse != null) {
            Navigation.goToTreatmentScheduleScreen(
              context: context,
              id: notificationResponse.id!,
            );
          }
        });
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
