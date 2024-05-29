import QtQuick
import QtQuick.Window
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Dialogs
import QtQuick.Shapes
import "ui"
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
            mainColor: "#F04042"
            mainColorAccent: "#B72424"
        }
        TimerView {
            mainColor: "#4C9196"
            mainColorAccent: "#386A6E"
        }
        TimerView {
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

    Rectangle {
        width: parent.width ; height: 65
        anchors {
            top: bar.bottom
            left: parent.left
            right: parent.right
            topMargin: 20
            leftMargin: 20
            rightMargin: 20
        }

        color: "transparent"
        border.color: "white"
        border.width: 1
        radius: 17
        Text {
            id: header
            text: "Current task"
            font.pointSize: 10
            color: "white"
            anchors {
                top: parent.top
                left: parent.left
                topMargin: 8
                leftMargin: 15
            }
        }

        Text {
            id: description
            text: "Vacuum clean the desert"
            font.pointSize: 16
            color: "white"
            anchors {
                top: header.bottom
                left: parent.left
                leftMargin: 15
            }
        }

        Image {
            id: taskIcon
            height: 40
            width: 40
            fillMode: Image.PreserveAspectFit
            source: "qrc:/assets/tasksIcon.png"
            anchors {
                right: parent.right
                verticalCenter: parent.verticalCenter
                rightMargin: 10
            }
        }

    }

    TasksView {
        width: parent.width
        height: parent.height / 12
        anchors {
            top: bar.bottom
            left: parent.left
            //topMargin: 20
            //leftMargin: 20
        }
    }
}
