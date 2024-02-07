import 'package:flutter/material.dart';

class DeviceInfo extends StatelessWidget {
  final String deviceInfo;
  const DeviceInfo(
      {Key? key, required this.deviceInfo, required deviceInfoPlugin})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          deviceInfo ?? 'Loading device info..',
          maxLines: 10,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontSize: 16),
        ));
  }
}
