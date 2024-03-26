qt_add_library(Panels STATIC)
qt_add_qml_module(extra_module
    URI "ExtraModule"
    VERSION 1.0
    QML_FILES
        Info/home.qml
)
