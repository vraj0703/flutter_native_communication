#include "include/flutter_native_communication/flutter_native_communication_plugin_c_api.h"

#include <flutter/plugin_registrar_windows.h>

#include "flutter_native_communication_plugin.h"

void FlutterNativeCommunicationPluginCApiRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  flutter_native_communication::FlutterNativeCommunicationPlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}
