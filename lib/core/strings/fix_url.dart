import 'package:qr_mobile_vision_example/core/api_manager/api_url.dart';

class FixUrl {
  static String fixAvatarImage(String? image) {
    if (image == null || image.isEmpty) return '';
    if (image.startsWith('http')) return image;
    final String link = "https://$baseUrl/Images/$image";
    return link;
  }
}
