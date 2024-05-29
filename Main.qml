import QtQuick
import QtQuick.Window
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Dialogs
import QtQuick.Shapes
//import QtMultimedia

Window {
    width: 400
    height: 600
    visible: true
    title: qsTr("Pomodoro timer")
    color: "Black"

    StackLayout {
        id: timerView
        currentIndex: bar.currentIndex
        anchors.fill: parent

        property color currentColor: "red"

        TimerView {
            anchors.fill: parent
            mainColor: "#F04042"
            mainColorAccent: "#B72424"
        }
        TimerView {
            anchors.fill: parent
            mainColor: "#4C9196"
            mainColorAccent: "#386A6E"
        }
        TimerView {
            anchors.fill: parent
            mainColor: "#4D7FA2"
            mainColorAccent: "#375A73"
        }
    }

    TabBar {
        id: bar
        property color tabColor: "red"
        background: Rectangle {
            id: tabBg
            color: {
                if(bar.currentIndex === 0) {
                    "#F04042"
                } else if(bar.currentIndex === 1) {
                    "#4C9196"
                } else {
                    "#4D7FA2"
                }
            }
        }
        width: parent.width
        CTabButton {
            text: qsTr("Pomodoro")
            tabButtonColor: bar.currentIndex === 0 ? "#B72424" : "transparent"
        }
        CTabButton {
            text: qsTr("Short Break")
            tabButtonColor: bar.currentIndex === 1 ? "#386A6E" : "transparent"
        }
        CTabButton {
            text: qsTr("Long Break")
            tabButtonColor: bar.currentIndex === 2 ? "#375A73" : "transparent"
        }
    }
}
