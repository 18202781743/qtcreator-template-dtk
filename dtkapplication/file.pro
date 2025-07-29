# DTK Application Project File
# Supports both Qt5 and Qt6 based on user selection

# Qt version selection from wizard
%{JS: %{UseQt6} ? 'USE_QT6 = true' : 'USE_QT6 = false'}

# Configure Qt and DTK based on version
contains(USE_QT6, true) {
    # Qt6 configuration
    QT += core gui widgets
    CONFIG += c++17
    
    CONFIG += link_pkgconfig
    PKGCONFIG += dtk6widget
    
} else {
    # Qt5 configuration
    QT += core gui widgets
    CONFIG += c++17
    greaterThan(QT_MAJOR_VERSION, 4): QT += widgets
    
    CONFIG += link_pkgconfig
    PKGCONFIG += dtkwidget
}

TARGET = %{ProjectName}
TEMPLATE = app

SOURCES += \
        %{CppFileName}

RESOURCES += \
        resources.qrc

# Platform-specific configurations
win32 {
    CONFIG += windows
}

macx {
    CONFIG += app_bundle
}
