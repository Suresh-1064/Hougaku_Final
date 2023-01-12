import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hougaku/app/modules/settings/settings_controller.dart';
import 'package:hougaku/app/modules/settings/widgets/settingsOptions.dart';
import 'package:hougaku/app/modules/settings/widgets/webViewScreen.dart';

/// UI for settings screen .
class SettingsScreen extends StatelessWidget {
  SettingsScreen({Key? key}) : super(key: key);
  final settingsController = Get.find<SettingsController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Column(
        children: [
          SettingsOptions(
            title: "Sleep Timer",
            subtitle: "To set sleep timer",
            function: () async {
              settingsController.newTime = await showTimePicker(
                context: context,
                initialTime: TimeOfDay.now(),
              );
              print("Time choosen");
              print(settingsController.newTime);
              settingsController.setSleepTimer(settingsController.newTime!);
            },
            icon: Icons.timer,
          ),
          SettingsOptions(
            title: "Reset",
            subtitle: "To reset account",
            function: () {
              Get.defaultDialog(
                  title: "Warning",
                  middleText: "Do you want to reset data",
                  onConfirm: () {
                    print("close dialoge");
                    settingsController.clearDB();
                    Get.back();
                  },
                  onCancel: () {});
              // showTimePicker(context: context, initialTime: TimeOfDay.now());
            },
            icon: Icons.lock_reset_outlined,
          ),
          SettingsOptions(
            title: "Terms & Conditions",
            subtitle: "Learn more about terms & conditions",
            function: () {
              Get.to(WebViewScreen(
                  title: "Terms & Conditions",
                  url: "https://suresh-1064.github.io/Hougaku/terms"));
            },
            icon: Icons.info,
          ),
          SettingsOptions(
            title: "Privacy Policy",
            subtitle: "Learn more about privacy policy ",
            function: () {
              Get.to(WebViewScreen(
                  title: "Privacy Policy",
                  url: "https://suresh-1064.github.io/Hougaku/privacy"));
            },
            icon: Icons.privacy_tip,
          ),
        ],
      ),
    );
  }
}
