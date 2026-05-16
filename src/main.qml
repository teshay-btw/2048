import QtQuick 2.9
import QtQuick.Window 2.2
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls.Material 2.15
import QtMultimedia

Window {
    id: window
    visible: true
    width: 490
    minimumWidth: 490
    maximumWidth: 490
    height: 570
    minimumHeight: 570
    maximumHeight: 570
    title: "2048"

    
    SoundEffect {
        id: beep_1
        source: "qrc:/qt/qml/2048_release/pop_sound.wav"
        volume: 0.2
    }
    SoundEffect {
        id: beep_2
        source: "qrc:/qt/qml/2048_release/beep_2.wav"
        volume: 0.1
    }
    SoundEffect {
        id: beep_3
        source: "qrc:/qt/qml/2048_release/beep_3.wav"
        volume: 0.2
    }
    SoundEffect {
        id: beep_4
        source: "qrc:/qt/qml/2048_release/beep_4.wav"
        volume: 0.2
    }
    


    property string theme: "Normal"
    property string text_color: "black"
    property string sound: ""
   // property var added_coords 

    function set_sound(sound_func) {
        sound = sound_func    
    }
    function set_rules_menu_button_text(text) {
        rules_menu_button.rules_current_option = text
    }
    function set_theme_menu_button_text(text) {
        theme_menu_button.theme_current_option = text
    }
    //function set_added_coords(added_coords_arg) {
       // window.added_coords = added_coords_arg
   // }


    function set_dark_theme() {
        theme_menu_button.theme_current_option = "Dark"
        window.theme = "Dark"

        link.link_color = "#7878FF"
        window.color = "#262626"
        settings.color = "#262626"
        window.text_color = "white"
        main_rectangle.color = "#383838"
        button_new_game_background.color = "#636363"
        button_new_game_text.color = "white"
        score_rectangle.color = "#636363"
        score_text.color = "#DEDEDE"
        button_try_again_background.color = "#636363"
        lost_screen_text.color = "#636363"

        button_new_game_background.border.color = "#FFFF0A"
        button_new_game_background.border.width = 0

        score_rectangle.border.color =  ""
        score_rectangle.border.width = 0

        button_try_again_background.border.color =  ""
        button_try_again_background.border.width = 0
             
        best_score_rectangle.border.color =  ""
        best_score_rectangle.border.width = 0
        best_score_rectangle.color = "#636363"
        best_score_text.color = "#DEDEDE"

        main_rectangle.border.color = ""
        main_rectangle.border.width = 0

        rules_menu_button_background.border.color = "black"
        theme_menu_button_background.border.color = "black"
        sounds_menu_button_background.border.color = "black"

        classic_rules_text_1.color = "grey"
        classic_rules_text_2.color = "grey"
        classic_rules_text_3.color = "grey"
        classic_rules_text_4.color = "grey"
        classic_rules_text_5.color = "grey"
                                
        custom_rules_text_1.color = "grey"
        custom_rules_text_2.color = "grey"
        custom_rules_text_3.color = "grey"
        custom_rules_text_4.color = "grey"
        custom_rules_text_5.color = "grey"
        custom_rules_text_6.color = "grey"

        cross_image.source = "qrc:/qt/qml/2048_release/white_cross.png"
    }

    function set_normal_theme() {
        theme_menu_button.theme_current_option = "Normal"
        window.theme = "Normal"
        window.text_color = "black"
        window.color = "white"
        link.link_color = "green"
        main_rectangle.color = "#B5A89C"
        button_new_game_background.color = "#8f7a66"
        button_new_game_text.color = "white"
        settings.color = "white"
                                
        button_try_again_background.color = "#8f7a66"
        lost_screen_text.color = "#8f7a66"

        button_new_game_background.border.color = "#FFFF0A"
        button_new_game_background.border.width = 0


        score_rectangle.color = "#B5A89C"
        score_text.color = "#E8D8D3"
        score_rectangle.border.color =  ""
        score_rectangle.border.width = 0

        best_score_rectangle.border.color =  ""
        best_score_rectangle.border.width = 0
        best_score_rectangle.color = "#B5A89C"
        best_score_text.color = "#E8D8D3"
                            
        button_try_again_background.border.color =  ""
        button_try_again_background.border.width = 0
             
        main_rectangle.border.color = ""
        main_rectangle.border.width =0

        rules_menu_button_background.border.color = "black"
        theme_menu_button_background.border.color = "black"
        sounds_menu_button_background.border.color = "black"

        classic_rules_text_1.color = "grey"
        classic_rules_text_2.color = "grey"
        classic_rules_text_3.color = "grey"
        classic_rules_text_4.color = "grey"
        classic_rules_text_5.color = "grey"
                                
        custom_rules_text_1.color = "grey"
        custom_rules_text_2.color = "grey"
        custom_rules_text_3.color = "grey"
        custom_rules_text_4.color = "grey"
        custom_rules_text_5.color = "grey"
        custom_rules_text_6.color = "grey"

        cross_image.source = "qrc:/qt/qml/2048_release/cross.png"
    }

    function set_neon_theme() {
        theme_menu_button.theme_current_option = "Neon"
        window.theme = "Neon"

        link.link_color = "#FFFF0A"
        window.color = "#F40AFF"
        settings.color = "#F40AFF"
        window.text_color = "white"
        main_rectangle.color = "#D000D4"


        button_new_game_background.color = "#D000D4"
        button_new_game_text.color = "white"
        button_new_game_background.border.color = "#FFFF0A"
        button_new_game_background.border.width = 2

        score_rectangle.color = "#D000D4"
        score_rectangle.border.color =  "#FFFF0A"
        score_rectangle.border.width = 2
        score_text.color = "#DEDEDE"

        best_score_rectangle.border.color =  "#FFFF0A"
        best_score_rectangle.border.width = 2
        best_score_rectangle.color = "#D000D4"
        best_score_text.color = "#DEDEDE"

        button_try_again_background.border.color =  "#FFFF0A"
        button_try_again_background.border.width = 2
        button_try_again_background.color = "#D000D4"

        lost_screen_text.color = "black"
                                

        main_rectangle.border.color = "#FFFF0A"
        main_rectangle.border.width = 2

        rules_menu_button_background.border.color = "#FFFF0A"
        theme_menu_button_background.border.color = "#FFFF0A"
        sounds_menu_button_background.border.color = "#FFFF0A"

        classic_rules_text_1.color = "white"
        classic_rules_text_2.color = "white"
        classic_rules_text_3.color = "white"
        classic_rules_text_4.color = "white"
        classic_rules_text_5.color = "white"
                                
        custom_rules_text_1.color = "white"
        custom_rules_text_2.color = "white"
        custom_rules_text_3.color = "white"
        custom_rules_text_4.color = "white"
        custom_rules_text_5.color = "white"
        custom_rules_text_6.color = "white"

        cross_image.source = "qrc:/qt/qml/2048_release/white_cross.png"
    }

    Component.onCompleted: {
        if (rules_menu_button.text === "Custom") {
            custom_rules_text.visible = true
            classic_rules_text.visible = false
        }
        else if (rules_menu_button.text === "Classic") {
            custom_rules_text.visible = false
            classic_rules_text.visible = true
        }
    }

    Rectangle {
        id: main_rectangle
        anchors.horizontalCenter: parent.horizontalCenter
        y: 8
        width: 470
        height: 470
        color: "#B5A89C"
        radius: 8
        
        focus: true
        Keys.onLeftPressed: {
            backend.left_pressed()
            if (window.sound === "1") {
                beep_1.play()
            }
            else if (window.sound === "2") {
                beep_2.play()
            }
            else if (window.sound === "3") {
                beep_3.play()
            }
            else if (window.sound === "4") {
                beep_4.play()
            }
        }
        Keys.onRightPressed: {
            backend.right_pressed()
            if (window.sound === "1") {
                beep_1.play()
            }
            else if (window.sound === "2") {
               beep_2.play()
            }
            else if (window.sound === "3") {
                beep_3.play()
            }
            else if (window.sound === "4") {
                beep_4.play()
            }
        }

        Keys.onUpPressed: {
            backend.up_pressed()
            if (window.sound === "1") {
              beep_1.play()
            }
            else if (window.sound === "2") {
                beep_2.play()
            }
            else if (window.sound === "3") {
                beep_3.play()
            }
            else if (window.sound === "4") {
                beep_4.play()
            }
        }
        Keys.onDownPressed: {
            backend.down_pressed()
            if (window.sound === "1") {
                beep_1.play()
            }
            else if (window.sound === "2") {
                beep_2.play()
            }
            else if (window.sound === "3") {
                beep_3.play()
            }
            else if (window.sound === "4") {
               beep_4.play()
            }
        }

        Keys.onPressed: (event)=> {
            if (event.key == Qt.Key_A) {
                backend.left_pressed()
                if (window.sound === "1") {
                beep_1.play()
                }
                else if (window.sound === "2") {
                    beep_2.play()
                }
                else if (window.sound === "3") {
                    beep_3.play()
                }
                else if (window.sound === "4") {
                   beep_4.play()
                }
            }
            if (event.key == Qt.Key_S) {
                backend.down_pressed()
                if (window.sound === "1") {
                beep_1.play()
                }
                else if (window.sound === "2") {
                    beep_2.play()
                }
                else if (window.sound === "3") {
                    beep_3.play()
                }
                else if (window.sound === "4") {
                   beep_4.play()
                }
            }
            if (event.key == Qt.Key_D) {
                backend.right_pressed()
                if (window.sound === "1") {
                beep_1.play()
                }
                else if (window.sound === "2") {
                    beep_2.play()
                }
                else if (window.sound === "3") {
                    beep_3.play()
                }
                else if (window.sound === "4") {
                   beep_4.play()
                }
            }
            if (event.key == Qt.Key_W) {
                backend.up_pressed()
                if (window.sound === "1") {
                beep_1.play()
                }
                else if (window.sound === "2") {
                    beep_2.play()
                }
                else if (window.sound === "3") {
                    beep_3.play()
                }
                else if (window.sound === "4") {
                   beep_4.play()
                }
            }
        }
    }
    Column{
       y: 20
       id: board
       objectName: "board"
       anchors.horizontalCenter: parent.horizontalCenter
       spacing: 15

       property int spawned_row;   // для запоминания новой координаты
       property int spawned_col;

       function setTilescale(row, col) {
            spawned_row = row
            spawned_col = col
        }
       
       Repeater {
            model: backend.field   // каждая строка — это QList<int>
            id: row_repeater
            Row {
                spacing: 15


                property alias tileRepeater: column_repeater
                property int rowIndex: index


                Repeater {
                    model: modelData   // это текущая строка (QList<int>)
                    id: column_repeater
                    Rectangle {
                        
                        id: block
                        property int row: rowIndex  /// дает номер строки
                        property int col: index   //// встроенная переменная внутри каждого repeater, дает номер столбца

                        color: {
                            if (window.theme === "Normal") {
                                return modelData === 0 ? "#CCBBB4"
                                : modelData === 2 ? "#eee4da"
                                : modelData === 4 ? "#ede0c8"
                                : modelData === 8 ? "#f2b179" 
                                : modelData === 16 ? "#f59563" 
                                : modelData === 32 ? "#f67c5e"
                                : modelData === 64 ? "#f65e3b" 
                                : modelData === 128 ? "#edcf72"
                                : modelData === 256 ? "#FFCE47"  
                                : modelData === 512 ? "#EBE52F"
                                : modelData === 1024 ? "#ffd447"
                                : modelData === 2048 ? "#ffbf00"
                                : modelData === 4096 ? "#ff9c00"
                                : modelData === 8192 ? "#ff5e00"
                                : modelData === 16384 ? "#ff0066"
                                : modelData === 32768 ? "#cc00ff"
                                : modelData === 65536 ? "#9900ff"
                                : modelData === 131072 ? "#8400FF"
                                : ""
                            }
                            else if (window.theme === "Dark") {
                                return modelData === 0 ? "#424242"
                                : modelData === 2 ? "#757575"
                                : modelData === 4 ? "#919191"
                                : modelData === 8 ? "#BDBDBD" 
                                : modelData === 16 ? "#E6E6E6" 
                                : modelData === 32 ? "#F5F5F5"
                                : modelData === 64 ? "#DEF2FF" 
                                : modelData === 128 ? "#BDE6FF"
                                : modelData === 256 ? "#A8DDFF"  
                                : modelData === 512 ? "#85D0FF"
                                : modelData === 1024 ? "#62C1FC"
                                : modelData === 2048 ? "#1CA9FF"
                                : modelData === 4096 ? "#008ADE"
                                : modelData === 8192 ? "#005D99"
                                : modelData === 16384 ? "#00497A"
                                : modelData === 32768 ? "#003152"
                                : modelData === 65536 ? "#001829"
                                : modelData === 131072 ? "#000000"
                                : ""
                            }
                            else if (window.theme === "Neon") {
                                return modelData === 0 ? "#E200EB"
                                : modelData === 2 ? "#F545FF"
                                : modelData === 4 ? "#F566FF"
                                : modelData === 8 ? "#FA38FF" 
                                : modelData === 16 ? "#F600FF" 
                                : modelData === 32 ? "#E700F0"
                                : modelData === 64 ? "#F000D8" 
                                : modelData === 128 ? "#FF00C6"
                                : modelData === 256 ? "#FF1CCE"  
                                : modelData === 512 ? "#FF45D8"
                                : modelData === 1024 ? "#FF66E0"
                                : modelData === 2048 ? "#FF99EE"
                                : modelData === 4096 ? "#FFCCF6"
                                : modelData === 8192 ? "#FFE6FA"
                                : modelData === 16384 ? "#FFF0D5"
                                : modelData === 32768 ? "#FFF6C2"
                                : modelData === 65536 ? "#FFF56E"
                                : modelData === 131072 ? "#FFF626"
                                : ""
                            }
                        }
                        Behavior on scale {
                            PropertyAnimation {
                                duration: 100
                            }
                        }



                        scale: 1
                        radius: 3
                        height: 100
                        width: 100
                        Text {
                            id: number
                            rightPadding: 20
                            leftPadding: 20
                            text: modelData === 0 ? "" : modelData // конкретный блок
                            property string previous_text: ""
                            color: {
                                if (window.theme === "Normal") {
                                    return modelData === 0 ? ""
                                    : modelData === 2 ? "#776e65"
                                    : modelData === 4 ? "#776e65"
                                    : "white"
                                }
                                else if (window.theme === "Dark") {
                                    return modelData === 0 ? ""
                                    : modelData === 2 ? "white"
                                    : modelData === 4 ? "white"
                                    : modelData === 1024 ? "#776e65"
                                    : modelData === 2048 ? "#776e65"
                                    : modelData === 4096 ? "white"
                                    : modelData === 8192 ? "white"
                                    : modelData === 16384 ? "white"
                                    : modelData === 32768 ? "white"
                                    : modelData === 65536 ? "white"
                                    : modelData === 131072 ? "white"
                                    : "#776e65"
                                }
                                else if (window.theme === "Neon") {
                                    return modelData === 0 ? ""
                                    : modelData === 1024 ? "white"
                                    : modelData === 4096 ? "#776e65"
                                    : modelData === 8192 ? "#776e65"
                                    : modelData === 16384 ? "#776e65"
                                    : modelData === 32768 ? "#776e65"
                                    : modelData === 65536 ? "#776e65"
                                    : modelData === 131072 ? "#776e65"
                                    : "white"
                                }
                            }
                            anchors.centerIn: parent
                            font.pixelSize: modelData === 1024 ? 35 
                            : modelData === 2048 ? 35
                            : modelData === 256 ? 38
                            : modelData === 512 ? 38
                            : modelData === 2048 ? 35
                            : modelData === 4096 ? 35
                            : modelData === 8192 ? 33
                            : modelData === 16384 ? 32
                            : modelData === 32768 ? 30
                            : modelData === 65536 ? 30
                            : modelData === 131072 ? 25
                            : 45
                            font.family: "Segoe UI"
                            font.bold: true
                            onTextChanged: {
                                if (board.spawned_row === block.row && board.spawned_col === block.col) {
                                    block.scale = 0
                                    Qt.callLater(() => block.scale = 1)   // вызываем на один фрейм позже чтобы защитало изменение и анимация сработала
                                }
                            }
                        }

                    }
                    

                }
            }
       }
       
    }


    /////////// MADE BY TEXT
    Column {
        anchors.horizontalCenter: parent.left
        anchors.horizontalCenterOffset: 70
        anchors.verticalCenter: parent.bottom
        anchors.verticalCenterOffset: -17
        bottomPadding: 2
        Row {
            Text {
                text: "Made by "
                color: window.text_color
                font.pixelSize: 14
                font.letterSpacing: 0.4
            }
            Text {

                property string link_color: "green"
                id: link
                text: "teshay"
                color: link_color
                font.pixelSize: 14
                font.underline: false
                
                MouseArea {
                    anchors.fill: parent
                    
                    hoverEnabled: true
                    cursorShape: Qt.PointingHandCursor
                    onEntered:  {
                        link.font.underline = true
                        link.color = link.link_color
                    }
                    onExited: {
                        link.color = link.link_color
                        link.font.underline = false
                    }
                    onClicked: Qt.openUrlExternally("https://github.com/teshay-btw")
                }
            }
        }
    }
    ///////////////



    /////////// NEW GAME BUTTON
    Button {
        Material.theme: Material.Light
        Material.accent: "transparent"
        Material.primary: "transparent"
        Material.background: "transparent"
        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset: 220
        anchors.horizontalCenter: parent.left
        anchors.horizontalCenterOffset: 72
        hoverEnabled: true
        id: button_new_game
        contentItem: Text {
            id: button_new_game_text
            text: "New Game"
            font.pixelSize: 16
            color: "white"
            font.bold: true
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.margins: 0
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            anchors.topMargin: 12
        }
        MouseArea {
            id: button_new_game_mousearea
            objectName: "button_new_game_mousearea"
            anchors.fill: parent
            hoverEnabled: true
            cursorShape: Qt.PointingHandCursor
            onClicked: {
                backend.restart()
            }
        }
        background: Rectangle {
            id: button_new_game_background
            color: "#8f7a66"
            radius: 3
        }
    }
    ////////////


    property int score: 1
    function update_score(new_score) {
        score = new_score        
    }



    //////////// SCORE RECTANGLE
    Rectangle{
        id: score_rectangle
        width: 120
        height: 60
        color: "#B5A89C"
        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset: 230
        anchors.horizontalCenter: parent.right
        anchors.horizontalCenterOffset: -70
        radius: 5
        Column {
            topPadding: 5
            anchors.horizontalCenter: parent.horizontalCenter
            Text {
                anchors.horizontalCenter: parent.horizontalCenter
                text: "SCORE"
                font.bold: true
                id: score_text
                color: "#E8D8D3"
                font.pixelSize: 15
            }
            Text {
                id: score_score
                objectName: "score_text"
                anchors.horizontalCenter: parent.horizontalCenter
                font.letterSpacing: 1
                text: "0"
                font.bold: true
                font.pixelSize: 25
                color: "white"
            }
        }
        
    }
    ///////////////

    ////// BEST SCORE RECTANGLE
    Rectangle{
        id: best_score_rectangle
        width: 120
        height: 60
        color: "#B5A89C"
        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset: 230
        anchors.horizontalCenter: parent.right
        anchors.horizontalCenterOffset: -200
        radius: 5
        Column {
            topPadding: 5
            anchors.horizontalCenter: parent.horizontalCenter
            Text {
                anchors.horizontalCenter: parent.horizontalCenter
                text: "BEST"
                font.bold: true
                id: best_score_text
                color: "#E8D8D3"
                font.pixelSize: 15
            }
            Text {
                id: best_score_score
                objectName: "best_score_text"
                anchors.horizontalCenter: parent.horizontalCenter
                font.letterSpacing: 1
                text: "0"
                font.bold: true
                font.pixelSize: 25
                color: "white"
            }
        }
        
    }
    //////////////

    ////// LOST SCREEN
    Item {
        id: lost_screen
        objectName: "lost_screen"
        opacity: 0
        width: parent.width
        height: parent.height
        focus: true
        
        Behavior on opacity {
            PropertyAnimation { 
                duration: 1000
            }
           
        }
        Rectangle {
            anchors.fill: parent
            color: Qt.rgba(234, 136, 136, 0.51)
            width: parent.width
            height: parent.height
            
            Text {
                id: lost_screen_text
                text: "Game over!"
                font.bold: true
                font.pixelSize: 50
                anchors.verticalCenter: parent.verticalCenter
                anchors.verticalCenterOffset: -40
                anchors.horizontalCenter: parent.horizontalCenter
                color: "#8f7a66"
            }
        
            Behavior on opacity {
                PropertyAnimation { 
                    duration: 1000
                }
                
                
            }
        }
        /////////////




        ////////// TRY AGAIN BUTTON
        Button {
            anchors.verticalCenterOffset: 40
            Material.theme: Material.Light
            Material.accent: "transparent"
            Material.primary: "transparent"
            Material.background: "transparent"
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            hoverEnabled: true
            contentItem: Text {
                id: button_try_again_text
                text: "Try again"
                font.pixelSize: 16
                color: "white"
                font.bold: true
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.margins: 0
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                anchors.topMargin: 12
            }
            MouseArea {
                id: restart_button_mousearea
                objectName: "mouse_area"
                anchors.fill: parent
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
                onClicked: {
                    restart_button_mousearea.focus = false
                    backend.restart()
                    lost_screen.opacity = 0
                    lost_screen.focus = false
                    main_rectangle.focus = true
                    restart_button_mousearea.visible = false
                    lost_screen.focus = false
                    button_new_game_mousearea.enabled = true
                    settings_button_mousearea.enabled = true
                }
            }
            background: Rectangle {
                id: button_try_again_background
                color: "#8f7a66"
                radius: 3
            }
        }
    }
    //////////////////





    ///////// SETTINGS BUTTON
    Button {
        id: settings_button
        width: 40
        height: 40
        background: Rectangle { color: "transparent" }
        anchors.verticalCenter: parent.bottom
        anchors.verticalCenterOffset: -60
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.horizontalCenterOffset: -65
       
        MouseArea {
            id: settings_button_mousearea
            objectName: "settings_button_mousearea"
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor 
            onClicked: {
                settings.visible = true
                settings_button.visible = false
                button_new_game.visible = false
            }
        }
        Image {
            source: "qrc:/qt/qml/2048_release/settings_icon.png"
            width: 40
            height: 40
        }
    }
    /////////////
    
    ///////////// SETTINGS RECTANGLE
    Rectangle {
        id: settings
        color: "white"
        anchors.fill: parent 
        visible: false
        Button {
            id: settings_close
            width: 20
            height: 20
            background: Rectangle { color: "transparent" }
            anchors.verticalCenter: parent.verticalCenter
            anchors.verticalCenterOffset: -250
            anchors.horizontalCenter: parent.left
            anchors.horizontalCenterOffset: 30

       
            MouseArea {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor 
                onClicked: {
                    settings.visible = false
                    settings_button.visible = true
                    button_new_game.visible = true
                    main_rectangle.focus = true
                }
            }
            Image {
                id: cross_image
                source: "qrc:/qt/qml/2048_release/cross.png"
                width: 20
                height: 20
            }
        }
        Column {
            id: settings_column
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            
            Row {
                spacing: 6
                
                Text {
                    id: text1
                    font.pointSize: 15
                    text: "Sounds: "
                    font.letterSpacing: 1
                    color: window.text_color
                    anchors.verticalCenter: parent.verticalCenter
                }

                Button {
                    property string sounds_current_option: "No sound"
                    text: sounds_current_option
                    font.pixelSize: 16
                    width: 80
                    height: 40
                    topPadding: 0
                    bottomPadding: 0
                    rightPadding: 0
                    leftPadding: 0
                    id: sounds_menu_button
                    objectName: "sounds_menu_button"
                    background: Rectangle {
                        id: sounds_menu_button_background
                        radius: 2
                        border.color: "black"
                        border.width: 2

                    }
                    MouseArea {
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: sounds_options_menu.open()
                    }
                    

                    

                    Menu {
                        id: sounds_options_menu
                        width: 110
                            
                        y: sounds_menu_button.height
                        font.pixelSize: 16
                        font.letterSpacing: 1
                        MenuItem {
                            text: "No sound"
                            width: 110
                            height: 50
                            onTriggered: {
                                sounds_menu_button.sounds_current_option = "No sound"
                                window.sound = ""
                                backend.set_sound(0)
                            }
                        }

                        MenuItem {
                            text: "1"
                            width: 110
                            height: 50
                            onTriggered: {
                                sounds_menu_button.sounds_current_option = "1"
                                window.sound = "1"
                                beep_1.play()
                                backend.set_sound(1)
                            }   
                        }
                        MenuItem {
                            text: "2"
                            width: 110
                            height: 50
                            onTriggered: {
                                sounds_menu_button.sounds_current_option = "2"
                                window.sound = "2"
                                beep_2.play()
                                backend.set_sound(2)
                            }   
                        }
                        MenuItem {
                            text: "3"
                            width: 110
                            height: 50
                            onTriggered: {
                                sounds_menu_button.sounds_current_option = "3"
                                window.sound = "3"
                                beep_3.play()
                                backend.set_sound(3)
                            }   
                        }
                        MenuItem {
                            text: "4"
                            width: 110
                            height: 50
                            onTriggered: {
                                sounds_menu_button.sounds_current_option = "4"
                                window.sound = "4"
                                beep_4.play()
                                backend.set_sound(4)
                            }   
                        }
                    }
                }
                
            }
            Row {
                spacing: 14
                Text {
                    anchors.verticalCenter: parent.verticalCenter
                    font.pointSize: 15
                    text: "Theme: "
                    font.letterSpacing: 1
                    color: window.text_color
                }
                Button {
                    property string theme_current_option: "Normal"
                    id: theme_menu_button
                    text: theme_current_option
                    font.pixelSize: 16
                    width: 80
                    height: 40
                    topPadding: 0
                    bottomPadding: 0
                    rightPadding: 0
                    leftPadding: 0
                    
                    background: Rectangle {
                        id: theme_menu_button_background
                        radius: 2
                        border.color: "black"
                        border.width: 2

                    }

                    onClicked: optionsMenu.open()

                    Menu {
                        id: optionsMenu
                        width: 110
                            
                        // Позиционирование меню под кнопкой
                        y: theme_menu_button.height
                        font.pixelSize: 16
                        font.letterSpacing: 1
                        MenuItem {
                            text: "Normal"
                            width: 110
                            height: 50
                            onTriggered: {
                                window.set_normal_theme()
                                backend.set_theme(0)
                            }

                        }

                        MenuItem {
                            text: "Dark"
                            width: 110
                            height: 50
                            onTriggered: {
                                window.set_dark_theme()
                                backend.set_theme(1)
                            }   
                        }

                        MenuItem {
                            text: "Neon"
                            width: 110
                            height: 50
                            onTriggered: {
                                window.set_neon_theme()
                                backend.set_theme(2)
                            }  
                        }
                    }
                }
            }



            Row {
                spacing: 26
                Text {
                    anchors.verticalCenter: parent.verticalCenter
                    font.pointSize: 15
                    text: "Rules: "
                    font.letterSpacing: 1
                    color: window.text_color
                }
                Button {
                    property string rules_current_option: "Custom"
                    text: rules_current_option
                    font.pixelSize: 16
                    width: 80
                    height: 40
                    topPadding: 0
                    bottomPadding: 0
                    rightPadding: 0
                    leftPadding: 0
                    objectName: "rules_menu_button"
                    id: rules_menu_button
                    background: Rectangle {
                        id: rules_menu_button_background
                        radius: 2
                        border.color: "black"
                        border.width: 2

                    }

                    onClicked: rules_options_menu.open()

                    Menu {
                        id: rules_options_menu
                        width: 110
                            
                        // Позиционирование меню под кнопкой
                        y: rules_menu_button.height
                        font.pixelSize: 16
                        font.letterSpacing: 1
                        MenuItem {
                            text: "Classic"
                            width: 110
                            height: 50
                            onTriggered: {
                                rules_menu_button.rules_current_option = "Classic"
                                backend.set_game_mode(0)
                                custom_rules_text.visible = false
                                classic_rules_text.visible = true
                            }
                        }

                        MenuItem {
                            text: "Custom"
                            width: 110
                            height: 50
                            onTriggered: {
                                rules_menu_button.rules_current_option = "Custom"
                                backend.set_game_mode(1)
                                custom_rules_text.visible = true
                                classic_rules_text.visible = false
                            }   
                        }
                    }
                }
            }
        }
        Column {
            id: custom_rules_text
            objectName: "custom_rules_text"
            anchors.verticalCenter: parent.bottom
            anchors.verticalCenterOffset: -53
            anchors.horizontalCenter: parent.horizontalCenter
            visible: true
            
            Text {
                id: custom_rules_text_1
                anchors.horizontalCenter: parent.horizontalCenter
                font.pointSize: 9
                text: "Custom rules"
                font.letterSpacing: 1
                color: "gray"
            }
            Text {
                id: custom_rules_text_2
                font.pointSize: 9
                text: "A new tile is spawned each time, regardless of whether the others have"
                font.letterSpacing: 1
                color: "gray"
            }
            Text {
                id: custom_rules_text_3
                anchors.horizontalCenter: parent.horizontalCenter
                font.pointSize: 9
                text: "moved or merged into one."
                font.letterSpacing: 1
                color: "gray"
            }
            Text {
                id: custom_rules_text_4
                font.pointSize: 9
                anchors.horizontalCenter: parent.horizontalCenter
                text: "The spawned tile can be only 2."
                font.letterSpacing: 1
                color: "gray"
            }
            Text {
                id: custom_rules_text_5
                anchors.horizontalCenter: parent.horizontalCenter
                font.pointSize: 9
                text: "Connection order: 222 -> 42"
                font.letterSpacing: 1
                color: "gray"
            }
            Text {
                id: custom_rules_text_6
                anchors.horizontalCenter: parent.horizontalCenter
                font.pointSize: 9
                text: "Tiles can be connected several times into one, e.g. 2222 -> 8"
                font.letterSpacing: 1
                color: "gray"
            }
        }
        Column {
            id: classic_rules_text
            objectName: "classic_rules_text"
            anchors.verticalCenter: parent.bottom
            anchors.verticalCenterOffset: -45
            anchors.horizontalCenter: parent.horizontalCenter
            visible: false
            
            Text {
                id: classic_rules_text_1
                anchors.horizontalCenter: parent.horizontalCenter
                font.pointSize: 9
                text: "Classic rules"
                font.letterSpacing: 1
                color: "gray"
            }
            Text {
                id: classic_rules_text_2
                anchors.horizontalCenter: parent.horizontalCenter
                font.pointSize: 9
                text: "A new tile will only spawn if there was movement or merging."
                font.letterSpacing: 1
                color: "gray"
            }
            Text {
                id: classic_rules_text_3
                font.pointSize: 9
                anchors.horizontalCenter: parent.horizontalCenter
                text: "The spawned tile can be 2 or 4."
                font.letterSpacing: 1
                color: "gray"
            }
            Text {
                id: classic_rules_text_4
                anchors.horizontalCenter: parent.horizontalCenter
                font.pointSize: 9
                text: "Connection order: 222 -> 24"
                font.letterSpacing: 1
                color: "gray"
            }
            Text {
                id: classic_rules_text_5
                anchors.horizontalCenter: parent.horizontalCenter
                font.pointSize: 9
                text: "Tiles cannot be combined multiple times into one, e.g. 2222 -> 44"
                font.letterSpacing: 1
                color: "gray"
            }
        }

    }
    
}
