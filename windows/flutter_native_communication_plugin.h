#ifndef FLUTTER_PLUGIN_FLUTTER_NATIVE_COMMUNICATION_PLUGIN_H_
#define FLUTTER_PLUGIN_FLUTTER_NATIVE_COMMUNICATION_PLUGIN_H_

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>

#include <memory>

namespace flutter_native_communication {

class FlutterNativeCommunicationPlugin : public flutter::Plugin {
 public:
  static void RegisterWithRegistrar(flutter::PluginRegistrarWindows *registrar);

  FlutterNativeCommunicationPlugin();

  virtual ~FlutterNativeCommunicationPlugin();

  // Disallow copy and assign.
  FlutterNativeCommunicationPlugin(const FlutterNativeCommunicationPlugin&) = delete;
  FlutterNativeCommunicationPlugin& operator=(const FlutterNativeCommunicationPlugin&) = delete;

  // Called when a method is called on this plugin's channel from Dart.
  void HandleMethodCall(
      const flutter::MethodCall<flutter::EncodableValue> &method_call,
      std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result);
};

}  // namespace flutter_native_communication

#endif  // FLUTTER_PLUGIN_FLUTTER_NATIVE_COMMUNICATION_PLUGIN_H_
