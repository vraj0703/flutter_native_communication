//
//  Generated file. Do not edit.
//

// clang-format off

#include "generated_plugin_registrant.h"

#include <flutter_core/flutter_core_plugin.h>
#include <flutter_localization/flutter_localization_plugin.h>
#include <flutter_native_communication/flutter_native_communication_plugin.h>
#include <my_localizations/my_localizations_plugin.h>
#include <my_logger_metrics/my_logger_metrics_plugin.h>

void fl_register_plugins(FlPluginRegistry* registry) {
  g_autoptr(FlPluginRegistrar) flutter_core_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "FlutterCorePlugin");
  flutter_core_plugin_register_with_registrar(flutter_core_registrar);
  g_autoptr(FlPluginRegistrar) flutter_localization_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "FlutterLocalizationPlugin");
  flutter_localization_plugin_register_with_registrar(flutter_localization_registrar);
  g_autoptr(FlPluginRegistrar) flutter_native_communication_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "FlutterNativeCommunicationPlugin");
  flutter_native_communication_plugin_register_with_registrar(flutter_native_communication_registrar);
  g_autoptr(FlPluginRegistrar) my_localizations_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "MyLocalizationsPlugin");
  my_localizations_plugin_register_with_registrar(my_localizations_registrar);
  g_autoptr(FlPluginRegistrar) my_logger_metrics_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "MyLoggerMetricsPlugin");
  my_logger_metrics_plugin_register_with_registrar(my_logger_metrics_registrar);
}
