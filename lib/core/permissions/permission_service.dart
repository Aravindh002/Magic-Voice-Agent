import 'package:permission_handler/permission_handler.dart';

class PermissionService {
  Future<bool> ensureMicrophonePermission() async {
    final status = await Permission.microphone.request();
    return status.isGranted;
  }

  Future<bool> ensureContactsPermission() async {
    final status = await Permission.contacts.request();
    return status.isGranted;
  }
}
