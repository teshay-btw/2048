#pragma once
#include "B:\Qt\6.11.0\msvc2022_64\include\QtCore\qobject.h"
#include <vector>

using namespace std;

class Backend :
    public QObject
{
    Q_PROPERTY(QList<QList<int>> field READ field NOTIFY fieldChanged)
        Q_OBJECT


public:
    Backend();
    void setRoot(QObject* root);
    Q_INVOKABLE void left_pressed();
    Q_INVOKABLE void right_pressed();
    Q_INVOKABLE void up_pressed();
    Q_INVOKABLE void down_pressed();
    Q_INVOKABLE void set_game_mode(bool mode);
    void check_loose();
    Q_INVOKABLE void restart();
    Q_INVOKABLE void set_sound(int sound);
    Q_INVOKABLE void set_theme(int theme_func);
    void generate_two();
    QList<QList<int>> field() const { return m_field; }





    QObject* score_text = nullptr;

    int score = 0;
    int best_score = 0;
    bool game_mode = 1;
    int current_sound = 0;
    int theme = 0;
    QVariantList added_coords;

signals:
    void fieldChanged();



private:
    QObject* m_root = nullptr;
    QObject* button_new_game_mousearea = nullptr;
    QObject* settings_button_mousearea = nullptr;
    QObject* best_score_text = nullptr;
    QObject* rules_menu_button = nullptr;
    QObject* sounds_menu_button = nullptr;
    bool can_spawn_two = 0;



    vector <pair<int, int>> free_cells;

    QList<QList<int>> m_field;

};

