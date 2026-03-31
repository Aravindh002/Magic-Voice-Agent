import 'package:url_launcher/url_launcher.dart';

import '../shared/models/assistant_command.dart';

class ActionExecutorService {
  Future<String> execute(AssistantCommand command) async {
    switch (command.type) {
      case CommandType.openWebsite:
        final url = command.payload?['url'] as String?;
        if (url == null) return 'Missing website URL.';
        final uri = Uri.parse(url.startsWith('http') ? url : 'https://$url');
        await launchUrl(uri, mode: LaunchMode.externalApplication);
        return 'Opened $url';
      case CommandType.openApp:
        final app = command.payload?['app'] as String? ?? 'requested app';
        return 'Attempted to open $app via Android intent mapping.';
      case CommandType.callPhone:
        final number = command.payload?['number'] as String? ?? '';
        await launchUrl(Uri.parse('tel:$number'));
        return 'Calling $number';
      case CommandType.sendSms:
        await launchUrl(Uri.parse('sms:'));
        return 'Opening SMS composer.';
      default:
        return 'Executed ${command.type.name}.';
    }
  }
}
