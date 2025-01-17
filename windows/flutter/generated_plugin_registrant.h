#ifndef FLUTTER_PLUGIN_FLUTTER_DOC_SCANNER_PLUGIN_H_
#define FLUTTER_PLUGIN_FLUTTER_DOC_SCANNER_PLUGIN_H_

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>
#pragma once

#include <memory>

#ifdef FLUTTER_PLUGIN_IMPL
#define FLUTTER_PLUGIN_EXPORT __declspec(dllexport)
#else
#define FLUTTER_PLUGIN_EXPORT __declspec(dllimport)
#endif

namespace flutter_doc_scanner {

/**
 * The FlutterDocScannerPlugin class provides a plugin implementation
 * for communication between Dart and native Windows code.
 */
class FLUTTER_PLUGIN_EXPORT FlutterDocScannerPlugin : public flutter::Plugin {
 public:
  /**
   * Registers the plugin with the provided Windows plugin registrar.
   * @param registrar The registrar that manages the plugin.
   */
  static void RegisterWithRegistrar(flutter::PluginRegistrarWindows* registrar);

  /**
   * Constructor for FlutterDocScannerPlugin.
   */
  FlutterDocScannerPlugin();

  /**
   * Destructor for FlutterDocScannerPlugin.
   */
  virtual ~FlutterDocScannerPlugin();

  // Prevent copying and assignment.
  FlutterDocScannerPlugin(const FlutterDocScannerPlugin&) = delete;
  FlutterDocScannerPlugin& operator=(const FlutterDocScannerPlugin&) = delete;

  /**
   * Handles method calls from the Dart side.
   * @param method_call The method call object containing method name and arguments.
   * @param result The result object for sending responses back to Dart.
   */
  void HandleMethodCall(
      const flutter::MethodCall<flutter::EncodableValue>& method_call,
      std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result);
};

}  // namespace flutter_doc_scanner

#endif  // FLUTTER_PLUGIN_FLUTTER_DOC_SCANNER_PLUGIN_H_
