#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include "Backend.h"
#include <QQmlContext>
#include <qicon.h>
#define byte win_byte_override
#include <windows.h>
#undef byte

int main(int argc, char* argv[])
{
#if defined(Q_OS_WIN) && QT_VERSION_CHECK(5, 6, 0) <= QT_VERSION && QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif

    QGuiApplication app(argc, argv);
    app.setWindowIcon(QIcon(":/qt/qml/2048_release/icon.png"));
    QQmlApplicationEngine engine;
    Backend backend;
    engine.rootContext()->setContextProperty("backend", &backend);
    engine.load(QUrl(QStringLiteral("qrc:/qt/qml/2048_release/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;


    QObject* root = engine.rootObjects().first();
    backend.setRoot(root);

    QObject* textObj = root->findChild<QObject*>("score_text");

    if (textObj) {
        textObj->setProperty("text", QString::number(backend.score));
    }


    QObject::connect(qApp, &QCoreApplication::aboutToQuit, [&backend]() {
        
        HANDLE save_game_file = CreateFileW(
            L"settings.txt",
            GENERIC_READ | GENERIC_WRITE,
            FILE_SHARE_READ | FILE_SHARE_WRITE,
            NULL,
            OPEN_ALWAYS,
            FILE_ATTRIBUTE_NORMAL,
            NULL
        );
        DWORD bytesWritten;
        string buffer;
        for (int i = 0; i < backend.field().size(); i++) {

            for (int j = 0; j < backend.field()[i].size(); j++) {
                buffer += std::to_string(backend.field()[i][j]);
                buffer += " ";
            }
            buffer += "\n";
        }

        buffer += std::to_string(backend.score);
        buffer += "\n";
        buffer += std::to_string(backend.best_score);
        buffer += "\n";
        buffer += std::to_string(backend.game_mode);
        buffer += "\n";
        buffer += std::to_string(backend.current_sound);
        buffer += "\n";
        buffer += std::to_string(backend.theme);

        WriteFile(save_game_file, buffer.c_str(), buffer.size(), &bytesWritten, NULL);
        CloseHandle(save_game_file);
        });





    return app.exec();
}
