
cmake_minimum_required(VERSION 3.16)

project(Mirror LANGUAGES CXX VERSION 1.0.0)
# Find all required package, if some is missing it will result in error in target_link_libraries
find_package(Qt6 REQUIRED COMPONENTS
  Core
  Gui
  Qml
  Quick
  QuickControls2
  Svg
  Xml
  WebEngineQuick
  )
find_package(Qt6 QUIET COMPONENTS QmlWorkerScript)

add_executable(Mirror main.cpp resources.qrc)

# Require cmake 3.8 but way nicer than writing to global CMAKE_CXX_STANDARD
target_compile_features(Mirror PUBLIC cxx_std_11)

# Better to use the target PROPERTIES and not global set(CMAKE_AUTOMOC ON)
# Otherwise if superbuild, moc will try to moc dependencies too.
set_target_properties(Mirror PROPERTIES AUTORCC TRUE)
set_target_properties(Mirror PROPERTIES AUTOMOC TRUE)
#qt_add_qml_module(myqmlsingleton-module
#    URI MyQmlSingleton
#    QML_FILES
#        Plugins/Info/home.qml
#)
#set_target_properties(myqmlsingle-module PROPERTIES AUTOMOC TRUE)
# target_link_libraries and not qt5_use_module because it is deprecated
target_link_libraries(Mirror PRIVATE
  Qt6::Core
  Qt6::Gui
  Qt6::Svg
  Qt6::Xml
  Qt6::Qml
  Qt6::Quick
  Qt6::QuickControls2
  Qt6::WebEngineQuick
)

# Only use static macro if linking with static qt
get_target_property(QT_TARGET_TYPE Qt6::Core TYPE)
if(${QT_TARGET_TYPE} STREQUAL "STATIC_LIBRARY")
  include(cmake/FetchQtStaticCMake.cmake)

  qt_generate_plugin_import(Mirror VERBOSE)

  # EXTRA_PLUGIN are the one required by plugin loaded by qt_generate_plugin_import
  # It's not automatic yet :( All this workflow might change in future version of qt
  # with better and better cmake support
  qt_generate_qml_plugin_import(Mirror
    QML_SRC ${CMAKE_CURRENT_SOURCE_DIR}/qml
    EXTRA_PLUGIN
      QtQuickVirtualKeyboardPlugin
      QtQuickVirtualKeyboardSettingsPlugin
      QtQuickVirtualKeyboardStylesPlugin
      QmlFolderListModelPlugin
      QQuickLayoutsPlugin
    VERBOSE
  )

endif()

# This target needs to be linked after qt_generate_qml_plugin_import call.
# This is hiding a bug somewhere ...
if(TARGET Qt6::QmlWorkerScript)
  target_link_libraries(Mirror PRIVATE Qt6::QmlWorkerScript)
endif()

if(${CMAKE_SYSTEM_NAME} STREQUAL "iOS")
  include(cmake/FetchQtIosCMake.cmake)
  add_qt_ios_app(Mirror VERBOSE)
endif()

if(${CMAKE_SYSTEM_NAME} STREQUAL "Emscripten")
  include(cmake/FetchQtWasmCMake.cmake)
  add_qt_wasm_app(Mirror)
endif()
