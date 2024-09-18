
```log
QXcbIntegration: Cannot create platform OpenGL context, neither GLX nor EGL are enabled
Attribute Qt::AA_UseSoftwareOpenGL must be set before QCoreApplication is created.
```
与以下环境变量有关

```
export QT_QPA_PLATFORM_PLUGIN_PATH=$dirname/plugins

export QML2_IMPORT_PATH=$dirname/qml2

export QTWEBENGINEPROCESS_PATH=$dirname/QtWebEngineProcess

```