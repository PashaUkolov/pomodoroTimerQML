import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

Item {
    property color mainColor: "#f04042"
    property color mainColorAccent: "#f04042"

    property int currentRotation: 0
    property int currentTimeMinutes: 0
    property int currentTimeSeconds: 0

    function deg2rad(degrees) {
        return degrees * (Math.PI / 180);
    }

    function deg2minutes(degrees) {
        return degrees * 60 / 360;
    }

    function minutes2deg(minutes) {
        return minutes * 360 / 60
    }

    function seconds2deg(seconds) {
        return seconds * 360 / 3600
    }

    Timer {
        id: timer
        interval: 1000
        running: false
        repeat: true
        onTriggered: {
            console.log(currentTimeSeconds)
            if(currentTimeSeconds % 60 == 0) {
                currentTimeMinutes -= 1
            }
            currentTimeSeconds -= 1

            shapeDial.clockRotation = seconds2deg(currentTimeSeconds)
            if(currentTimeSeconds <= 0) {
                currentTimeSeconds = 0
                timer.running = false
            }
        }
    }

    Item {
        id: bg
        anchors.fill: parent
        Rectangle {
            x: 20; y: 20
            width: 200; height: 200
            anchors.fill: parent
            color: mainColor
        }
    }

    ColumnLayout {
        anchors.fill: parent

        CircularSlider {
            id: mainTimer
        }

        Rectangle {
            width: 200
            height: 60
            Layout.alignment: Qt.AlignTop | Qt.AlignHCenter
            radius: 10
            color: "#fff0f0f0"
            Button {
                property bool isPressed: false
                id: startButton

                x: 0; y: -8
                flat: true
                down: false
                highlighted: false

                contentItem: Text {
                    text: startButton.isPressed ? "Stop" : "Start"
                    font.pointSize: 18
                    opacity: enabled ? 1.0 : 0.3
                    color: mainColor
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    elide: Text.ElideRight
                }

                onClicked: {
                    isPressed = !isPressed
                    if(isPressed) {
                        bg.bgColor = "red"
                        startButton.y = -4
                        timer.start()
                    } else {
                        startButton.y = -8
                        timer.stop()
                    }
                }

                background: Rectangle {
                    implicitWidth: 200
                    implicitHeight: 60
                    radius: 10
                    MouseArea {
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                    }
                }
            }
        }
    }
}
