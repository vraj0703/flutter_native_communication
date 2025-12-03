//
//  Generated file. Do not edit.
//

// clang-format off

#include "generated_plugin_registrant.h"

#include <connectivity_plus/connectivity_plus_windows_plugin.h>
#include <flutter_core/flutter_core_plugin_c_api.h>
#include <flutter_localization/flutter_localization_plugin_c_api.h>
#include <flutter_native_communication/flutter_native_communication_plugin_c_api.h>
#include <my_localizations/my_localizations_plugin_c_api.h>
#include <my_logger_metrics/my_logger_metrics_plugin_c_api.h>

void RegisterPlugins(flutter::PluginRegistry* registry) {
  ConnectivityPlusWindowsPluginRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("ConnectivityPlusWindowsPlugin"));
  FlutterCorePluginCApiRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("FlutterCorePluginCApi"));
  FlutterLocalizationPluginCApiRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("FlutterLocalizationPluginCApi"));
  FlutterNativeCommunicationPluginCApiRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("FlutterNativeCommunicationPluginCApi"));
  MyLocalizationsPluginCApiRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("MyLocalizationsPluginCApi"));
  MyLoggerMetricsPluginCApiRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("MyLoggerMetricsPluginCApi"));
}
