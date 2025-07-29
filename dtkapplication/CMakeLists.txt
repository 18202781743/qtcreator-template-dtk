cmake_minimum_required(VERSION 3.16)

project(%{ProjectName} VERSION 1.0.0 LANGUAGES CXX)

# Set C++ standard to C++17 (required for Qt6, compatible with Qt5)
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# Enable Qt's automatic processing
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_AUTOUIC ON)

# Qt version selection from wizard
option(USE_QT6 "Use Qt6 instead of Qt5" %{JS: %{UseQt6} ? 'ON' : 'OFF'})

# Set Qt version major number
if(USE_QT6)
    set(QT_VERSION_MAJOR 6)
else()
    set(QT_VERSION_MAJOR 5)
endif()

# Configure Qt and DTK based on version
if(QT_VERSION_MAJOR EQUAL 6)
    # Qt6 configuration
    find_package(Qt6 REQUIRED COMPONENTS Core Widgets)
    find_package(Dtk6 REQUIRED COMPONENTS Widget)
    set(DTK_VERSION_MAJOR 6)
else()
    # Qt5 configuration
    find_package(Qt5 REQUIRED COMPONENTS Core Widgets)
    find_package(Dtk REQUIRED COMPONENTS Widget)
    set(DTK_VERSION_MAJOR "")
endif()

# Create executable
add_executable(${PROJECT_NAME} "%{CppFileName}" resources.qrc)

# Set platform-specific properties
set_target_properties(${PROJECT_NAME} PROPERTIES
    WIN32_EXECUTABLE $<PLATFORM_ID:Windows>
    MACOSX_BUNDLE $<PLATFORM_ID:Darwin>
)

# Link libraries
target_link_libraries(${PROJECT_NAME} PRIVATE
    Qt${QT_VERSION_MAJOR}::Core
    Qt${QT_VERSION_MAJOR}::Widgets
    Dtk${DTK_VERSION_MAJOR}::Widget
)

# Compiler warnings
target_compile_options(${PROJECT_NAME} PRIVATE
    $<$<CXX_COMPILER_ID:MSVC>:/W4>
    $<$<NOT:$<CXX_COMPILER_ID:MSVC>>:-Wall -Wextra -Wpedantic>
)
